import 'package:ecommerce_flutter/src/domain/models/Order.dart';
import 'package:ecommerce_flutter/src/presentation/pages/driver/order/detail/bloc/DriverOrderDetailBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/driver/order/detail/bloc/DriverOrderDetailEvent.dart';
import 'package:ecommerce_flutter/src/presentation/widgets/DefaultButton.dart';
import 'package:flutter/material.dart';

class DriverOrderDetailBottom extends StatelessWidget {
  Order? order;
  DriverOrderDetailBloc? bloc;
  DriverOrderDetailBottom(this.bloc, this.order);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    bool isTablet = screenWidth > 600;
    
    double total = 0;
    order?.orderHasProducts?.forEach((ohp) {
      total = total + (ohp.product.price * ohp.quantity);
    });
    
    return Container(
      width: screenWidth * (isTablet ? 0.9 : 0.85),
      height: screenHeight * (isTablet ? 0.35 : 0.3), 
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * (isTablet ? 0.03 : 0.02)),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildListTile(
                      context,
                      icon: Icons.calendar_month,
                      title: 'Fecha del pedido',
                        subtitle: order?.createdAt != null
                          ? '${order!.createdAt.day.toString().padLeft(2, '0')}/${order!.createdAt.month.toString().padLeft(2, '0')}/${order!.createdAt.year}'
                          : '',
                      isTablet: isTablet,
                    ),
                    _buildListTile(
                      context,
                      icon: Icons.person,
                      title: 'Cliente',
                        subtitle: '${order?.user?.name ?? ''} ${order?.user?.lastname ?? ''}',
                      isTablet: isTablet,
                    ),
                    _buildListTile(
                      context,
                      icon: Icons.person,
                      title: 'Teléfono',
                      subtitle: order?.user?.phone ?? '',
                      isTablet: isTablet,
                    ),
                    _buildListTile(
                      context,
                      icon: Icons.location_on,
                      title: 'Dirección de entrega',
                      subtitle: '${order?.address?.neighborhood} ${order?.address?.address}',
                      isTablet: isTablet,
                    ),
                    _buildListTile(
                      context,
                      icon: Icons.change_circle,
                      title: 'Estado de la orden',
                      subtitle: order?.status ?? '',
                      isTablet: isTablet,
                    ),
                  ],
                ),
              ),
            ),
            Divider(height: 1, color: Colors.grey[400]),
            SizedBox(height: screenHeight * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: Text(
                    'Total: \$${total.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * (isTablet ? 0.035 : 0.04),
                    ),
                  ),
                ),
                Container(
                  width: screenWidth * (isTablet ? 0.25 : 0.4),
                  height: screenHeight * (isTablet ? 0.05 : 0.045),
                    child: (order?.status == 'PAGADO' || order?.status == 'CREADO')
                  ? DefaultButton(
                    text: 'Entregar', 
                    onPressed: () {
                      bloc?.add(UpdateStatusOrder(id: order!.id, status: "ENTREGADO"));                    }
                  )
                  : Container()
                )
              ],
            ),
            SizedBox(height: screenHeight * 0.005),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isTablet,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: screenWidth * (isTablet ? 0.02 : 0.01),
        vertical: screenWidth * (isTablet ? 0.01 : 0.005),
      ),
      leading: Icon(
        icon, 
        color: Colors.grey[400],
        size: screenWidth * (isTablet ? 0.06 : 0.06),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: screenWidth * (isTablet ? 0.025 : 0.04),
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: screenWidth * (isTablet ? 0.03 : 0.035),
        ),
      ),
    );
  }
}