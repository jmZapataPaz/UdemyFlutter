import 'package:ecommerce_flutter/src/domain/models/Product.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/shoppingBag/Bloc/ClientShoppingBagBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/shoppingBag/Bloc/ClientShoppingBagEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/shoppingBag/Bloc/ClientShoppingBagState.dart';
import 'package:flutter/material.dart';

class ClientShoppingBagItem extends StatelessWidget {
  Product? product;
  ClientShoppingBagBloc? _bloc;
  ClientShoppingBagState? state;
  
  ClientShoppingBagItem(this._bloc, this.state, this.product);

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
          _imageProduct(context),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _textProduct(context),
                SizedBox(height: screenHeight * 0.008),
                _actionsAddAndSubtract(context),
              ],
            ),
          ),
          Column(
            children: [
              _textPrice(context),
              SizedBox(height: screenHeight * 0.01),
              _iconRemove(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionsAddAndSubtract(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    bool isTablet = screenWidth > 600;
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            _bloc?.add(SubTractItem(product: product!));
          },
          child: Container(
            width: screenWidth * (isTablet ? 0.08 : 0.08),
            height: screenHeight * (isTablet ? 0.05 : 0.04),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              )
            ),
            child: Text('-',
              style: TextStyle(
                color: Colors.black,
                fontSize: screenWidth * (isTablet ? 0.04 : 0.045),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(
          width: screenWidth * (isTablet ? 0.1 : 0.1),
          height: screenHeight * (isTablet ? 0.05 : 0.04),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey[300],
          ),
          child: Text('${product?.quantity ?? 0}', 
            style: TextStyle(
              color: Colors.black,
              fontSize: screenWidth * (isTablet ? 0.035 : 0.04),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            _bloc?.add(AddItem(product: product!));
          },
          child: Container(
            width: screenWidth * (isTablet ? 0.08 : 0.08),
            height: screenHeight * (isTablet ? 0.05 : 0.04),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              )
            ),
            child: Text('+',
              style: TextStyle(
                color: Colors.black,
                fontSize: screenWidth * (isTablet ? 0.04 : 0.045),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _textProduct(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return Text(
      product != null ? product!.name : 'Título del Producto',
      style: TextStyle(
        fontSize: screenWidth * (isTablet ? 0.035 : 0.045),
        fontWeight: FontWeight.bold,
      ),
      maxLines: isTablet ? 2 : 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _textPrice(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return Text(
      '\$${((product?.price ?? 0) * (product?.quantity ?? 0)).toString()}',
      style: TextStyle(
        fontSize: screenWidth * (isTablet ? 0.03 : 0.04),
        fontWeight: FontWeight.bold,
        color: Colors.green,
      ),
    );
  }  

  Widget _iconRemove(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return GestureDetector(
      onTap: () {
        _bloc?.add(RemoveItem(product: product!));
      },
      child: Container(
        padding: EdgeInsets.all(screenWidth * (isTablet ? 0.01 : 0.008)),
        child: Icon(
          Icons.delete_outline, 
          color: Colors.red,
          size: screenWidth * (isTablet ? 0.045 : 0.055),
        ),
      ),
    );
  }

  Widget _imageProduct(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    bool isTablet = screenWidth > 600;
    
    return Container(
      width: screenWidth * (isTablet ? 0.15 : 0.20),
      height: screenHeight * (isTablet ? 0.10 : 0.10),
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
        child: product != null && product!.image1!.isNotEmpty 
          ? FadeInImage.assetNetwork(
              placeholder: 'assets/img/user_image.png', 
              image: '${product!.image1!}?v=${DateTime.now().millisecondsSinceEpoch}', 
              fit: BoxFit.cover,
              fadeInDuration: Duration(milliseconds: 300), 
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/img/no-image.png', 
                  fit: BoxFit.cover
                );
              },
            )
          : Image.asset(
              'assets/img/no-image.png',
              fit: BoxFit.cover,
            ),
      ),
    );
  }
}