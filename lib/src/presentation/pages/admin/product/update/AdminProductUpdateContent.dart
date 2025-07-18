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
                        SizedBox(width: 20),
                        _imageProduct2(context),
                      ],
                    ),
                    _cardProductForm(context),
                    
                  ],
                ),
              ),
            ),
            DefaultIconBack(
              left: MediaQuery.of(context).size.width * 0.05, 
              top: MediaQuery.of(context).padding.top + 10,
          ),
        ],
      )
    );
  }

  Widget _cardProductForm( BuildContext context) {
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
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            _textNewProduct(),
            _textFieldName(),
            _textFieldDescription(),
            _textFieldPrice(),
            _fabSubmit()
          ],
        ),
      )
    );
  }

  Widget _fabSubmit(){
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.only(top: 30, right: 10),
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
        ),
      ),
    );
  }

  Widget _textNewProduct(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 25, left:10, bottom: 10),
      child: Text('Actualizar Producto',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),
      ),
    );
  }

  Widget _textFieldName(){
    return DefaultTextField(
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
    );
  }

  Widget _textFieldDescription(){
    return DefaultTextField(
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
    );
  }

  Widget _textFieldPrice(){
    return DefaultTextField(
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
    );
  }

  Widget _imageProduct1(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SelectOptionImageDialog(
          context, 
          (){bloc?.add(PIckImage(numberFile: 1));}, 
          (){bloc?.add(TakePhoto(numberFile: 1));}, 
        );
      },
      child: Container(
        width: 150,
        margin: EdgeInsets.only(top: 100),
        child: AspectRatio(
          aspectRatio: 1/1,
          child: ClipOval(
            child: state.file1 != null
            ? Image.file(
              state.file1!, 
              fit: BoxFit.contain
            )
            : product != null ? 
            FadeInImage.assetNetwork(
              placeholder: 'assets/img/user_image.png', 
              image: product!.image1!,
              fit: BoxFit.cover,
              fadeInDuration: Duration(seconds: 1),
            ): 
            Image.asset('assets/img/no-image.png', fit: BoxFit.contain,), 
          ),
        ),
      ),
    );
  }

  Widget _imageProduct2(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SelectOptionImageDialog(
          context, 
          (){bloc?.add(PIckImage(numberFile: 2));}, 
          (){bloc?.add(TakePhoto(numberFile: 2));}, 
        );
      },
      child: Container(
        width: 150,
        margin: EdgeInsets.only(top: 100),
        child: AspectRatio(
          aspectRatio: 1/1,
          child: ClipOval(
            child: state.file2 != null
            ? Image.file(
              state.file2!, 
              fit: BoxFit.contain
            )
            : product != null ? 
            FadeInImage.assetNetwork(
              placeholder: 'assets/img/user_image.png', 
              image: product!.image2!,
              fit: BoxFit.cover,
              fadeInDuration: Duration(seconds: 1),
            ): 
            Image.asset('assets/img/no-image.png', fit: BoxFit.contain,), 
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