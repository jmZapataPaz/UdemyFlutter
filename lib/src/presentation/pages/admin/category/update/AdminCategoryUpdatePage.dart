import 'package:ecommerce_flutter/src/domain/models/Category.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/category/list/bloc/AdminCategoryListBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/category/list/bloc/AdminCategoryListEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/category/update/AdminCategoryUpdateContent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/category/update/bloc/AdminCategoryUpdateBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/category/update/bloc/AdminCategoryUpdateEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/category/update/bloc/AdminCategoryUpdateState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AdminCategoryUpdatePage extends StatefulWidget {
  const AdminCategoryUpdatePage({super.key});

  @override
  State<AdminCategoryUpdatePage> createState() => _AdminCategoryUpdatePageState();
}

class _AdminCategoryUpdatePageState extends State<AdminCategoryUpdatePage> {
  Category? category;
  AdminCategoryUpdateBloc? _bloc;
  bool _initialized = false;

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<AdminCategoryUpdateBloc>(context);
    category = ModalRoute.of(context)?.settings.arguments as Category;
    
    // Resetear y luego inicializar cuando la categoría esté disponible
    if (!_initialized && category != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _bloc?.add(ResetForm()); // Primero resetear
        _bloc?.add(AdminCategoryUpdateInitEvent(category: category)); // Luego inicializar
      });
      _initialized = true;
    }
    
    return Scaffold(
      body: BlocListener<AdminCategoryUpdateBloc, AdminCategoryUpdateState>(
        listener: (context, state){
          final responseState = state.response;
          if(responseState is Success){
            context.read<AdminCategoryListBloc>().add(GetCategory());
            Navigator.pop(context); // Regresar después del éxito
            Fluttertoast.showToast(
              msg: 'Categoría actualizada correctamente',
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
        child: BlocBuilder<AdminCategoryUpdateBloc, AdminCategoryUpdateState>(
          builder: (context, state) {
            return AdminCategoryUpdateContent(_bloc, state, category);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Resetear cuando se cierre la página
    _bloc?.add(ResetForm());
    super.dispose();
  }
}