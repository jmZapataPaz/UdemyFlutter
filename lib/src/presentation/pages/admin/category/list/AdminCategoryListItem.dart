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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    bool isTablet = screenWidth > 600;
    
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'admin/product/list', arguments: category);
      },
      child: Container(
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
            category != null ? Container(
              width: screenWidth * (isTablet ? 0.15 : 0.18),
              height: screenHeight * (isTablet ? 0.10 : 0.08), 
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
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/img/user_image.png', 
                  image: category!.image!,
                  fadeInDuration: Duration(seconds: 1),
                  fit: BoxFit.cover,
                ),
              ),
            ) : Container(),
            SizedBox(width: screenWidth * 0.03),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category != null ? category!.name! : 'No Category',
                    style: TextStyle(
                      fontSize: screenWidth * (isTablet ? 0.035 : 0.045),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.008),
                  Text(
                    category != null ? category!.description! : 'No Description',
                    style: TextStyle(
                      fontSize: screenWidth * (isTablet ? 0.028 : 0.035),
                    ),
                    maxLines: isTablet ? 3 : 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: (){
                    Navigator.pushNamed(context, 'admin/category/update', arguments: category);
                  }, 
                  icon: Icon(
                    Icons.edit, 
                    color: Colors.blue,
                    size: screenWidth * (isTablet ? 0.045 : 0.06),
                  ),
                ),
                IconButton(
                  onPressed: (){
                    bloc?.add(DeleteCategory(id: category!.id!));
                  }, 
                  icon: Icon(
                    Icons.delete, 
                    color: Colors.red,
                    size: screenWidth * (isTablet ? 0.045 : 0.06),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}