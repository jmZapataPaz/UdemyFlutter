import 'package:ecommerce_flutter/src/domain/models/Order.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/src/presentation/pages/driver/order/list/DriverOrderListItem.dart';
import 'package:ecommerce_flutter/src/presentation/pages/driver/order/list/bloc/DriverOrderListBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/driver/order/list/bloc/DriverOrderListEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/driver/order/list/bloc/DriverOrderListState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DriverOrderListPage extends StatefulWidget {
  const DriverOrderListPage({super.key});

  @override
  State<DriverOrderListPage> createState() => _DriverOrderListPageState();
}

class _DriverOrderListPageState extends State<DriverOrderListPage> {

  DriverOrderListBloc? _bloc;
  List<String> statusFilters = ['TODOS', 'CREADO', 'PAGADO', 'ENTREGADO'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _bloc?.add(GetOrders());
    });
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<DriverOrderListBloc>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    bool isTablet = screenWidth > 600;
    
    return Scaffold(
      body: BlocListener<DriverOrderListBloc, DriverOrderListState>(
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
              child: BlocBuilder<DriverOrderListBloc, DriverOrderListState>(
                builder: (context, state) {
                  final responseState = state.response;
                  if (responseState is Success) {
                    List<Order> orders = responseState.data as List<Order>;
                    List<Order> filteredOrders = _filterOrders(orders, state.selectedFilter);
                    if (filteredOrders.isEmpty) {
                      return _buildEmptyState(context, isTablet);
                    }
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * (isTablet ? 0.01 : 0.008),
                      ),
                      itemCount: filteredOrders.length,
                      itemBuilder: (context, index) {
                        return DriverOrderListItem(filteredOrders[index]);
                      }
                    );
                  }
                  if (responseState is Loading) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('Cargando órdenes...'),
                        ],
                      ),
                    );
                  }
                  if (responseState is Error) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error, size: 64, color: Colors.red),
                          SizedBox(height: 16),
                          Text('Error: ${responseState.message}'),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => _bloc?.add(GetOrders()),
                            child: Text('Reintentar'),
                          ),
                        ],
                      ),
                    );
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.receipt_long_outlined, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text('No hay datos disponibles'),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => _bloc?.add(GetOrders()),
                          child: Text('Cargar órdenes'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context, bool isTablet) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return BlocBuilder<DriverOrderListBloc, DriverOrderListState>(
      builder: (context, state) {
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
              bool isSelected = state.selectedFilter == status;
              
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
                    _bloc?.add(FilterByStatus(status: status));
                  },
                  selectedColor: Colors.blue[600],
                  backgroundColor: Colors.grey[200],
                  checkmarkColor: Colors.white,
                  elevation: isSelected ? 4 : 2,
                  pressElevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: isSelected ? Colors.blue[600]! : Colors.grey[300]!,
                      width: 1,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context, bool isTablet) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: screenWidth * (isTablet ? 0.1 : 0.15),
            color: Colors.grey[400],
          ),
          SizedBox(height: screenWidth * (isTablet ? 0.02 : 0.03)),
          Text(
            'No hay órdenes disponibles',
            style: TextStyle(
              fontSize: screenWidth * (isTablet ? 0.03 : 0.045),
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: screenWidth * (isTablet ? 0.01 : 0.015)),
          Text(
            'con el filtro seleccionado',
            style: TextStyle(
              fontSize: screenWidth * (isTablet ? 0.025 : 0.035),
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _bloc?.add(GetOrders()),
            child: Text('Actualizar'),
          ),
        ],
      ),
    );
  }

  List<Order> _filterOrders(List<Order> orders, String filter) {
    if (filter == 'TODOS') {
      return orders;
    }
    List<Order> filtered = orders.where((order) {
      return order.status == filter;
    }).toList();
    return filtered;
  }
}