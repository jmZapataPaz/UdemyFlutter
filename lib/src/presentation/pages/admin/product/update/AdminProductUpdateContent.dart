import 'package:ecommerce_flutter/src/domain/models/Product.dart';
import 'package:ecommerce_flutter/src/domain/utils/BlocFormItem.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/product/update/bloc/AdminProductUpdateBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/product/update/bloc/AdminProductUpdateEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/product/update/bloc/AdminProductUpdateState.dart';
import 'package:ecommerce_flutter/src/presentation/utils/SelectOptionImageDialog.dart';
import 'package:ecommerce_flutter/src/presentation/widgets/DefaultIconBack.dart';
import 'package:ecommerce_flutter/src/presentation/widgets/DefaultTextField.dart';
import 'package:flutter/material.dart';

class AdminProductUpdateContent extends StatelessWidget {

  AdminProductUpdateBloc? bloc;
  AdminProductUpdateState state;
  Product? product;

  AdminProductUpdateContent(this.bloc, this.state, this.product);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return Form(
      key: state.formKey,
      child: Stack(
        alignment: Alignment.center,
        children: [
            _imageBackground(context),
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _imageProduct1(context),
                        SizedBox(width: screenWidth * (isTablet ? 0.05 : 0.05)),
                        _imageProduct2(context),
                      ],
                    ),
                    _cardProductForm(context),
                  ],
                ),
              ),
            ),
            DefaultIconBack(
              left: screenWidth * 0.05, 
              top: MediaQuery.of(context).padding.top + 10,
          ),
        ],
      )
    );
  }

  Widget _cardProductForm( BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.53,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.7),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: screenWidth * (isTablet ? 0.1 : 0.05), 
          vertical: screenWidth * (isTablet ? 0.05 : 0.08),
        ),
        child: Column(
          children: [
            _textNewProduct(context),
            _textFieldName(context),
            _textFieldDescription(context),
            _textFieldPrice(context),
            _fabSubmit(context)
          ],
        ),
      )
    );
  }

  Widget _fabSubmit(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.only(
        top: screenWidth * (isTablet ? 0.08 : 0.08), 
      ),
      child: SizedBox(
        width: screenWidth * (isTablet ? 0.12 : 0.15),
        height: screenWidth * (isTablet ? 0.12 : 0.15),
        child: FloatingActionButton(
          onPressed: () {
            if(state.formKey!.currentState!.validate()) {
              bloc?.add(FormSubmit());
            }
          },
          tooltip: 'Update Product',
          backgroundColor: Colors.black,
          child: Icon(
            Icons.check,
            color: Colors.white,
            size: screenWidth * (isTablet ? 0.05 : 0.06),
          ),
        ),
      ),
    );
  }

  Widget _textNewProduct(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        top: screenWidth * (isTablet ? 0.05 : 0.06), 
        bottom: screenWidth * (isTablet ? 0.025 : 0.03),
      ),
      child: Text('Actualizar Producto',
        style: TextStyle(
          fontSize: screenWidth * (isTablet ? 0.04 : 0.05),
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),
      ),
    );
  }

  Widget _textFieldName(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: screenWidth * (isTablet ? 0.02 : 0.025)),
      child: Transform.scale(
        scale: isTablet ? 1.15 : 1.0,
        child: DefaultTextField(
          label: 'Nombre del producto', 
          icon: Icons.category,
          initialValue: product?.name ?? '',
          onChanded: (text){
            bloc?.add(NameChanged(BlocFormItem(value: text))); 
          },
          validator: (value){
            return state.name.error;
          },
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _textFieldDescription(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: screenWidth * (isTablet ? 0.02 : 0.025)),
      child: Transform.scale(
        scale: isTablet ? 1.15 : 1.0,
        child: DefaultTextField(
          label: 'Descripcion del producto', 
          initialValue: product?.description ?? '',
          icon: Icons.list, 
          onChanded: (text){
            bloc?.add(DescriptionChanged(BlocFormItem(value: text))); 
          },
          validator: (value){
            return state.description.error;
          },
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _textFieldPrice(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: screenWidth * (isTablet ? 0.02 : 0.025)),
      child: Transform.scale(
        scale: isTablet ? 1.15 : 1.0,
        child: DefaultTextField(
          label: 'Precio del producto', 
          icon: Icons.money, 
          initialValue: product?.price.toString() ?? '',
          textInputType: TextInputType.number,
          onChanded: (text){
            bloc?.add(PriceChanged(BlocFormItem(value: text))); 
          },
          validator: (value){
            return state.price.error;
          },
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _imageProduct1(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return GestureDetector(
      onTap: () {
        SelectOptionImageDialog(
          context, 
          (){bloc?.add(PIckImage(numberFile: 1));}, 
          (){bloc?.add(TakePhoto(numberFile: 1));}, 
        );
      },
      child: Container(
        width: screenWidth * (isTablet ? 0.40 : 0.4),
        margin: EdgeInsets.only(top: screenWidth * (isTablet ? 0.15 : 0.25)),
        child: AspectRatio(
          aspectRatio: 1/1,
          child: ClipOval(
            child: state.file1 != null
            ? Image.file(
              state.file1!, 
              fit: BoxFit.cover
            )
            : product != null ? 
            FadeInImage.assetNetwork(
              placeholder: 'assets/img/user_image.png', 
              image: '${product!.image1!}?v=${DateTime.now().millisecondsSinceEpoch}', 
              fit: BoxFit.cover,
              fadeInDuration: Duration(seconds: 1),
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset('assets/img/no-image.png', fit: BoxFit.cover);
              },
            ): 
            Image.asset('assets/img/no-image.png', fit: BoxFit.cover,), 
          ),
        ),
      ),
    );
  }

  Widget _imageProduct2(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return GestureDetector(
      onTap: () {
        SelectOptionImageDialog(
          context, 
          (){bloc?.add(PIckImage(numberFile: 2));}, 
          (){bloc?.add(TakePhoto(numberFile: 2));}, 
        );
      },
      child: Container(
        width: screenWidth * (isTablet ? 0.40 : 0.4),
        margin: EdgeInsets.only(top: screenWidth * (isTablet ? 0.15 : 0.25)),
        child: AspectRatio(
          aspectRatio: 1/1,
          child: ClipOval(
            child: state.file2 != null
            ? Image.file(
              state.file2!, 
              fit: BoxFit.cover
            )
            : product != null ? 
            FadeInImage.assetNetwork(
              placeholder: 'assets/img/user_image.png', 
              image: '${product!.image2!}?v=${DateTime.now().millisecondsSinceEpoch}',
              fit: BoxFit.cover,
              fadeInDuration: Duration(seconds: 1),
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset('assets/img/no-image.png', fit: BoxFit.cover);
              },
            ): 
            Image.asset('assets/img/no-image.png', fit: BoxFit.cover,), 
          ),
        ),
      ),
    );
  }

  Widget _imageBackground(BuildContext context) {
    return Image.asset('assets/img/background1.jpg',
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      fit: BoxFit.cover,
      color: Color.fromRGBO(0, 0, 0, 0.7),
      colorBlendMode: BlendMode.darken,
    );
  }
}