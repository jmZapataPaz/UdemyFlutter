import 'package:ecommerce_flutter/injection.dart';
import 'package:ecommerce_flutter/src/data/dataSource/local/sharedPref.dart';
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

class ClientAddressListPage extends StatefulWidget {
  const ClientAddressListPage({super.key});

  @override
  State<ClientAddressListPage> createState() => _ClientAddressListPageState();
}

class _ClientAddressListPageState extends State<ClientAddressListPage> {
  ClientAddressListBloc? _bloc;
  String? _token;

  @override
  void initState() {
    super.initState();
    _recoverToken();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _bloc?.add(GetUserAddress());
    });
  }

  Future<void> _recoverToken() async {
    final sharedPref = SharedPref();
    final userSession = await sharedPref.read('user');
    if (userSession != null && userSession['token'] != null) {
      setState(() {
        _token = userSession['token'];
      });
    } else {
      print('No hay token guardado');
    }
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
      
      body: BlocListener<ClientAddressListBloc, ClientAddressListState>(
        listener: (context, state){
          final responseState = state.response;
          if(responseState is Success){
            if(responseState.data is bool && responseState.data == true){
              _bloc?.add(GetUserAddress()); 
            }
            else if(responseState.data is Order) {
              final shoppingBagUseCases = locator<ShoppingBagUseCases>();
              shoppingBagUseCases.deleteShoppingBagUseCase.run();
            }
          }
        },
        child: BlocBuilder<ClientAddressListBloc, ClientAddressListState>(
          builder: (context, state) {
            final responseState = state.response;
            bool hasAddresses = false;
            List<Address> addressList = [];

            if (responseState is Loading) {
              return Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepOrange,
                  ),
                ),
              );
            }
            if (responseState is Success && responseState.data is List<Address>) {
              addressList = responseState.data as List<Address>;
              hasAddresses = addressList.isNotEmpty;
              _bloc?.add(SetAddressSession(addressList: addressList));
            }
            if (responseState is Error) {
              return Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_off, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'No tienes direcciones guardadas',
                        style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Agrega una dirección para continuar',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: hasAddresses
                      ? ListView.builder(
                          itemCount: addressList.length,
                          itemBuilder: (context, index) {
                            return ClientAddressListItem(_bloc, state, addressList[index], index);
                          },
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.location_off, size: 64, color: Colors.grey),
                              SizedBox(height: 16),
                              Text(
                                'No tienes direcciones guardadas',
                                style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Agrega una dirección para continuar',
                                style: TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: hasAddresses && responseState is! Loading
                          ? () {
                              _bloc?.add(OnPaymentStripeSubmit());
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      child: responseState is Loading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Pagar',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}