import 'package:ecommerce_flutter/src/domain/models/Product.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/product/list/bloc/ClientProductListBloc.dart';
import 'package:flutter/material.dart';

class ClientProductListItem extends StatelessWidget {

  Product? product;
  ClientProductListBloc? bloc;
  ClientProductListItem(this.bloc, this.product);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'client/product/detail', arguments: product);
      },
      child: ListTile(
        trailing: product != null ? Container(
          width: 70,
          child: product!.image1!.isNotEmpty ? FadeInImage.assetNetwork(
            placeholder: 'assets/img/user_image.png', 
            image: product!.image1!,
            fit: BoxFit.cover,
            fadeInDuration: Duration(seconds: 1),
          ): Container(),
        ):
        Container() ,
        title: Text(product != null ? product!.name : 'No Product', 
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Text(product != null ? product!.description : 'No Description'),
              SizedBox(height: 5),
              Text(product != null ? '\$${product!.price.toString()}' : 'No Price'),
          ],
        ),
        leading: Wrap(
          direction: Axis.horizontal,
          children: [
          ],
        ),
      ),
    );
  }
}