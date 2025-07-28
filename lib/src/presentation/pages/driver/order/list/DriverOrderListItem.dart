import 'package:ecommerce_flutter/src/domain/models/Order.dart';
import 'package:flutter/material.dart';

class DriverOrderListItem extends StatelessWidget {

  Order order; 
  DriverOrderListItem(this.order);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'driver/order/detail', arguments: order);
      },
      child: Container(
        margin: EdgeInsets.only(left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pedido: #${order.id}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
            ),
            Text(
                'Fecha: ${order.createdAt != null ? '${order.createdAt!.day.toString().padLeft(2, '0')}/${order.createdAt!.month.toString().padLeft(2, '0')}/${order.createdAt!.year}' : ''}',
              style: TextStyle(
                fontSize: 16
              ),
            ),
            Text(
              'Entregar en: ${order.address?.address}',
              style: TextStyle(
                fontSize: 16
              )
            ),
            Text(
              'Cliente: ${order.user?.name} ${order.user?.lastname}',
              style: TextStyle(
                fontSize: 16
              )
            ),
            Row(
              children: [
                Text(
                  'Estado: ',
                  style: TextStyle(
                    fontSize: 16
                  )
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(order.status),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    order.status ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Divider(color: Colors.grey[300],)
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toUpperCase()) {
      case 'CREADO':
        return Colors.blue[600]!;
      case 'PAGADO':
        return Colors.orange[600]!;
      case 'ENTREGADO':
        return Colors.green[600]!;
      default:
        return Colors.grey[600]!;
    }
  }
}