import 'package:ecommerce_flutter/src/domain/models/Category.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/category/list/bloc/ClientCategoryListBloc.dart';
import 'package:flutter/material.dart';

class ClientCategorylistitem extends StatelessWidget {
  final Category? category;
  final ClientCategoryListBloc? bloc;
  ClientCategorylistitem(this.bloc, this.category);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 400;
    final double categoryHeight = isSmall ? 180 : 260; 

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'client/product/list', arguments: category);
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: isSmall ? 8 : 16,
          vertical: isSmall ? 6 : 10,
        ),
        height: categoryHeight, 
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(isSmall ? 12 : 20),
              child: category != null && category!.image != null && category!.image!.isNotEmpty
                  ? Image.network(
                      category!.image!,
                      width: double.infinity,
                      height: categoryHeight, 
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/img/user_image.png',
                      width: double.infinity,
                      height: categoryHeight, 
                      fit: BoxFit.cover,
                    ),
            ),
            Container(
              height: categoryHeight, 
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(isSmall ? 12 : 20),
                color: Colors.black.withOpacity(0.45),
              ),
            ),
            Positioned(
              left: isSmall ? 10 : 20,
              right: isSmall ? 10 : 20,
              top: isSmall ? 20 : 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    category?.name ?? 'No Category',
                    style: TextStyle(
                      fontSize: isSmall ? 18 : 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [Shadow(blurRadius: 8, color: Colors.black)],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isSmall ? 4 : 10),
                  Text(
                    category?.description ?? 'No Description',
                    style: TextStyle(
                      fontSize: isSmall ? 12 : 16,
                      color: Colors.white70,
                      shadows: [Shadow(blurRadius: 6, color: Colors.black)],
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Positioned(
              right: isSmall ? 10 : 20,
              bottom: isSmall ? 10 : 20,
              child: Icon(Icons.arrow_forward_ios, color: Colors.white70, size: isSmall ? 18 : 28),
            ),
          ],
        ),
      ),
    );
  }
}