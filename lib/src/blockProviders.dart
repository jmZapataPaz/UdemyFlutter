import 'package:ecommerce_flutter/injection.dart';
import 'package:ecommerce_flutter/src/domain/useCases/auth/authUseCases.dart';
import 'package:ecommerce_flutter/src/presentation/pages/auth/login/LoginBlocCubit.dart';
import 'package:ecommerce_flutter/src/presentation/pages/auth/register/RegisterBlocCubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<LoginBlocCubit>(
    create: (context) => LoginBlocCubit(locator<AuthUseCases>()),
  ),
  BlocProvider<RegisterBlocCubit>(
    create: (context) => RegisterBlocCubit(locator<AuthUseCases>()),
  ),
];