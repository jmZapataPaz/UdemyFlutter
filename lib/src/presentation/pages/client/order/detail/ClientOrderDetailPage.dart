import 'package:ecommerce_flutter/src/domain/models/Order.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/order/detail/ClientOrderDetailBottom.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/order/detail/ClientOrderDetailItem.dart';
import 'package:flutter/material.dart';

class ClientOrderDetailPage extends StatefulWidget {
  const ClientOrderDetailPage({super.key});

  @override
  State<ClientOrderDetailPage> createState() => _ClientOrderDetailPageState();
}

class _ClientOrderDetailPageState extends State<ClientOrderDetailPage> {
  Order? order;

  @override
  Widget build(BuildContext context) {
    order = ModalRoute.of(context)?.settings.arguments as Order;
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
      body: Container(
        width: double.infinity,
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
                    padding: EdgeInsets.zero,
                    itemCount: order?.orderHasProducts?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ClientOrderDetailItem(order?.orderHasProducts![index]);
                    },
                  ),
                ),
                SizedBox(height: isTablet ? 24 : 12),
                ClientOrderDetailBottom(order),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
