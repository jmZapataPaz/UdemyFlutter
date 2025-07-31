import 'package:ecommerce_flutter/src/domain/models/Order.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/order/detail/AdminOrderDetailBottom.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/order/detail/AdminOrderDetailItem.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/order/detail/bloc/AdminOrderDetailBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminOrderDetailPage extends StatefulWidget {
  const AdminOrderDetailPage({super.key});

  @override
  State<AdminOrderDetailPage> createState() => _AdminOrderDetailPageState();
}

class _AdminOrderDetailPageState extends State<AdminOrderDetailPage> {
  AdminOrderDetailBloc? _bloc;
  Order? order;

  @override
  Widget build(BuildContext context) {
    order = ModalRoute.of(context)?.settings.arguments as Order;
    _bloc = BlocProvider.of<AdminOrderDetailBloc>(context);
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
            horizontal: isTablet ? 0 : 32,
            vertical: isTablet ? 0 : 24,
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
                        return AdminOrderDetailItem(order?.orderHasProducts![index]);
                      },
                    ),
                  ),
                  SizedBox(height: isTablet ? 24 : 12),
                  AdminOrderDetailBottom(_bloc, order),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
