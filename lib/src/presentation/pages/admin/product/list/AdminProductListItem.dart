import 'package:ecommerce_flutter/src/domain/models/Product.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/product/list/bloc/AdminProductListBloc.dart';
import 'package:flutter/material.dart';

class AdminProductListItem extends StatelessWidget {

  Product? product;
  AdminProductListBloc? bloc;
  AdminProductListItem(this.bloc, this.product);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Navigator.pushNamed(context, 'admin/product/list', arguments: product);
      },
      child: ListTile(
        leading: product != null ? Container(
          width: 70,
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/img/user_image.png', 
            image: product!.image1!,
            fadeInDuration: Duration(seconds: 1),
          ),
        ):
        Container() ,
        title: Text(product != null ? product!.name! : 'No Product', 
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
        trailing: Wrap(
          direction: Axis.horizontal,
          children: [
            IconButton(
              onPressed: (){
                Navigator.pushNamed(context, 'admin/product/update', arguments: product);
              }, 
              icon: Icon(Icons.edit, color: Colors.black)
            ),
            IconButton(
              onPressed: (){
                //bloc?.add(DeleteCategory(id: category!.id!));
              }, 
              icon: Icon(Icons.delete, color: Colors.red)
            ),
          ],
        ),
      ),
    );
  }
}