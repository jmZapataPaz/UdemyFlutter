import 'package:ecommerce_flutter/src/domain/models/Order.dart';
import 'package:ecommerce_flutter/src/presentation/pages/driver/order/list/bloc/DriverOrderListBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/driver/order/list/bloc/DriverOrderListEvent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DriverOrderListItem extends StatelessWidget {
  final Order order;
  DriverOrderListItem(this.order);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 400;

    return GestureDetector(
      onTap: () async {
        final result = await Navigator.pushNamed(context, 'driver/order/detail', arguments: order);
        if (result == true) {
          final bloc = BlocProvider.of<DriverOrderListBloc>(context);
          bloc.add(GetOrders());
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: isSmall ? 8 : 32, vertical: isSmall ? 8 : 16),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(isSmall ? 10 : 20)),
          child: Padding(
            padding: EdgeInsets.all(isSmall ? 12 : 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.receipt_long, color: Colors.blue[400], size: isSmall ? 22 : 32),
                    SizedBox(height: isSmall ? 12 : 18),
                    Icon(Icons.calendar_today, size: isSmall ? 16 : 22, color: Colors.grey[600]),
                    SizedBox(height: isSmall ? 8 : 14),
                    Icon(Icons.location_on, size: isSmall ? 16 : 22, color: Colors.red[400]),
                    SizedBox(height: isSmall ? 8 : 14),
                    Icon(Icons.person, size: isSmall ? 16 : 22, color: Colors.green[400]),
                  ],
                ),
                SizedBox(width: isSmall ? 8 : 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Pedido: #${order.id}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: isSmall ? 16 : 24,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: isSmall ? 8 : 16, vertical: isSmall ? 2 : 6),
                            decoration: BoxDecoration(
                              color: _getStatusColor(order.status),
                              borderRadius: BorderRadius.circular(isSmall ? 8 : 16),
                            ),
                            child: Text(
                              order.status ?? '',
                              style: TextStyle(
                                fontSize: isSmall ? 12 : 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: isSmall ? 10 : 18),
                      Text(
                        'Fecha: ${order.createdAt != null ? '${order.createdAt!.day.toString().padLeft(2, '0')}/${order.createdAt!.month.toString().padLeft(2, '0')}/${order.createdAt!.year}' : ''}',
                        style: TextStyle(fontSize: isSmall ? 13 : 18),
                      ),
                      SizedBox(height: isSmall ? 6 : 14),
                      Text(
                        'Entregar en: ${order.address?.address ?? ''}',
                        style: TextStyle(fontSize: isSmall ? 13 : 18),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: isSmall ? 6 : 14),
                      Text(
                        'Cliente: ${order.user?.name ?? ''} ${order.user?.lastname ?? ''}',
                        style: TextStyle(fontSize: isSmall ? 13 : 18),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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