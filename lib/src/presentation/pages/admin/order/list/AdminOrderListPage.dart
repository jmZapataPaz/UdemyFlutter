import 'package:ecommerce_flutter/src/domain/models/Order.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/order/list/AdminOrderListItem.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/order/list/bloc/AdminOrderListBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/order/list/bloc/AdminOrderListEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/order/list/bloc/AdminOrderListState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AdminOrderListPage extends StatefulWidget {
  const AdminOrderListPage({super.key});

  @override
  State<AdminOrderListPage> createState() => _AdminOrderListPageState();
}

class _AdminOrderListPageState extends State<AdminOrderListPage> {
  AdminOrderListBloc? _bloc;
  List<String> statusFilters = ['TODOS', 'CREADO', 'PAGADO', 'ENTREGADO'];
  String selectedFilter = 'TODOS';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _bloc?.add(GetOrders());
    });
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<AdminOrderListBloc>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;

    return Scaffold(
      body: BlocListener<AdminOrderListBloc, AdminOrderListState>(
        listener: (context, state) {
          final responseState = state.response;
          if (responseState is Error) {
            Fluttertoast.showToast(msg: responseState.message, toastLength: Toast.LENGTH_LONG);
          }
        },
        child: Column(
          children: [
            _buildFilterChips(context, isTablet),
            Expanded(
              child: BlocBuilder<AdminOrderListBloc, AdminOrderListState>(
                builder: (context, state) {
                  final responseState = state.response;
                  if (responseState is Success) {
                    List<Order> orders = responseState.data as List<Order>;
                    List<Order> filteredOrders = _filterOrders(orders, selectedFilter);
                    if (filteredOrders.isEmpty) {
                      return Center(child: Text('No hay órdenes con ese filtro'));
                    }
                    return ListView.builder(
                      itemCount: filteredOrders.length,
                      itemBuilder: (context, index) {
                        return AdminOrderListItem(filteredOrders[index]);
                      }
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Order> _filterOrders(List<Order> orders, String filter) {
    if (filter == 'TODOS') return orders;
    return orders.where((order) => order.status == filter).toList();
  }

  Widget _buildFilterChips(BuildContext context, bool isTablet) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * (isTablet ? 0.08 : 0.07),
      margin: EdgeInsets.symmetric(
        vertical: screenHeight * (isTablet ? 0.01 : 0.008),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * (isTablet ? 0.02 : 0.03),
        ),
        itemCount: statusFilters.length,
        itemBuilder: (context, index) {
          String status = statusFilters[index];
          bool isSelected = selectedFilter == status;

          return Container(
            margin: EdgeInsets.only(
              right: screenWidth * (isTablet ? 0.015 : 0.02),
            ),
            child: FilterChip(
              label: Text(
                status,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[700],
                  fontSize: screenWidth * (isTablet ? 0.025 : 0.035),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  selectedFilter = status;
                });
              },
              selectedColor: Colors.black,
              backgroundColor: Colors.grey[200],
              checkmarkColor: Colors.white,
              elevation: isSelected ? 4 : 2,
              pressElevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected ? Colors.black! : Colors.grey[300]!,
                  width: 1,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}