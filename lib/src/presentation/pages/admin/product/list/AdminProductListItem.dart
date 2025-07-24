import 'package:ecommerce_flutter/src/domain/models/Product.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/product/list/bloc/AdminProductListBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/product/list/bloc/AdminProductListEvent.dart';
import 'package:flutter/material.dart';

class AdminProductListItem extends StatelessWidget {

  Product? product;
  AdminProductListBloc? bloc;
  AdminProductListItem(this.bloc, this.product);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    bool isTablet = screenWidth > 600;
    
    return GestureDetector(
      onTap: () {
      },
      child: Container(
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
            product != null ? Container(
              width: screenWidth * (isTablet ? 0.15 : 0.18),
              height: screenHeight * (isTablet ? 0.10 : 0.12),
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
                child: product!.image1!.isNotEmpty ? FadeInImage.assetNetwork(
                  placeholder: 'assets/img/user_image.png', 
                  image: product!.image1!,
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
                    product != null ? product!.name! : 'No Product',
                    style: TextStyle(
                      fontSize: screenWidth * (isTablet ? 0.035 : 0.045),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.008),
                  Text(
                    product != null ? product!.description : 'No Description',
                    style: TextStyle(
                      fontSize: screenWidth * (isTablet ? 0.028 : 0.035),
                    ),
                    maxLines: isTablet ? 3 : 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: screenHeight * 0.008),
                  Text(
                    product != null ? '\$${product!.price.toString()}' : 'No Price',
                    style: TextStyle(
                      fontSize: screenWidth * (isTablet ? 0.03 : 0.04),
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: (){
                    Navigator.pushNamed(context, 'admin/product/update', arguments: product);
                  }, 
                  icon: Icon(
                    Icons.edit, 
                    color: Colors.blue,
                    size: screenWidth * (isTablet ? 0.045 : 0.06),
                  ),
                ),
                IconButton(
                  onPressed: (){
                    bloc?.add(DeleteProduct(id: product!.id!));
                  }, 
                  icon: Icon(
                    Icons.delete, 
                    color: Colors.red,
                    size: screenWidth * (isTablet ? 0.045 : 0.06),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}