import 'package:ecommerce_flutter/src/domain/models/Category.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/category/list/bloc/AdminCategoryListBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/category/list/bloc/AdminCategoryListEvent.dart';
import 'package:flutter/material.dart';

class Admincategorylistitem extends StatelessWidget {

  Category? category;
  AdminCategoryListBloc? bloc;
  Admincategorylistitem(this.bloc, this.category);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'admin/product/list', arguments: category);
      },
      child: ListTile(
        leading: category != null ? Container(
          width: 70,
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/img/user_image.png', 
            image: category!.image!,
            fadeInDuration: Duration(seconds: 1),
          ),
        ):
        Container() ,
        title: Text(category != null ? category!.name! : 'No Category'),
        subtitle: Text(category != null ? category!.description! : 'No Description'),
        //contentPadding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        trailing: Wrap(
          direction: Axis.horizontal,
          children: [
            IconButton(
              onPressed: (){
                Navigator.pushNamed(context, 'admin/category/update', arguments: category);
              }, 
              icon: Icon(Icons.edit, color: Colors.black)
            ),
            IconButton(
              onPressed: (){
                bloc?.add(DeleteCategory(id: category!.id!));
              }, 
              icon: Icon(Icons.delete, color: Colors.red)
            ),
          ],
        ),
      ),
    );
  }
}