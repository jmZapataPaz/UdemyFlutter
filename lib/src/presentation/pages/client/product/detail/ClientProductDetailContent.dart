import 'package:ecommerce_flutter/src/domain/models/Product.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/product/detail/bloc/ClientProductDetailBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/product/detail/bloc/ClientProductDetailEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/product/detail/bloc/ClientProductDetailState.dart';
import 'package:ecommerce_flutter/src/presentation/widgets/DefaultButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class ClientProductDetailContent extends StatelessWidget {

  Product? product;
  ClientProductDetailBloc? _bloc;
  ClientProductDetailState state;
  
  ClientProductDetailContent(this._bloc, this.state, this.product);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              _imageSlideShow(context),
              _textoProductName(context),
              _textoProductDescription(context),
              _textoProductPrice(context),
              Spacer(),
              Divider(
                color: Colors.grey[200],
                height: 0,
                thickness: 2,
                ),
              _actionsShoppingBag(context),
          ],
        ),
      ],
    );
  }

  Widget _textoProductName(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return Container(
      padding: EdgeInsets.only(
        left: screenWidth * (isTablet ? 0.05 : 0.08), 
        top: screenWidth * (isTablet ? 0.04 : 0.08)
      ),
      child: Text(
        product != null ? product!.name : 'No Product',
        style: TextStyle(
          fontSize: screenWidth * (isTablet ? 0.045 : 0.055),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _textoProductDescription(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return Container(
      padding: EdgeInsets.only(
        left: screenWidth * (isTablet ? 0.05 : 0.08), 
        top: screenWidth * (isTablet ? 0.02 : 0.04),
        right: screenWidth * (isTablet ? 0.05 : 0.08)
      ),
      child: Text(
        product != null ? product!.description : 'No Description',
        style: TextStyle(
          fontSize: screenWidth * (isTablet ? 0.035 : 0.042),
        ),
      ),
    );
  }

  Widget _textoProductPrice(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return Container(
      padding: EdgeInsets.only(
        left: screenWidth * (isTablet ? 0.05 : 0.08), 
        top: screenWidth * (isTablet ? 0.02 : 0.04)
      ),
      child: Text(
        product != null ? 'Precio: \$${product!.price.toString()}' : 'No Price',
        style: TextStyle(
          fontSize: screenWidth * (isTablet ? 0.04 : 0.047),
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }

  Widget _imageSlideShow(BuildContext context){
    final screenHeight = MediaQuery.of(context).size.height;
    bool isTablet = MediaQuery.of(context).size.width > 600;
    
    return ImageSlideshow(
      width: double.infinity,
      height: screenHeight * (isTablet ? 0.4 : 0.35),
      initialPage: 0,
      indicatorColor: Colors.blue,
      indicatorBackgroundColor: Colors.grey,
      onPageChanged: (value) {
      },
      autoPlayInterval: 3000,
      isLoop: true,
      children: [
        product!.image1!.isNotEmpty ? 
        FadeInImage.assetNetwork(
          placeholder: 'assets/img/user_image.png', 
          fit: BoxFit.contain,
          image: product!.image1!,
          fadeInDuration: Duration(seconds: 1),
          ) 
          : Container(),
        product!.image2!.isNotEmpty ? 
        FadeInImage.assetNetwork(
          placeholder: 'assets/img/user_image.png', 
          fit: BoxFit.contain,
          image: product!.image2!,
          fadeInDuration: Duration(seconds: 1),
          ) 
          : Container(),
      ],
    );
  }

  Widget _actionsShoppingBag(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    bool isTablet = screenWidth > 600;
    
    return Container(
      color: Colors.grey[200],
      width: double.infinity,
      padding: EdgeInsets.only(
        left: screenWidth * (isTablet ? 0.05 : 0.08), 
        right: screenWidth * (isTablet ? 0.05 : 0.08), 
        bottom: screenHeight * (isTablet ? 0.03 : 0.025), 
        top: screenHeight * (isTablet ? 0.03 : 0.025)
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              _bloc?.add(SubTractItem());
            },
            child: Container(
              width: screenWidth * (isTablet ? 0.08 : 0.1),
              height: screenHeight * (isTablet ? 0.07 : 0.055),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                )
              ),
              child: Text('-',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: screenWidth * (isTablet ? 0.05 : 0.065),
                ),
              ),
            ),
          ),
          Container(
            width: screenWidth * (isTablet ? 0.08 : 0.1),
            height: screenHeight * (isTablet ? 0.07 : 0.055),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey[300],
            ),
            child: Text(state.quantity.toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: screenWidth * (isTablet ? 0.05 : 0.065),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _bloc?.add(AddItem());
            },
            child: Container(
              width: screenWidth * (isTablet ? 0.08 : 0.1),
              height: screenHeight * (isTablet ? 0.07 : 0.055),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                )
              ),
              child: Text('+',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: screenWidth * (isTablet ? 0.05 : 0.065),
                ),
              ),
            ),
          ),
          Spacer(),
          Container(
            width: screenWidth * (isTablet ? 0.3 : 0.4),
            height: screenHeight * (isTablet ? 0.07 : 0.055),
            child: DefaultButton(
              text: 'Agregar', 
              onPressed: () { 
                if (state.quantity > 0) {
                  _bloc?.add(AddProductToShoppingBag(product: product!));
                }
              }, 
            ),
          )
        ],
      ),
    );
  }
}