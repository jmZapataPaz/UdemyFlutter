import 'package:ecommerce_flutter/src/domain/models/Product.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/product/list/bloc/AdminProductListBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/product/list/bloc/AdminProductListEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/product/update/AdminProductUpdateContent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/product/update/bloc/AdminProductUpdateBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/product/update/bloc/AdminProductUpdateEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/product/update/bloc/AdminProductUpdateState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AdminProductUpdatePage extends StatefulWidget {
  const AdminProductUpdatePage({super.key});

  @override
  State<AdminProductUpdatePage> createState() => _AdminProductUpdatePageState();
}

class _AdminProductUpdatePageState extends State<AdminProductUpdatePage> {

  AdminProductUpdateBloc? _bloc;
  Product? product;
  bool _initialized = false;

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<AdminProductUpdateBloc>(context);
    product = ModalRoute.of(context)?.settings.arguments as Product;
    
    if (!_initialized && product != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _bloc?.add(ResetForm()); 
        _bloc?.add(AdminProductUpdateInitEvent(product: product)); 
      });
      _initialized = true;
    }
    
    return Scaffold(
      body: BlocListener<AdminProductUpdateBloc, AdminProductUpdateState>(
        listener: (context, state){
          final responseState = state.response;
          if(responseState is Success){
            context.read<AdminProductListBloc>().add(GetProductsByCategory(id_category: product!.id_category));
            Fluttertoast.showToast(
              msg: 'Producto actualizado correctamente', 
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
            );
          }else if(responseState is Error){
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
        child: BlocBuilder<AdminProductUpdateBloc, AdminProductUpdateState>(
          builder: (context, state) {
            return AdminProductUpdateContent(_bloc, state, product);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc?.add(ResetForm());
    super.dispose();
  }
}