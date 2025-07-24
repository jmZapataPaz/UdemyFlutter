import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/address/create/ClientAddressCreateContent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/address/create/bloc/ClientAddressCreateBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/address/create/bloc/ClientAddressCreateState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ClientAddressCreatePage extends StatefulWidget {
  const ClientAddressCreatePage({super.key});

  @override
  State<ClientAddressCreatePage> createState() => _ClientAddressCreatePageState();
}

class _ClientAddressCreatePageState extends State<ClientAddressCreatePage> {

  ClientAddressCreateBloc? _bloc;
  ClientAddressCreateState? state;

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<ClientAddressCreateBloc>(context);
    return Scaffold(
      body: BlocListener<ClientAddressCreateBloc, ClientAddressCreateState>(
        listenWhen: (previous, current) {
          return (previous.response is Loading && current.response is! Loading) ||
                 (previous.response is! Error && current.response is Error);
        },
        listener: (context, state){
          final responseState = state.response;
          if (responseState is Success){
            Navigator.pop(context, true);
            
            Fluttertoast.showToast(
              msg: 'Dirección creada correctamente',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
            );
          } else if (responseState is Error) {
            Fluttertoast.showToast(
              msg: responseState.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
            );
          }
        },
        child: BlocBuilder<ClientAddressCreateBloc, ClientAddressCreateState>(
          builder: (context, state){
            this.state = state;
            return ClientAddressCreateContent(_bloc, state);
          },
        ),
      )
    );
  }
}