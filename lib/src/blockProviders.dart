import 'package:ecommerce_flutter/injection.dart';
import 'package:ecommerce_flutter/src/domain/useCases/address/AddressUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/auth/authUseCases.dart';
import 'package:ecommerce_flutter/src/domain/useCases/categories/CategoryUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/orders/OrdersUseCases.dart';
import 'package:ecommerce_flutter/src/domain/useCases/products/ProductUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/shoppingBag/ShoppingBagUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/user/UserUseCase.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/category/create/bloc/AdminCategoryCreateBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/category/list/bloc/AdminCategoryListBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/category/update/bloc/AdminCategoryUpdateBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/home/bloc/AdminHomeBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/order/detail/bloc/AdminOrderDetailBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/order/list/bloc/AdminOrderListBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/product/create/bloc/AdminProductCreateBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/product/list/bloc/AdminProductListBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/product/update/bloc/AdminProductUpdateBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/auth/login/bloc/LoginBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/auth/register/bloc/RegisterBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/auth/register/bloc/RegisterEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/address/create/bloc/ClientAddressCreateBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/address/create/bloc/ClientAddressCreateEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/address/list/bloc/ClientAddressListBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/category/list/bloc/ClientCategoryListBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/home/bloc/ClientHomeBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/order/list/bloc/ClientOrderListBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/product/detail/bloc/ClientProductDetailBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/product/list/bloc/ClientProductListBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/shoppingBag/Bloc/ClientShoppingBagBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/driver/home/bloc/DriverHomeBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/driver/order/detail/bloc/DriverOrderDetailBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/driver/order/list/bloc/DriverOrderListBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/profile/info/bloc/ProfileInfoBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/profile/info/bloc/ProfileInfoEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/profile/update/bloc/ProfileUpdateBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/roles/bloc/RolesBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/roles/bloc/RolesEvent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<LoginBloc>(
    create: (context) => LoginBloc(locator<AuthUseCases>()).. add(InitEvent())),
  BlocProvider<RegisterBloc>(
    create: (context) => RegisterBloc(locator<AuthUseCases>())..add(RegisterInitEvent())),
  BlocProvider<RolesBloc>(
    create: (context) => RolesBloc(locator<AuthUseCases>())..add(GetRolesList())),
  BlocProvider<AdminHomeBloc>(
    create: (context) => AdminHomeBloc(locator<AuthUseCases>())),
  BlocProvider<ProfileInfoBloc>(
    create: (context) => ProfileInfoBloc(locator<AuthUseCases>())..add(ProfileInfoGetUser())),
  BlocProvider<ProfileUpdateBloc>(
    create: (context) => ProfileUpdateBloc(locator<UserUseCase>(), locator<AuthUseCases>())),
  BlocProvider<AdminCategoryCreateBloc>(
    create: (context) => AdminCategoryCreateBloc(locator<CategoryUseCase>())),
  BlocProvider<AdminCategoryListBloc>(
    create: (context) => AdminCategoryListBloc(locator<CategoryUseCase>())),
  BlocProvider<AdminCategoryUpdateBloc>(
    create: (context) => AdminCategoryUpdateBloc(locator<CategoryUseCase>())),
  BlocProvider<AdminProductCreateBloc>(
    create: (context) => AdminProductCreateBloc(locator<ProductUseCase>())),
  BlocProvider<AdminProductListBloc>(
    create: (context) => AdminProductListBloc(locator<ProductUseCase>())),
  BlocProvider<AdminProductUpdateBloc>(
  create: (context) => AdminProductUpdateBloc(locator<ProductUseCase>())),
  BlocProvider<ClientHomeBloc>(
    create: (context) => ClientHomeBloc(locator<AuthUseCases>())),
  BlocProvider<ClientCategoryListBloc>(
    create: (context) => ClientCategoryListBloc(locator<CategoryUseCase>())),
  BlocProvider<ClientProductListBloc>(
    create: (context) => ClientProductListBloc(locator<ProductUseCase>())),
  BlocProvider<ClientProductDetailBloc>(
    create: (context) => ClientProductDetailBloc(locator<ShoppingBagUseCases>())),
  BlocProvider<ClientShoppingBagBloc>(
    create: (context) => ClientShoppingBagBloc(locator<ShoppingBagUseCases>())),
  BlocProvider<ClientAddressCreateBloc>(
    create: (context) => ClientAddressCreateBloc(locator<AddressUseCase>(),locator<AuthUseCases>())..add(ClientAddressCreateInitEvent())),  
  BlocProvider<ClientAddressListBloc>(
    create: (context) => ClientAddressListBloc(locator<AddressUseCase>(), locator<AuthUseCases>(), locator<OrdersUseCases>())),
  BlocProvider<AdminOrderListBloc>(
    create: (context) => AdminOrderListBloc(locator<OrdersUseCases>())),
  BlocProvider<AdminOrderDetailBloc>(
    create: (context) => AdminOrderDetailBloc(locator<OrdersUseCases>())),
  BlocProvider<ClientOrderListBloc>(
    create: (context) => ClientOrderListBloc(locator<OrdersUseCases>(), locator<AuthUseCases>())),
  BlocProvider<DriverHomeBloc>(
    create: (context) => DriverHomeBloc(locator<AuthUseCases>())),
  BlocProvider<DriverOrderDetailBloc>(
    create: (context) => DriverOrderDetailBloc(locator<OrdersUseCases>())),
  BlocProvider<DriverOrderListBloc>(
    create: (context) => DriverOrderListBloc(locator<OrdersUseCases>(), locator<AuthUseCases>())),  


];