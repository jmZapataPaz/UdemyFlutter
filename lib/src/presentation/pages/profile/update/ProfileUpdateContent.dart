import 'package:ecommerce_flutter/src/domain/models/User.dart';
import 'package:ecommerce_flutter/src/domain/utils/BlocFormItem.dart';
import 'package:ecommerce_flutter/src/presentation/pages/profile/update/bloc/ProfileUpdateBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/profile/update/bloc/ProfileUpdateEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/profile/update/bloc/ProfileUpdateState.dart';
import 'package:ecommerce_flutter/src/presentation/utils/SelectOptionImageDialog.dart';
import 'package:ecommerce_flutter/src/presentation/widgets/DefaultIconBack.dart';
import 'package:ecommerce_flutter/src/presentation/widgets/DefaultTextField.dart';
import 'package:flutter/material.dart';

class ProfileUpdateContent extends StatelessWidget {
  ProfileUpdateBloc? bloc;
  ProfileUpdateState state;
  User? user;
  ProfileUpdateContent(this.bloc, this.state, this.user);

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
                  _imageProfile(context), 
                  _cardProfileInfo(context)
                ],
              ),
            ),
          ),
          DefaultIconBack(
            left: screenWidth * 0.05, 
            top: MediaQuery.of(context).padding.top + 10,
          ),
        ],
      ),
    );
  }

  Widget _imageBackground(BuildContext context) {
    return Image.asset(
      'assets/img/background3.jpg',
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      fit: BoxFit.cover,
      color: Color.fromRGBO(0, 0, 0, 0.7),
      colorBlendMode: BlendMode.darken,
    );
  }

  Widget _imageProfile(BuildContext context){ 
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    return GestureDetector(
      onTap: () {
        SelectOptionImageDialog(
          context, 
          (){ bloc?.add(ProfileUpdatePickImage()); },
          (){ bloc?.add(ProfileUpdateTakePhoto()); }
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: screenWidth * (isTablet ? 0.15 : 0.25)),
        width: screenWidth * (isTablet ? 0.40 : 0.4),
        child: AspectRatio(
          aspectRatio: 1/1,
          child: ClipOval(
            child: state.image != null 
              ? Image.file(state.image!, fit: BoxFit.cover)
              : (user?.image != null && user!.image!.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      placeholder: 'assets/img/user_image.png', 
                      image: user!.image!,
                      fit: BoxFit.cover,
                      fadeInDuration: Duration(seconds: 1),
                    )
                  : Image.asset(
                      'assets/img/agregar.png',
                      fit: BoxFit.cover,
                    )
                ),
          ),
        ),
      ),
    );
  }

  Widget _cardProfileInfo(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.44,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.7),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35), 
          topRight: Radius.circular(35)
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: screenWidth * (isTablet ? 0.1 : 0.05), 
          vertical: screenWidth * (isTablet ? 0.05 : 0.08),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _textUpdateInfo(context),
              _textFieldName(context),
              _textFieldLastName(context),
              _textFieldPhone(context),
              _fabSubmit(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fabSubmit(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return Container(
      alignment: Alignment.centerRight,

      child: SizedBox(
        width: screenWidth * (isTablet ? 0.12 : 0.15),
        height: screenWidth * (isTablet ? 0.12 : 0.15),
        child: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: (){
            bloc?.add(ProfileUpdateFormSubmitted());
          },
          child: Icon(
            Icons.check, 
            color: Colors.white,
            size: screenWidth * (isTablet ? 0.05 : 0.06),
          ),
        ),
      ),
    );
  }

  Widget _textUpdateInfo(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        top: screenWidth * (isTablet ? 0.05 : 0.06), 
        bottom: screenWidth * (isTablet ? 0.025 : 0.03),
      ),
      child: Text(
        'Actualizar Información',
        style: TextStyle(
          color: Colors.black,
          fontSize: screenWidth * (isTablet ? 0.04 : 0.05),
          fontWeight: FontWeight.bold,
        ),
      )
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
          label: "Nombre", 
          color: Colors.black,
          icon: Icons.person, 
          initialValue: user?.name ?? '',
          onChanded: (text){
            bloc?.add(ProfileUpdateNameChanged(name: BlocFormItem(value: text)));
          },
          validator: (value){
            return state.name.error;
          },                   
        ),
      ),
    );
  }

  Widget _textFieldLastName(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: screenWidth * (isTablet ? 0.02 : 0.025)),
      child: Transform.scale(
        scale: isTablet ? 1.15 : 1.0,
        child: DefaultTextField(
          label: "Apellido", 
          color: Colors.black,
          icon: Icons.person_outline, 
          initialValue: user?.lastname ?? '',
          onChanded: (text){
            bloc?.add(ProfileUpdateLastNameChanged(lastname: BlocFormItem(value: text)));
          },
          validator: (value){
            return state.lastname.error;
          },                    
        ),
      ),
    );
  }

  Widget _textFieldPhone(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: screenWidth * (isTablet ? 0.02 : 0.025)),
      child: Transform.scale(
        scale: isTablet ? 1.15 : 1.0,
        child: DefaultTextField(
          label: "Teléfono", 
          color: Colors.black,
          icon: Icons.phone, 
          initialValue: user?.phone ?? '',
          onChanded: (text){
            bloc?.add(ProfileUpdatePhoneChanged(phone: BlocFormItem(value: text)));
          },
          validator: (value){
            return state.phone.error;
          },                     
        ),
      ),
    );
  }
}