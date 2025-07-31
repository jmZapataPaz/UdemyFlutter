import 'package:ecommerce_flutter/src/domain/models/User.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/src/presentation/pages/profile/info/bloc/ProfileInfoBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/profile/info/bloc/ProfileInfoEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/profile/update/ProfileUpdateContent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/profile/update/bloc/ProfileUpdateBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/profile/update/bloc/ProfileUpdateEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/profile/update/bloc/ProfileUpdateState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({super.key});

  @override
  State<ProfileUpdatePage> createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {
  ProfileUpdateBloc? _bloc;
  bool _initialized = false;

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<ProfileUpdateBloc>(context);
    User? user = ModalRoute.of(context)?.settings.arguments as User?;
    if (user != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _bloc?.add(ProfileUpdateResetEvent()); 
        _bloc?.add(ProfileUpdateInitEvent(user: user));
      });
    }
    
    return Scaffold(
      body: BlocListener<ProfileUpdateBloc, ProfileUpdateState>(
        listener: (context, state){
          final responseState = state.response;
          if(responseState is Success){
            User user = responseState.data as User;
            print('Usuario actualizado: ${user.toJson()}');
            _bloc?.add(ProfileUpdateUpdateUserSession(user: user));
            Future.delayed(Duration(seconds: 1), () {
              context.read<ProfileInfoBloc>().add(ProfileInfoGetUser());
            });
            Fluttertoast.showToast(
              msg: "Perfil actualizado correctamente",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
            );
          } else if(responseState is Error){
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
        child: BlocBuilder<ProfileUpdateBloc, ProfileUpdateState>(
          builder: (context, state) {
            final responseState = state.response;
                if (responseState is Loading) {
                  return Stack(
                    children: [
                      ProfileUpdateContent(_bloc, state, user),
                      Center(child: CircularProgressIndicator())
                    ],
                  );
                }
            return ProfileUpdateContent(_bloc, state, user);
          },
        ),
      ),
    );
  }
}