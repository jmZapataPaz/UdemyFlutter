import 'package:ecommerce_flutter/src/domain/utils/BlocFormItem.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/address/create/bloc/ClientAddressCreateBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/address/create/bloc/ClientAddressCreateState.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/address/create/bloc/ClientAddressCreateEvent.dart';
import 'package:ecommerce_flutter/src/presentation/widgets/DefaultIconBack.dart';
import 'package:ecommerce_flutter/src/presentation/widgets/DefaultTextField.dart';
import 'package:flutter/material.dart';

class ClientAddressCreateContent extends StatelessWidget {

  ClientAddressCreateBloc? bloc;
  ClientAddressCreateState state;

  ClientAddressCreateContent(this.bloc, this.state);

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
                    _imageAddress(context),
                    _cardAddressForm(context),
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

  Widget _cardAddressForm( BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    bool isTablet = screenWidth > 600;
    
    return Container(
      width: double.infinity,
      height: screenHeight * (isTablet ? 0.45 : 0.43),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.7),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
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
              _textNewCategory(context),
              _textFieldAddress(context),
              _textFieldNeighborhood(context),
              _fabSubmit(context)
            ],
          ),
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
      ),
      child: SizedBox(
        width: screenWidth * (isTablet ? 0.12 : 0.15),
        height: screenWidth * (isTablet ? 0.12 : 0.15),
        child: FloatingActionButton(
          onPressed: () {
            if(state.formKey!.currentState!.validate()) {
              bloc?.add(FormSubmitted());
            }
          },
          tooltip: 'Submit Address',
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
      child: Text('Nueva dirección',
        style: TextStyle(
          fontSize: screenWidth * (isTablet ? 0.04 : 0.05),
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),
      ),
    );
  }

  Widget _textFieldAddress(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: screenWidth * (isTablet ? 0.02 : 0.025)),
      child: Transform.scale(
        scale: isTablet ? 1.15 : 1.0,
        child: DefaultTextField(
          label: 'Dirección', 
          icon: Icons.my_location, 
          onChanded: (text){
            bloc?.add(AddressChanged(address: BlocFormItem(value: text))); 
          },
          validator: (value){
            return state.address.error;
          },
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _textFieldNeighborhood(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: screenWidth * (isTablet ? 0.02 : 0.025)),
      child: Transform.scale(
        scale: isTablet ? 1.15 : 1.0,
        child: DefaultTextField(
          label: 'Vecindario', 
          icon: Icons.location_on, 
          onChanded: (text){
            bloc?.add(NeighborhoodChanged(neighborhood: BlocFormItem(value: text))); 
          },
          validator: (value){
            return state.neighborhood.error;
          },
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _imageAddress(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + (screenWidth * (isTablet ? 0.08 : 0.12))),
      child: Image.asset(
        'assets/img/location.png',
        fit: BoxFit.cover,
        width: screenWidth * (isTablet ? 0.40 : 0.35),
        height: screenWidth * (isTablet ? 0.40 : 0.35),
      ),
    );
  }

  Widget _imageBackground(BuildContext context) {
    return Image.asset('assets/img/address_background2.jpg',
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      fit: BoxFit.cover,
      color: Color.fromRGBO(0, 0, 0, 0.7),
      colorBlendMode: BlendMode.darken,
    );
  }
}