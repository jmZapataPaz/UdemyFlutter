import 'package:ecommerce_flutter/src/domain/utils/BlocFormItem.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/category/create/bloc/AdminCategoryCreateBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/category/create/bloc/AdminCategoryCreateEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/category/create/bloc/AdminCategoryCreateState.dart';
import 'package:ecommerce_flutter/src/presentation/utils/SelectOptionImageDialog.dart';
import 'package:ecommerce_flutter/src/presentation/widgets/DefaultIconBack.dart';
import 'package:ecommerce_flutter/src/presentation/widgets/DefaultTextField.dart';
import 'package:flutter/material.dart';

class AdminCategoryCreateContent extends StatelessWidget {

  AdminCategoryCreateBloc? bloc;
  AdminCategoryCreateState state;

  AdminCategoryCreateContent(this.bloc, this.state);

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
                    _imageCategory(context),
                    _cardCategoryForm(context),
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

  Widget _cardCategoryForm( BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
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
        margin: EdgeInsets.symmetric(
          horizontal: screenWidth * (isTablet ? 0.1 : 0.05), 
          vertical: screenWidth * (isTablet ? 0.05 : 0.08),
        ),
        child: Column(
          children: [
            _textNewCategory(context),
            _textFieldName(context),
            _textFieldDescription(context),
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
        top: screenWidth * (isTablet ? 0.05 : 0.08), 
        right: screenWidth * (isTablet ? 0.02 : 0.03),
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
          tooltip: 'Submit Category',
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

  Widget _textNewCategory(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        top: screenWidth * (isTablet ? 0.05 : 0.06), 
        bottom: screenWidth * (isTablet ? 0.025 : 0.03),
      ),
      child: Text('Nueva categoría',
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
          label: 'Nombre de la categoría', 
          icon: Icons.category, 
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
          label: 'Descripción de la categoría', 
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

  Widget _imageCategory(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return GestureDetector(
      onTap: () {
        SelectOptionImageDialog(
          context, 
          (){bloc?.add(PIckImage());}, 
          (){bloc?.add(TakePhoto());}, 
        );
      },
      child: Container(
        width: screenWidth * (isTablet ? 0.40 : 0.4),
        margin: EdgeInsets.only(top: screenWidth * (isTablet ? 0.15 : 0.25)),
        child: AspectRatio(
          aspectRatio: 1/1,
          child: ClipOval(
            child: state.file != null
            ? Image.file(
              state.file!, 
              fit: BoxFit.cover
            )
            :Image.asset('assets/img/agregar.png', fit: BoxFit.cover,),
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