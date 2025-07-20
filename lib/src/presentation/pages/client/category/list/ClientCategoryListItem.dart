import 'package:ecommerce_flutter/src/domain/models/Category.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/category/list/bloc/ClientCategoryListBloc.dart';
import 'package:flutter/material.dart';

class ClientCategorylistitem extends StatelessWidget {

  Category? category;
  ClientCategoryListBloc? bloc;
  ClientCategorylistitem(this.bloc, this.category);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'client/product/list', arguments: category);
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Card(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              category != null ? Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.2,
              child: category!.image!.isNotEmpty ? 
              FadeInImage.assetNetwork(
                placeholder: 'assets/img/user_image.png', 
                fit: BoxFit.contain,
                image: category!.image!,
                fadeInDuration: Duration(seconds: 1),
                ) : Container()
              ) : Container(),
              Container(
                margin: EdgeInsets.only(top: 15, left: 15),
                child: Text(category != null ? category!.name : 'No Category',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 15),
                child: Text(category?.description != null ? category!.description : 'No Description',
                  style: TextStyle(
                    fontSize: 16,
                    color: const Color.fromARGB(255, 65, 65, 65),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}