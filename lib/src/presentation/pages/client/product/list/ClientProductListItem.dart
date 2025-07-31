import 'package:ecommerce_flutter/src/domain/models/Product.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/product/list/bloc/ClientProductListBloc.dart';
import 'package:flutter/material.dart';

class ClientProductListItem extends StatelessWidget {
  Product? product;
  ClientProductListBloc? bloc;
  ClientProductListItem(this.bloc, this.product);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;

    if (!isTablet) {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'client/product/detail', arguments: product);
        },
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.03,
            vertical: screenHeight * 0.008,
          ),
          padding: EdgeInsets.all(screenWidth * 0.02),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Row(
            children: [
              product != null
                  ? Container(
                      width: screenWidth * 0.20,
                      height: screenHeight * 0.10,
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
                        child: product!.image1!.isNotEmpty
                            ? FadeInImage.assetNetwork(
                                placeholder: 'assets/img/user_image.png',
                                image: product!.image1!,
                                fadeInDuration: Duration(seconds: 1),
                                fit: BoxFit.cover,
                              )
                            : Container(),
                      ),
                    )
                  : Container(),
              SizedBox(width: screenWidth * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product != null ? product!.name! : 'No Product',
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.008),
                    Text(
                      product != null ? product!.description : 'No Description',
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: screenHeight * 0.008),
                    Text(
                      product != null ? '\$${product!.price.toString()}' : 'No Price',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[400],
                size: screenWidth * 0.05,
              ),
            ],
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'client/product/detail', arguments: product);
        },
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  child: product != null && product!.image1 != null && product!.image1!.isNotEmpty
                      ? Image.network(
                          product!.image1!,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/img/no-image.png',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product != null ? product!.name! : 'No Product',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      product != null ? product!.description : 'No Description',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      product != null ? '\$${product!.price.toString()}' : 'No Price',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.green[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}