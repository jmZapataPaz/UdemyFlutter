import 'package:ecommerce_flutter/injection.dart';
import 'package:ecommerce_flutter/src/domain/models/Address.dart';
import 'package:ecommerce_flutter/src/domain/models/Order.dart';
import 'package:ecommerce_flutter/src/domain/useCases/shoppingBag/ShoppingBagUseCase.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/address/list/ClientAddressListItem.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/address/list/bloc/ClientAddressListBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/address/list/bloc/ClientAddressListEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/address/list/bloc/ClientAddressListState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ClientAddressListPage extends StatefulWidget {
  const ClientAddressListPage({super.key});

  @override
  State<ClientAddressListPage> createState() => _ClientAddressListPageState();
}

class _ClientAddressListPageState extends State<ClientAddressListPage> {

  ClientAddressListBloc? _bloc;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _bloc?.add(GetUserAddress());
    });
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<ClientAddressListBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Direcciones', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () async {
              final result = await Navigator.pushNamed(context, 'client/address/create');
              if (result == true) {
                _bloc?.add(GetUserAddress());
              }
            },
          ),
        ],
      ),
      
      bottomNavigationBar: Container(
        child: ElevatedButton(
          onPressed: (){
            _bloc?.add(OnPaymentStripeSubmit());
          }, 
          child: Text('Pagar')),
      ),

      body: BlocListener<ClientAddressListBloc, ClientAddressListState>(
        listener: (context, state){
          final responseState = state.response;
          if(responseState is Success){
            if(responseState.data is bool && responseState.data == true){
              _bloc?.add(GetUserAddress()); 
            }
            else if(responseState.data is Order) {
              Fluttertoast.showToast(
                msg: "¡Orden creada exitosamente!",
                backgroundColor: Colors.green,
                textColor: Colors.white,
              );
              final shoppingBagUseCases = locator<ShoppingBagUseCases>();
              shoppingBagUseCases.deleteShoppingBagUseCase.run();
            }
          }
          if(responseState is Error){
            Fluttertoast.showToast(
              msg: responseState.message,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
            );
          }
        },
        
        child: BlocBuilder<ClientAddressListBloc, ClientAddressListState>(
          builder: (context, state){
            final responseState = state.response;
            if(responseState is Success && responseState.data is List<Address>){
              List<Address> address = responseState.data as List<Address>;
              _bloc?.add(SetAddressSession(addressList: address));
              return ListView.builder(
                itemCount: address.length,
                itemBuilder: (context, index){
                  return ClientAddressListItem(_bloc, state, address[index], index);
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}