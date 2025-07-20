import 'package:ecommerce_flutter/src/domain/models/Category.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/category/list/ClientCategoryListItem.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/category/list/bloc/ClientCategoryListBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/category/list/bloc/ClientCategoryListState.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/category/list/bloc/clientCategoryListEvent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ClientCategoryListPage extends StatefulWidget {
  const ClientCategoryListPage({super.key});

  @override
  State<ClientCategoryListPage> createState() => _ClientCategoryListPageState();
}

class _ClientCategoryListPageState extends State<ClientCategoryListPage> {

  ClientCategoryListBloc? _bloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bloc?.add(GetCategory());
    });
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<ClientCategoryListBloc>(context);
    return Scaffold(
      
      body: BlocListener<ClientCategoryListBloc, ClientCategoryListState>(
        listener: (context, state){
          final responseState = state.response;
          if(responseState is Success){
            if(responseState.data is bool && responseState.data == true){
              _bloc?.add(GetCategory()); 
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
        child: BlocBuilder<ClientCategoryListBloc, ClientCategoryListState>(
          builder: (context, state){
            final responseState = state.response;
            if(responseState is Success){
              List<Category> categories = responseState.data as List<Category>;
              return ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index){
                  return ClientCategorylistitem(_bloc, categories[index]);
                },
              );
            }
          return Container();
          },
        ),
      )
    );
  }
}