import 'package:ecommerce_flutter/src/domain/models/Order.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/src/presentation/pages/driver/order/detail/DriverOrderDetailBottom.dart';
import 'package:ecommerce_flutter/src/presentation/pages/driver/order/detail/DriverOrderDetailItem.dart';
import 'package:ecommerce_flutter/src/presentation/pages/driver/order/detail/bloc/DriverOrderDetailBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/driver/order/detail/bloc/DriverOrderDetailState.dart';
import 'package:ecommerce_flutter/src/presentation/pages/driver/order/list/bloc/DriverOrderListBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/driver/order/list/bloc/DriverOrderListEvent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DriverOrderDetailPage extends StatefulWidget {
  const DriverOrderDetailPage({super.key});

  @override
  State<DriverOrderDetailPage> createState() => _DriverOrderDetailPageState();
}

class _DriverOrderDetailPageState extends State<DriverOrderDetailPage> {
  DriverOrderDetailBloc? _bloc;
  Order? order;

  @override
  Widget build(BuildContext context) {
    order = ModalRoute.of(context)?.settings.arguments as Order;
    _bloc = BlocProvider.of<DriverOrderDetailBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle del pedido'),
      ),
      body: BlocListener<DriverOrderDetailBloc, DriverOrderDetailState>(
        listener: (context, state) {
          final responseState = state.response;
          if (responseState is Error) {
            Fluttertoast.showToast(msg: responseState.message, toastLength: Toast.LENGTH_LONG);
          }
          else if (responseState is Success) {
            Fluttertoast.showToast(msg: 'El pedido se actualizo correctamente', toastLength: Toast.LENGTH_LONG);
            context.read<DriverOrderListBloc>().add(GetOrders());
            Navigator.pop(context);
          }
        },
        child: ListView.builder(
            itemCount: order?.orderHasProducts?.length,
            itemBuilder: (context, index) {
              return DriverOrderDetailItem(order?.orderHasProducts![index]);
            }),
      ),
      bottomNavigationBar: DriverOrderDetailBottom(_bloc, order),
    );
  }
}
