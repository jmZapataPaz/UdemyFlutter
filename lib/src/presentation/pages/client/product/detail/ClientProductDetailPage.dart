import 'package:ecommerce_flutter/src/domain/models/Product.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/product/detail/ClientProductDetailContent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/product/detail/bloc/ClientProductDetailBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/product/detail/bloc/ClientProductDetailEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/product/detail/bloc/ClientProductDetailState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ClientProductDetailPage extends StatefulWidget {
  const ClientProductDetailPage({super.key});

  @override
  State<ClientProductDetailPage> createState() => _ClientProductDetailPageState();
}

class _ClientProductDetailPageState extends State<ClientProductDetailPage> {

  Product? product;
  ClientProductDetailBloc? _bloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _bloc?.add(GetProducts(product!));
    });
  }

  @override
  void dispose() {
    _bloc?.add(ResetState());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    product = ModalRoute.of(context)?.settings.arguments as Product?;
    _bloc = BlocProvider.of<ClientProductDetailBloc>(context);
    return Scaffold(
      appBar: AppBar(
      ),
      body: BlocListener<ClientProductDetailBloc, ClientProductDetailState>(
        listener: (context, state) {
          if (state.productAdded) {
            _showAddedToCartMessage();
          }
        },
        child: BlocBuilder<ClientProductDetailBloc, ClientProductDetailState>(
          builder: (context, state) {
            return ClientProductDetailContent(_bloc, state, product);
          },
        ),
      )
    );
  }

  void _showAddedToCartMessage() {
    Fluttertoast.showToast(
      msg: "Producto añadido a tu carrito",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0
    );
  }
}