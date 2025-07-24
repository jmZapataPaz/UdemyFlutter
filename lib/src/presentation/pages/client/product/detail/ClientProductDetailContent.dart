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
              _imageSlideShow(),
              _textoProductName(),
              _textoProductDescription(),
              _textoProductPrice(),
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


  Widget _textoProductName(){
    return Container(
      padding: EdgeInsets.only(left: 30, top: 30),
      child: Text(
        product != null ? product!.name : 'No Product',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _textoProductDescription(){
    return Container(
      padding: EdgeInsets.only(left: 30, top: 15),
      child: Text(
        product != null ? product!.description : 'No Description',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _textoProductPrice(){
    return Container(
      padding: EdgeInsets.only(left: 30, top: 15),
      child: Text(
        product != null ? 'Precio: \$${product!.price.toString()}' : 'No Price',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _imageSlideShow(){
    return ImageSlideshow(
      width: double.infinity,
      height: 300,
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
    return Container(
      color: Colors.grey[200],
      width: double.infinity,
      padding: EdgeInsets.only(left: 30, right: 30, bottom: 20, top: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              _bloc?.add(SubTractItem());
            },
            child: Container(
              width: 40,
              height: MediaQuery.of(context).size.height*0.055,
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
                  fontSize: 25,
                ),
              ),
            ),
          ),
          Container(
            width: 40,
            height: MediaQuery.of(context).size.height*0.055,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey[300],
            ),
            child: Text(state.quantity.toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _bloc?.add(AddItem());
            },
            child: Container(
              width: 40,
              height: MediaQuery.of(context).size.height*0.055,
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
                  fontSize: 25,
                ),
              ),
            ),
          ),
          Spacer(),
          Container(
            width: MediaQuery.of(context).size.width*0.4,
            height: MediaQuery.of(context).size.height*0.055,
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