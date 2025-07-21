import 'package:ecommerce_flutter/src/presentation/pages/client/shoppingBag/Bloc/ClientShoppingBagBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/shoppingBag/Bloc/ClientShoppingBagEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/shoppingBag/Bloc/ClientShoppingBagState.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/shoppingBag/ClientShoppingBagBottomBar.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/shoppingBag/ClientShoppingBagItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientShoppingBagPage extends StatefulWidget {
  const ClientShoppingBagPage({super.key});

  @override
  State<ClientShoppingBagPage> createState() => _ClientShoppingBagPageState();
}

class _ClientShoppingBagPageState extends State<ClientShoppingBagPage> {

  ClientShoppingBagBloc? _bloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _bloc?.add(GetShoppingBag()); // Cargar productos del carrito
    });
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<ClientShoppingBagBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi orden de compra'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<ClientShoppingBagBloc, ClientShoppingBagState>(
        builder: (context, state) {
          if (state.products.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Tu carrito está vacío',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Agrega productos para continuar',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }
          
          return ListView.builder(
            itemCount: state.products.length,
            itemBuilder: (context, index){
              return ClientShoppingBagItem(_bloc, state, state.products[index]); // CORREGIR parámetros
            },
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<ClientShoppingBagBloc, ClientShoppingBagState>(
        builder: (context, state) {
          // CORREGIR: Mostrar directamente el BottomBar, no en ListView
          if (state.products.isNotEmpty) {
            return ClientShoppingBagBottomBar(state);
          }
          return SizedBox.shrink(); // No mostrar nada si no hay productos
        },
      ),
    );
  }
}