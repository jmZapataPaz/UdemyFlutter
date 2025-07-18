import 'package:ecommerce_flutter/src/domain/models/Category.dart';
import 'package:ecommerce_flutter/src/domain/utils/BlocFormItem.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/category/update/bloc/AdminCategoryUpdateBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/category/update/bloc/AdminCategoryUpdateEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/category/update/bloc/AdminCategoryUpdateState.dart';
import 'package:ecommerce_flutter/src/presentation/utils/SelectOptionImageDialog.dart';
import 'package:ecommerce_flutter/src/presentation/widgets/DefaultIconBack.dart';
import 'package:ecommerce_flutter/src/presentation/widgets/DefaultTextField.dart';
import 'package:flutter/material.dart';

class AdminCategoryUpdateContent extends StatelessWidget {

  AdminCategoryUpdateBloc? bloc;
  AdminCategoryUpdateState state;
  Category? category;

  AdminCategoryUpdateContent(this.bloc, this.state, this.category);

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
                    _imageCategory(context),
                    _cardCategoryForm(context),
                    
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

  Widget _cardCategoryForm( BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.43,
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
            _textNewCategory(),
            _textFieldName(),
            _textFieldDescription(),
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
        tooltip: 'Submit Category',
        backgroundColor: Colors.black,
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _textNewCategory(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 25, left:10, bottom: 10),
      child: Text('Actualizar categoria',
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
      label: 'Nombre de la categoria', 
      initialValue: category?.name ?? '',
      icon: Icons.category, 
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
      label: 'Descripcion de la categoria', 
      initialValue: category?.description ?? '',
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


  Widget _imageCategory(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SelectOptionImageDialog(
          context, 
          (){bloc?.add(PIckImage());}, 
          (){bloc?.add(TakePhoto());}, 
        );
      },
      child: Container(
        width: 150,
        margin: EdgeInsets.only(top: 100),
        child: AspectRatio(
          aspectRatio: 1/1,
          child: ClipOval(
            child: state.file != null
            ? Image.file(
              state.file!, 
              fit: BoxFit.cover
            )
            : category != null ? FadeInImage.assetNetwork(
              placeholder: 'assets/img/user_image.png', 
              image: category!.image!,
              fit: BoxFit.cover,
              fadeInDuration: Duration(seconds: 1),
            ): Image.asset('assets/img/no-image.png', fit: BoxFit.cover,),
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