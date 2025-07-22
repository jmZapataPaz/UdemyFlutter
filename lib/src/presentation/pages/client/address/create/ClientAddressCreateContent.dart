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
            _textFieldAddress(),
            _textFieldNeighborhood(),
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
            bloc?.add(FormSubmitted());
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
      child: Text('Nueva dirección',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),
      ),
    );
  }

  Widget _textFieldAddress(){
    return DefaultTextField(
      label: 'Direccion', 
      icon: Icons.my_location, 
      onChanded: (text){
        bloc?.add(AddressChanged(address: BlocFormItem(value: text))); 
      },
      validator: (value){
        return state.address.error;
      },
      color: Colors.black,
    );
  }

  Widget _textFieldNeighborhood(){
    return DefaultTextField(
      label: 'Vecindario', 
      icon: Icons.location_on, 
      onChanded: (text){
        bloc?.add(NeighborhoodChanged(neighborhood: BlocFormItem(value: text))); 
      },
      validator: (value){
        return state.neighborhood.error;
      },
      color: Colors.black,
    );
  }


  Widget _imageCategory(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 50),
      child: Image.asset(
        'assets/img/location.png',
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width * 0.35,
        height: MediaQuery.of(context).size.width * 0.35,
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