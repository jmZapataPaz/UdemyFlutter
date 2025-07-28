import 'package:app_links/app_links.dart';
import 'package:ecommerce_flutter/injection.dart';
import 'package:ecommerce_flutter/src/blockProviders.dart';
import 'package:ecommerce_flutter/src/data/api/HttpInterceptor.dart';
import 'package:ecommerce_flutter/src/data/dataSource/local/sharedPref.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/category/create/AdminCategoryCreatePage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/category/update/AdminCategoryUpdatePage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/home/AdminHomePage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/order/detail/AdminOrderDetailPage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/product/create/AdminProductCreatePage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/product/list/AdminProductListPage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/product/update/AdminProductUpdatePage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/auth/login/LoginPage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/auth/register/RegisterPage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/address/create/ClientAddressCreatePage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/address/list/ClientAddressListPage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/home/ClientHomePage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/order/detail/ClientOrderDetailPage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/payment/success/PaymentSuccessPage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/product/detail/ClientProductDetailPage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/product/list/ClientProductListPage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/shoppingBag/ClientShoppingBagPage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/driver/home/DriverHomePage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/driver/order/detail/DriverOrderDetailPage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/driver/order/list/DriverOrderListPage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/profile/info/ProfileInfoPage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/profile/update/ProfileUpdatePage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/roles/RolesPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  
  final sharedPref = locator<SharedPref>();
  HttpInterceptor().initialize(sharedPref);
  
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final _appLinks = AppLinks();

  @override
  void initState() {
    super.initState();
    _listenToLinks();
    HttpInterceptor().navigatorKey = navigatorKey;
  }

  void _listenToLinks(){
    _appLinks.uriLinkStream.listen((Uri? uri){
      if(uri != null && uri.toString().contains('/success')){
        navigatorKey.currentState?.pushNamed('client/payment/success');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders,
      child: MaterialApp(
        builder: FToastBuilder(),
        navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false, 
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'register': (BuildContext context) => RegisterPage(),
        'roles': (BuildContext context) => RolesPage(),
        'client/home':(BuildContext context) => ClientHomePage(),
        'admin/home':(BuildContext context) => AdminHomePage(), 
        'admin/category/create': (BuildContext context) => AdminCategoryCreatePage(),
        'admin/category/update': (BuildContext context) => AdminCategoryUpdatePage(),
        'admin/product/list': (BuildContext context) => AdminProductListPage(),
        'admin/product/create': (BuildContext context) => AdminProductCreatePage(),
        'admin/product/update': (BuildContext context) => AdminProductUpdatePage(),
        'admin/order/detail': (BuildContext context) => AdminOrderDetailPage(),          
        'profile/info': (BuildContext context) => ProfileInfoPage(),
        'profile/update': (BuildContext context) => ProfileUpdatePage(),
        'client/product/list': (BuildContext context) => ClientProductListPage(),
        'client/product/detail': (BuildContext context) => ClientProductDetailPage(),
        'client/shoppingBag': (BuildContext context) => ClientShoppingBagPage(),
        'client/address/list': (BuildContext context) => ClientAddressListPage(),
        'client/address/create': (BuildContext context) => ClientAddressCreatePage(),
        'client/order/detail': (BuildContext context) => ClientOrderDetailPage(),        
        'client/payment/success': (BuildContext context) => PaymentSuccessPage(),
        'driver/home': (BuildContext context) => DriverHomePage(),
        'driver/order/list': (BuildContext context) => DriverOrderListPage(),
        'driver/order/detail': (BuildContext context) => DriverOrderDetailPage(),

      }
      ),
    );
  }
}
