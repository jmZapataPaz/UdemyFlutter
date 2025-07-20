import 'package:ecommerce_flutter/src/domain/models/Category.dart';
import 'package:ecommerce_flutter/src/domain/models/Product.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/product/list/ClientProductListItem.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/product/list/bloc/ClientProductListBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/product/list/bloc/ClientProductListEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/product/list/bloc/ClientProductListState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ClientProductListPage extends StatefulWidget {
  const ClientProductListPage({super.key});

  @override
  State<ClientProductListPage> createState() => _ClientProductListPageState();
}

class _ClientProductListPageState extends State<ClientProductListPage> {
  ClientProductListBloc? _bloc;
  Category? category;
  bool _initialized = false; 

  @override
  Widget build(BuildContext context) {
    category = ModalRoute.of(context)?.settings.arguments as Category;
    _bloc = BlocProvider.of<ClientProductListBloc>(context);
    if (!_initialized && category != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _bloc?.add(GetProductsByCategory(id_category: category!.id!));
      });
      _initialized = true;
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos - ${category?.name ?? "Categoría"}'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),

      body: BlocListener<ClientProductListBloc, ClientProductListState>(
        listener: (context, state){
          final responseState = state.response;
          if(responseState is Success){
            if(responseState.data is bool && responseState.data == true){
              _bloc?.add(GetProductsByCategory(id_category: category!.id!)); 
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
        child: BlocBuilder<ClientProductListBloc, ClientProductListState>(
          builder: (context, state){
            final responseState = state.response;
            if(responseState is Loading){
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            }
            if(responseState is Success){
              List<Product> products = responseState.data as List<Product>;
              if (products.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 64,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No hay productos en esta categoría',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index){
                  return ClientProductListItem(_bloc, products[index]);
                },
              );
            }
            return Center(
              child: Text(
                'Error al cargar productos',
                style: TextStyle(color: Colors.red),
              ),
            );
          },
        ),
      )
    );
  }
}