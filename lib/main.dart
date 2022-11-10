import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:go_router/go_router.dart';
import '../../LanguageChangeProvider.dart';
import '../../core/data/hive_db.dart';
import '../../feautures/grocbay_pos/presentation/bloc/CategoriesBrands/CategoriesBrands_bloc.dart';
import '../../feautures/grocbay_pos/presentation/bloc/themeControllBloc/theme_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/http_override.dart';
import 'core/util/presentation/constants/ic_constants.dart';
import 'feautures/grocbay_pos/data/handler/firebase_notification_handler.dart';
import 'feautures/grocbay_pos/domain/entities/themedata/dash_page_info.dart';
import 'feautures/grocbay_pos/presentation/bloc/Loyalty/loyalty_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/VendorProduct/VendorProduct.dart';
import 'feautures/grocbay_pos/presentation/bloc/VendorProductVariation/VendorProductVariation.dart';
import 'feautures/grocbay_pos/presentation/bloc/cart/cart_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/checkout/check_out_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/customers/Register/register_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/customers/userprofile_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/delivery_list/delivery_list_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/edit_order_status/edit_order_status_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/edit_product/edit_product_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/getAllCount/get_All_Count_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/homepage/category/category_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/homepage/product/product_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/homepage/subcategory/subCategory_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/loginBloc/login_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/order/order_managment_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/picker_list/picker_list_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/promocode/promo_code_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/search/search_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/searchBarcode/search_barcode_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/shop/my_shop_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/shop_status/shopstatus.dart';
import 'feautures/grocbay_pos/presentation/bloc/update_order/update_order_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/update_order_status/update_order_status_bloc.dart';
import 'feautures/grocbay_pos/presentation/rought_genrator.dart';
import 'generated/l10n.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';
FirebaseNotifications notifications =FirebaseNotifications();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseNotifications notifications =FirebaseNotifications();
  notifications.setUpFirebase();
  // notifications.notificationConfig(
  //     onLaunch: (Map<String, dynamic> data){
  //       final notificationEncode = json.encode(data['notification']);
  //       final notificationDecode = json.decode(notificationEncode);
  //       final dataEncode = json.encode(data['data']);
  //       final dataDecode = json.decode(dataEncode);
  //       print("dataDecode..."+data['ref'].toString());
  //
  //       Navigation(context,
  //           navigatore: NavigatoreTyp.push,
  //           name: Routename.Home,
  //           parms: {
  //             'index':
  //             (DashBoardPageInfo({'oid': data['ref']})
  //                 .pagedatabvendore[6]
  //                 .pageKey)
  //                 .toLowerCase()
  //           },
  //           qparms: {
  //             'oid': data['ref']
  //           });
  //
  //     },onMessage: (Map<String, dynamic> data){
  //   final notificationEncode = json.encode(data['notification']);
  //   final notificationDecode = json.decode(notificationEncode);
  //   final dataEncode = json.encode(data['data']);
  //   final dataDecode = json.decode(dataEncode);
  //   Navigation(context,
  //       navigatore: NavigatoreTyp.push,
  //       name: Routename.Home,
  //       parms: {
  //         'index':
  //         (DashBoardPageInfo({'oid': data['ref']})
  //             .pagedatabvendore[6]
  //             .pageKey)
  //             .toLowerCase()
  //       },
  //       qparms: {
  //         'oid': data['ref']
  //       });
  // },onresume: (Map<String, dynamic> data){
  //   print("data...acv..."+data.toString());
  //   final notificationEncode = json.encode(data['notification']);
  //   final notificationDecode = json.decode(notificationEncode);
  //   final dataEncode = json.encode(data['data']);
  //   final dataDecode = json.decode(dataEncode);
  //   Navigation(context,
  //       navigatore: NavigatoreTyp.push,
  //       name: Routename.Home,
  //       parms: {
  //         'index':
  //         (DashBoardPageInfo({'oid': data['ref']})
  //             .pagedatabvendore[6]
  //             .pageKey)
  //             .toLowerCase()
  //       },
  //       qparms: {
  //         'oid': data['ref']
  //       });
  // });
  HttpOverrides.global = MyHttpOverrides();
  await HiveDB.init();
  await di.init();
  runApp( MyApp());
}

