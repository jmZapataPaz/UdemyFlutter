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
    return Scaffold(
      body: BlocListener<ClientOrderListBloc, ClientOrderListState>(
        listener: (context, state) {
          final responseState = state.response;
        },
        child: BlocBuilder<ClientOrderListBloc, ClientOrderListState>(
          builder: (context, state) {
            final responseState = state.response;
            if (responseState is Success) {
              List<Order> orders = responseState.data as List<Order>;
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return ClientOrderListItem(orders[index]);
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
    );
  }
}