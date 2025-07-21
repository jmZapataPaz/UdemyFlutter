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
    return Container(
      //height: MediaQuery.of(context).size.height * 0.10, 
      padding: EdgeInsets.only(left: 17, right: 20, top: 15), 
      child: Row(
        children: [
          _imageProduct(),
          SizedBox(width: 15),
          Expanded( 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                _textProduct(context),
                SizedBox(height: 5),
                _actionsAddAndSubtract(context),
              ],
            ),
          ),
          SizedBox(width: 10,), 
          Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            mainAxisSize: MainAxisSize.min, 
            children: [
              _textPrice(),
              SizedBox(height: 2), 
              _iconRemove(),
            ],
          )
        ],
      ),
    );
  }

  Widget _actionsAddAndSubtract(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, 
      children: [
        GestureDetector(
          onTap: () {
            _bloc?.add(SubTractItem(product: product!));
          },
          child: Container(
            width: 30, 
            height: 30,
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
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(
          width: 40, 
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey[300],
          ),
          child: Text('${product?.quantity ?? 0}', 
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            _bloc?.add(AddItem(product: product!));
          },
          child: Container(
            width: 30, 
            height: 30,
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
                fontSize: 18, 
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _textProduct(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5, 
      child: Text(
        product != null ? product!.name! : 'Título del Producto',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis, 
      ),
    );
  }

  Widget _textPrice(){
    return Text(
      '\$${((product?.price ?? 0) * (product?.quantity ?? 0)).toString()}',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.grey[700],
      ),
    );
  }  

  Widget _iconRemove(){
    return GestureDetector(
      onTap: () {
        _bloc?.add(RemoveItem(product: product!));
      },
      child: Container(
        padding: EdgeInsets.all(4), 
        child: Icon(
          Icons.delete_outline, 
          color: Colors.red,
          size: 20,
        ),
      ),
    );
  }

  Widget _imageProduct(){
    return Container(
      width: 80, 
      height: 80, 
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
    );
  }
}