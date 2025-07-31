import 'package:ecommerce_flutter/src/domain/models/Order.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/order/detail/bloc/AdminOrderDetailBloc.dart';
import 'package:flutter/material.dart';

class AdminOrderDetailBottom extends StatelessWidget {
  Order? order;
  AdminOrderDetailBloc? bloc;
  AdminOrderDetailBottom(this.bloc, this.order);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    double total = 0;
    order?.orderHasProducts?.forEach((ohp) {
      total += (ohp.product.price * ohp.quantity);
    });

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isTablet ? 24 : 16),
        boxShadow: [
          if (isTablet)
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
            subtitle: '${order?.address?.neighborhood ?? ''} ${order?.address?.address ?? ''}',
            isTablet: isTablet,
          ),
          _buildListTile(
            context,
            icon: Icons.change_circle,
            title: 'Estado de la orden',
            subtitle: order?.status ?? '',
            isTablet: isTablet,
          ),
          Divider(height: 32, color: Colors.grey[300]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total: \$${total.toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: isTablet ? 26 : 20,
                  color: Colors.green[700],
                ),
              ),
            ],
          ),
        ],
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