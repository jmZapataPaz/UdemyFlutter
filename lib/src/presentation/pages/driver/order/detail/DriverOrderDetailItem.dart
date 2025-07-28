import 'package:ecommerce_flutter/src/domain/models/Order.dart';
import 'package:flutter/material.dart';

class DriverOrderDetailItem extends StatelessWidget {

  OrderHasProduct? orderHasProduct;

  DriverOrderDetailItem(this.orderHasProduct);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    bool isTablet = screenWidth > 600;
    
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * (isTablet ? 0.02 : 0.03),
        vertical: screenHeight * (isTablet ? 0.012 : 0.008),
      ),
      padding: EdgeInsets.all(screenWidth * (isTablet ? 0.03 : 0.02)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          orderHasProduct != null ? Container(
            width: screenWidth * (isTablet ? 0.15 : 0.18),
            height: screenHeight * (isTablet ? 0.10 : 0.08), 
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(25),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ClipOval(
              child: orderHasProduct!.product.image1!.isNotEmpty ? FadeInImage.assetNetwork(
                placeholder: 'assets/img/no-image.png', 
                image: orderHasProduct!.product.image1!,
                fadeInDuration: Duration(seconds: 1),
                fit: BoxFit.cover,
              ) : Container(),
            ),
          ) : Container(),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderHasProduct?.product.name ?? 'No Product',
                  style: TextStyle(
                    fontSize: screenWidth * (isTablet ? 0.035 : 0.045),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.008),
                Text(
                  orderHasProduct?.product.description ?? 'No Description',
                  style: TextStyle(
                    fontSize: screenWidth * (isTablet ? 0.028 : 0.035),
                    color: Colors.grey[600],
                  ),
                  maxLines: isTablet ? 3 : 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: screenHeight * 0.008),
                Row(
                  children: [
                    Text(
                      'Precio: \$${orderHasProduct?.product.price?.toString() ?? '0'}',
                      style: TextStyle(
                        fontSize: screenWidth * (isTablet ? 0.03 : 0.038),
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    Text(
                      'Cantidad: ${orderHasProduct?.quantity ?? 0}',
                      style: TextStyle(
                        fontSize: screenWidth * (isTablet ? 0.03 : 0.038),
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}