class MyApp extends StatelessWidget with Navigations{
  MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    notifications.notificationConfig(
        onLaunch: (Map<String, dynamic> data){
          final notificationEncode = json.encode(data['notification']);
          final notificationDecode = json.decode(notificationEncode);
          final dataEncode = json.encode(data['data']);
          final dataDecode = json.decode(dataEncode);
          print("dataDecode..."+data['ref'].toString());

          Navigation(context,
              navigatore: NavigatoreTyp.push,
              name: Routename.Home,
              parms: {
                'index':
                (DashBoardPageInfo({'oid': data['ref']})
                    .pagedatabvendore[6]
                    .pageKey)
                    .toLowerCase()
              },
              qparms: {
                'oid': data['ref']
              });

        },onMessage: (Map<String, dynamic> data){
      final notificationEncode = json.encode(data['notification']);
      final notificationDecode = json.decode(notificationEncode);
      final dataEncode = json.encode(data['data']);
      final dataDecode = json.decode(dataEncode);
      Navigation(context,
          navigatore: NavigatoreTyp.push,
          name: Routename.Home,
          parms: {
            'index':
            (DashBoardPageInfo({'oid': data['ref']})
                .pagedatabvendore[6]
                .pageKey)
                .toLowerCase()
          },
          qparms: {
            'oid': data['ref']
          });
    },onresume: (Map<String, dynamic> data){
      print("data...acv..."+data.toString());
      final notificationEncode = json.encode(data['notification']);
      final notificationDecode = json.decode(notificationEncode);
      final dataEncode = json.encode(data['data']);
      final dataDecode = json.decode(dataEncode);
      Navigation(context,
          navigatore: NavigatoreTyp.push,
          name: Routename.Home,
          parms: {
            'index':
            (DashBoardPageInfo({'oid': data['ref']})
                .pagedatabvendore[6]
                .pageKey)
                .toLowerCase()
          },
          qparms: {
            'oid': data['ref']
          });
    });
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<SearchBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<SubcategoryBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<CategoryBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<ProductBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<UserProfileBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<CheckOutBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<LoginBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<CartItemBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<LoyaltyBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<MyShopBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<RegisterBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<PromoCodeBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<OrderManagmentBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<ThemeBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<ShopstatusBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<VendorProductVariationBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<VendorProductBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<CategoriesBrandsBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<UpdateOrderBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<DeliveryListBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<PickerListBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<UpdateOrderStatusBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<EditOrderStatusBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<GetAllCountBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<SearchBarcodeBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<EditProductBloc>(),
        ),
      ],
      child:  BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, ThemeState states) {
          final _router = GoRouter(
            // errorPageBuilder: (context,state)=>MaterialPage(child: Scaffold(body: Center(
            //  child:  Text(state.error.toString()),
            // ),)
            // ),
            redirect: (state){
              debugPrint("path redirect:${state.location}");
              if(state.location != "/admin") {
                return (sl<SharedPreferences>().containsKey(Prefrence.LOGEDIN) && sl<SharedPreferences>().getBool(Prefrence.LOGEDIN)! )? null:"/admin";
              }else if(state.location == "/admin"){
                debugPrint("login redirect request");
                return (sl<SharedPreferences>().containsKey(Prefrence.LOGEDIN) && sl<SharedPreferences>().getBool(Prefrence.LOGEDIN)! )? "/admin/home":null;
              }
              // debugPrint("redirect subloc: ${state.subloc}");
              // if(Features.isOnBoarding&&state.path==nUri(Routename.Home).path) {
              //   if ( PrefUtils.prefs!.containsKey('introduction')&& PrefUtils.prefs!.getBool('introduction')==false) {
              //   return nUri(Routename.Introduction).path;
              //   }
              // }
              return null;
            },
            // refreshListenable: loadinginfo,
            // urlPathStrategy: UrlPathStrategy.path,
            initialLocation:"/admin/",
            debugLogDiagnostics:kDebugMode,
            routes: PageControler().routs,
          );
          return FlutterSizer(builder: (context , oriantation , type ) {
            if (kDebugMode) {
              debugPrint("theme changed ${(states.props.first as ThemesData?)?.name.name}");
            }
            return ChangeNotifierProvider<LanguageChangeProvider>(
              create: (context) =>  LanguageChangeProvider(),
              child: Builder(
                builder: (context) =>
                    MaterialApp.router(
                      locale: Provider.of<LanguageChangeProvider>(context, listen: true).currentLocale,
                      localizationsDelegates: [
                        S.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      supportedLocales: S.delegate.supportedLocales,
                      scrollBehavior: MyCustomScrollBehavior(),
                      title: 'POS',
                      theme: (states.props.first as ThemesData?)?.theme,
                      routeInformationParser: _router.routeInformationParser,
                      routerDelegate: _router.routerDelegate,
                    ),
              ),
            );

          },

          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
class MyCustomScrollBehavior extends MaterialScrollBehavior {
// Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}