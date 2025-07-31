import 'package:ecommerce_flutter/src/domain/models/Order.dart';
import 'package:ecommerce_flutter/src/presentation/pages/driver/order/detail/DriverOrderDetailBottom.dart';
import 'package:ecommerce_flutter/src/presentation/pages/driver/order/detail/DriverOrderDetailItem.dart';
import 'package:ecommerce_flutter/src/presentation/pages/driver/order/detail/bloc/DriverOrderDetailBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Detalle del pedido',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: isTablet ? double.infinity : 700,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: isTablet ? 0 : 0,
            vertical: isTablet ? 0 : 0,
          ),
          child: Card(
            elevation: isTablet ? 8 : 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(isTablet ? 24 : 12)),
            child: Padding(
              padding: EdgeInsets.all(isTablet ? 32 : 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Productos',
                    style: TextStyle(
                      fontSize: isTablet ? 28 : 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: isTablet ? 24 : 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: order?.orderHasProducts?.length ?? 0,
                      itemBuilder: (context, index) {
                        return DriverOrderDetailItem(order?.orderHasProducts![index]);
                      },
                    ),
                  ),
                  SizedBox(height: isTablet ? 24 : 12),
                  DriverOrderDetailBottom(_bloc, order),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
