import 'package:ecommerce_flutter/src/domain/models/Category.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/category/list/AdminCategoryListItem.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/category/list/bloc/AdminCategoryListBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/category/list/bloc/AdminCategoryListEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/category/list/bloc/AdminCategoryListState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AdminCategoryListPage extends StatefulWidget {
  const AdminCategoryListPage({super.key});

  @override
  State<AdminCategoryListPage> createState() => _AdminCategoryListPageState();
}

class _AdminCategoryListPageState extends State<AdminCategoryListPage> {

  AdminCategoryListBloc? _bloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bloc?.add(GetCategory());
    });
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<AdminCategoryListBloc>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    return Scaffold(
      floatingActionButton: SizedBox(
        width: screenWidth * (isTablet ? 0.12 : 0.18),
        height: screenWidth * (isTablet ? 0.12 : 0.18),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'admin/category/create');
          },
          tooltip: 'Create Category',
          backgroundColor: Colors.black,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: screenWidth * (isTablet ? 0.06 : 0.08),
          ),
        ),
      ),
      body: BlocListener<AdminCategoryListBloc, AdminCategoryListState>(
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
        child: BlocBuilder<AdminCategoryListBloc, AdminCategoryListState>(
          builder: (context, state){
            final responseState = state.response;
            if(responseState is Success){
              List<Category> categories = responseState.data as List<Category>;
              return ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index){
                  return Admincategorylistitem(_bloc, categories[index]);
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