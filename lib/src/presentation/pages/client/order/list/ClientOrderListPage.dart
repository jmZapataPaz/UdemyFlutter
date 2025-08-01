import 'package:ecommerce_flutter/src/domain/models/Order.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/order/list/ClientOrderListItem.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/order/list/bloc/ClientOrderListBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/order/list/bloc/ClientOrderListEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/order/list/bloc/ClientOrderListState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientOrderListPage extends StatefulWidget {
  const ClientOrderListPage({super.key});

  @override
  State<ClientOrderListPage> createState() => _ClientOrderListPageState();
}

class _ClientOrderListPageState extends State<ClientOrderListPage> {

  ClientOrderListBloc? _bloc;

  final List<String> statusFilters = ['TODOS', 'CREADO', 'PAGADO', 'ENTREGADO'];
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
    _bloc = BlocProvider.of<ClientOrderListBloc>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;

    return Scaffold(
      body: BlocListener<ClientOrderListBloc, ClientOrderListState>(
        listener: (context, state) {
          final responseState = state.response;
        },
        child: Column(
          children: [
            _buildFilterChips(context, isTablet),
            Expanded(
              child: BlocBuilder<ClientOrderListBloc, ClientOrderListState>(
                builder: (context, state) {
                  final responseState = state.response;
                  if (responseState is Success) {
                    List<Order> orders = responseState.data as List<Order>;
                    List<Order> filteredOrders = _filterOrders(orders, selectedFilter);
                    return ListView.builder(
                      itemCount: filteredOrders.length,
                      itemBuilder: (context, index) {
                        return ClientOrderListItem(filteredOrders[index]);
                      }
                    );
                  } else if (responseState is Error) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.receipt_long_outlined, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'No tienes pedidos',
                            style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Realiza una compra para ver tus pedidos',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
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