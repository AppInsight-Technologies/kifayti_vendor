
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kifayti_vendor/feautures/grocbay_pos/presentation/view/screen/checkout_mobileview.dart';
import 'package:kifayti_vendor/feautures/grocbay_pos/presentation/view/screen/search_order_screen.dart';
import 'package:kifayti_vendor/feautures/grocbay_pos/presentation/view/screen/vendor/editproduct.dart';


import '../domain/entities/VendorProductVariation_model.dart';
import 'view/screen/Login.dart';
import 'view/screen/dash_board.dart';
enum Routename{
  Home,Login,CheckoutMobile,EditVendorProduct,VendorProductVariation,SearchOrderScreen
}

enum NavigatoreTyp{
  push,pop,pushReplacment,popUntill,homenav
}


class PageControler extends Navigations  {
  PageControler() {}

  get routs =>[
    GoRoute(path: '/',builder: (context,state){
      return Container();
    },routes: [

      GoRoute(path:nUri(Routename.Login).path+"/home",redirect: (_)=> '/'+nUri(Routename.Login).path+'/'+nUri(Routename.Home).path+"/dashboard" ),
      GoRoute(name:nUri(Routename.Login).name ,path: nUri(Routename.Login).path,builder: (context,state){
        // print("Intilaizes ${state.params["branch"]}");
        // return DashBoard();
        return  Login();
      },routes: [
        GoRoute(
          name: nUri(Routename.Home).name,
          path: nUri(Routename.Home).path+'/:index',
          builder: (context, state) => DashBoard(key: state.pageKey, params: state.params, qparams: state.queryParams),
        ),
        GoRoute(
          name: nUri(Routename.CheckoutMobile).name,
          path: nUri(Routename.CheckoutMobile).path,
          builder: (context, state) => CheckoutMobileView(),
        ),
        GoRoute(
          name: nUri(Routename.EditVendorProduct).name,
          path: nUri(Routename.EditVendorProduct).path,
          builder: (context, state) => EditVendorProduct(qparams: state.queryParams),
        ),
        GoRoute(
          name: nUri(Routename.VendorProductVariation).name,
          path: nUri(Routename.VendorProductVariation).path,
          builder: (context, state) => VendorProductVariation(),
        ),
        GoRoute(
          name: nUri(Routename.SearchOrderScreen).name,
          path: nUri(Routename.SearchOrderScreen).path,
          builder: (context, state) => SearchOrderScreen(),

        ),
        // GoRoute(
        //   name: nUri(Routename.updateOrder).name,
        //   path: nUri(Routename.updateOrder).path+"/:id",
        //   builder: (context, state) =>UpdateOrderScreen(key: state.pageKey,params:state.params),
        // ),
        /*  GoRoute(path: nUri(Routename.Splash).path, builder: (context, state) =>SplashScreenPage(),),
      GoRoute(name: nUri(Routename.Loyalty).name,path: nUri(Routename.Loyalty).path, builder: (context, state) =>WalletScreen(state.queryParams),),
      GoRoute(name: nUri(Routename.Wallet).name,path: nUri(Routename.Wallet).path, builder: (context, state) =>WalletScreen(state.queryParams),),
      GoRoute(name: nUri(Routename.Cart).name,path: nUri(Routename.Cart).path, builder: (context, state) =>CartScreen(*//*state.params*//*state.queryParams),),
      GoRoute(name: nUri(Routename.SignUpScreen).name,path: nUri(Routename.SignUpScreen).path, builder: (context, state) =>SignupSelectionScreen(),),
      GoRoute(name: nUri(Routename.OtpConfirm).name,path: nUri(Routename.OtpConfirm).path, builder: (context, state) =>OtpconfirmScreen(state.queryParams),), //todo
      GoRoute(name: nUri(Routename.SignUp).name,path: nUri(Routename.SignUp).path, builder: (context, state) =>SignupScreen(),), //todo
      GoRoute(name: nUri(Routename.AboutUs).name, path: nUri(Routename.AboutUs).path, builder: (context, state) =>   AboutScreen()),
      GoRoute(name: nUri(Routename.Privacy).name, path: nUri(Routename.Privacy).path, builder: (context, state) =>   PrivacyScreen()),
      GoRoute(name: nUri(Routename.Shoppinglist).name,path: nUri(Routename.Shoppinglist).path, builder: (context, state) =>ShoppinglistScreen(),),
      // GoRoute(name: nUri(Routename.Category),path: nUri(Routename.Category), builder: (context, state) =>CategoryScreen(),),
      GoRoute(name: nUri(Routename.Category).name,path: nUri(Routename.Category).path, builder: (context, state) =>CategoryScreen(),),
      GoRoute(name: nUri(Routename.Introduction).name,path: nUri(Routename.Introduction).path, builder: (context, state) =>introductionscreen(),),
      GoRoute(name: nUri(Routename.ItemScreen).name,path: nUri(Routename.ItemScreen).path, builder: (context, state) =>ItemsScreen(state.queryParams),),
      // GoRoute(name: nUri(Routename.ItemScreen).name,path: "${nUri(Routename.ItemScreen).path}/:catId/:subcatId", builder: (context, state) =>ItemsScreen(state.params),),
      // GoRoute(path: '/splash', pageBuilder: (context, state) =>  MaterialPage(child: Scaffold(body: Center(child:  Text("Loading...\n ${state.path}\n ${state.fullpath} \n ${state.location} end"),),)),),
      GoRoute(name: nUri(Routename.ShoppinglistItem).name,path: nUri(Routename.ShoppinglistItem).path+"/:id/:name", builder: (context, state) =>ShoppinglistitemsScreen(state.params),),
      GoRoute(name: nUri(Routename.Membership).name,path: "${nUri(Routename.Membership).path}", builder: (context, state) =>MembershipScreen(),),
      GoRoute(path: "share", builder: (context, state)  =>  SingleproductScreen(state.queryParams["id"]!),),
      GoRoute(path: "refer", builder: (context, state) {
        PrefUtils.prefs!.setString("referCodeDynamic", state.queryParams["id"]!);
        return HomeScreen();
      }),
      GoRoute(name: nUri(Routename.MapScreen).name,path: nUri(Routename.MapScreen).path, builder: (context, state) => MapScreen(state.queryParams),),
      GoRoute(name: nUri(Routename.Login).name,path: nUri(Routename.Login).path, builder: (context, state) => LoginScreen(state.queryParams),),
      GoRoute(name: nUri(Routename.MyOrders).name,path: nUri(Routename.MyOrders).path, builder: (context, state) =>MyorderScreen(state.queryParams),),
      GoRoute(name: nUri(Routename.OrderHistory).name,path: nUri(Routename.OrderHistory).path, builder: (context, state) =>OrderhistoryScreen(state.queryParams),),
      GoRoute(name: nUri(Routename.Refer).name,path: nUri(Routename.Refer).path, builder: (context, state) =>ReferEarn(),),
      GoRoute(name: nUri(Routename.Refund).name,path: "${nUri(Routename.Refund).path}/:orderid/:total", builder: (context, state) =>Refund_screen(state.params),),
      GoRoute(name: nUri(Routename.Rateorder).name,path: "${nUri(Routename.Rateorder).path}/:orderid", builder: (context, state) =>RateOrderScreen(state.params),),
      GoRoute(name: nUri(Routename.Return).name,path: "${nUri(Routename.Return).path}/:orderid/:title", builder: (context, state) =>ReturnScreen(state.params),),
      GoRoute(name: nUri(Routename.SingleProduct).name ,path: nUri(Routename.SingleProduct).path+"/:varid", builder: (context, state)  =>  SingleproductScreen(state.params["varid"]!),),
      GoRoute(name: nUri(Routename.SellingItem).name,path:"${nUri(Routename.SellingItem).path}/:seeallpress", builder: (context, state) =>SellingitemScreen(state.params),),
      GoRoute(name: nUri(Routename.Help).name,path:nUri(Routename.Help).path, builder: (context, state) =>HelpScreen(),),
      GoRoute(name: nUri(Routename.AddressBook).name,path:nUri(Routename.AddressBook).path, builder: (context, state) =>AddressbookScreen(),),
      GoRoute(name: nUri(Routename.MultipleImagePicker).name,path:nUri(Routename.MultipleImagePicker).path, builder: (context, state) =>MultipleImagePicker(),),
      GoRoute(name: nUri(Routename.Policy).name,path:"${nUri(Routename.Policy).path}/:title", builder: (context, state) =>PolicyScreen(state.params),),
      GoRoute(name: nUri(Routename.EditScreen).name,path: nUri(Routename.EditScreen).path,builder: (context, state) => EditScreen()),
      GoRoute(name: nUri(Routename.ConfirmOrder).name,path: "${nUri(Routename.ConfirmOrder).path}/:prev",builder: (context, state)=> ConfirmorderScreen(state.params)),
      GoRoute(name: nUri(Routename.PickupScreen).name,path: nUri(Routename.PickupScreen).path,builder: (context, state)=>PickupScreen()),
      GoRoute(name: nUri(Routename.MySubscription).name,path: nUri(Routename.MySubscription).path,builder: (context, state)=>MySubscriptionScreen()),
      GoRoute(name: nUri(Routename.CustomerSupport).name,path: nUri(Routename.CustomerSupport).path,builder: (context, state)=> CustomerSupportScreen(state.params)),
      GoRoute(name: nUri(Routename.AddressScreen).name,path: nUri(Routename.AddressScreen).path, builder: (context, state) =>AddressScreen(state.queryParams),),
      GoRoute(name: nUri(Routename.PaymentScreen).name,path: nUri(Routename.PaymentScreen).path, builder: (context, state) =>PaymentScreen(state.queryParams),),
      GoRoute(name: nUri(Routename.OrderConfirmation).name,path: "${nUri(Routename.OrderConfirmation).path}/:orderstatus/:orderid",builder: (context, state) =>OrderconfirmationScreen(state.params)),
      GoRoute(name: nUri(Routename.SubscribeScreen).name,path: nUri(Routename.SubscribeScreen).path,builder: (context, state)=>SubscribeScreen(state.queryParams)),
      GoRoute(name: nUri(Routename.PaymenSubscription).name,path: nUri(Routename.PaymenSubscription).path,builder: (context,state)=>PaymenSubscriptionScreen(state.queryParams)),
      GoRoute(name: nUri(Routename.SubscriptionConfirm).name,path: "${nUri(Routename.SubscriptionConfirm).path}/:orderstatus/:sorderId",builder: (context, state) =>SubscriptionConfirmScreen(state.params)),
      GoRoute(name: nUri(Routename.ViewSubscriptionDetails).name,path: nUri(Routename.ViewSubscriptionDetails).path,builder: (context,state)=>ViewSubscriptionDetails(state.queryParams)),
      GoRoute(name: nUri(Routename.OfferScreen).name,path:nUri(Routename.OfferScreen).path,builder: (context, state)=>OfferScreen(state.queryParams)),
      GoRoute(name: nUri(Routename.BrandsScreen).name,path: nUri(Routename.BrandsScreen).path, builder: (context, state) =>BrandsScreen(state.queryParams),),
      GoRoute(name: nUri(Routename.BannerProduct).name,path: nUri(Routename.BannerProduct).path, builder: (context, state) =>BannerProductScreen(state.queryParams),),
      GoRoute(name: nUri(Routename.NotSubcategory).name,path: nUri(Routename.NotSubcategory).path, builder: (context, state) =>NotSubcategoryScreen(state.queryParams),),
      GoRoute(name: nUri(Routename.notifyProduct).name,path: nUri(Routename.notifyProduct).path, builder: (context, state) =>NotProductScreen(state.queryParams),),
      GoRoute(name: nUri(Routename.notifybrand).name,path: nUri(Routename.notifybrand).path, builder: (context, state) =>NotBrandScreen(state.queryParams),),
      GoRoute(name: nUri(Routename.notify).name,path: nUri(Routename.notify).path, builder: (context, state) =>NotificationScreen(),),
      GoRoute(name: nUri(Routename.search).name,path: nUri(Routename.search).path, builder: (context, state) =>SearchitemScreen(state.queryParams),),
      GoRoute(name: nUri(Routename.Pages).name,path: "${nUri(Routename.Pages).path}/:id",builder: (context, state)=> PagesScreen(state.params)),
      GoRoute(name: nUri(Routename.SubcategoryScreen).name,path: "${nUri(Routename.SubcategoryScreen).path}/:catId/:catTitle",builder: (context, state)=>SubcategoryScreen(state.params))
    */
      ])
    ]),

  ];
}
class CUri{
  String uri;
  CUri(this.uri);
  String get name =>uri;
  String get path => "$uri";
}
abstract class Navigations {

  CUri  Function(Routename name) get nUri=>(Routename name){
    switch(name){
      case Routename.Home:return  CUri("home");
      case Routename.Login:return CUri("admin");
    // case Routename.updateOrder:return CUri("order/update");
      case Routename.CheckoutMobile:
      // TODO: Handle this case.
        return  CUri("checkout");
      case Routename.EditVendorProduct:
      // TODO: Handle this case.
        return  CUri("EditVendorProduct");
      case Routename.VendorProductVariation:
      // TODO: Handle this case.
        return  CUri("EditVendorProductVariation");
      case Routename.SearchOrderScreen:
      // TODO: Handle this case.
        return  CUri("SearchOrderScreen");
    }
  };


  Navigation(BuildContext context,{Routename? name,required NavigatoreTyp navigatore,Map<String, String>? parms, Map<String, dynamic>? qparms}){
    // parms!=null?parms.addAll({"branch":"${PrefUtils.prefs!.getString("branch")}"}):parms = {"branch":"${PrefUtils.prefs!.getString("branch")}"};
    switch(navigatore){
      case NavigatoreTyp.push:
        if(parms!=null && qparms!=null){
          Map<String,String> qparms1={};
          qparms.forEach((key, value) {
            if(value !=null){
              qparms1.addAll({key:value.toString()});
            }
          });
          context.pushNamed(nUri(name!).name,params: parms,queryParams: qparms1);
        }else if(parms!=null){
          context.pushNamed(nUri(name!).name,params: parms);
        }else if(qparms!=null){
          Map<String,String> qparms1={};
          qparms.forEach((key, value) {
            if(value !=null){
              qparms1.addAll({key:value.toString()});
            }
          });
          context.pushNamed(nUri(name!).name/*,params: {"branch":"999"},*/,queryParams: qparms1);
        }else{
          context.pushNamed(nUri(name!).name/*,params: {"branch":"999"}*/);
        }
        /* parms!=null?
        context.goNamed(nUri(name!).name,params: parms):
        context.goNamed(nUri(name!).name);*/
        // context.goNamed(nUri(name).name,queryParams: parms!);
        // context.vxNav.push(Uri(path:  nUri(name!), queryParameters:parms));
        // TODO: Handle this case.
        break;
      case NavigatoreTyp.pop:
        if(GoRouter.of(context).navigator!.canPop()) {
          GoRouter.of(context).pop();
        } else {
          context.go(/*"/${PrefUtils.prefs!.getString("branch")}*/ "/admin/"+nUri(Routename.Home).path);
        }
        // context.vxNav.pop();
        // TODO: Handle this case.
        break;
      case NavigatoreTyp.pushReplacment:
      // GoRouter.of(context).pop();
        parms!=null?
        context.goNamed(nUri(name!).name,params: parms):
        context.goNamed(nUri(name!).name/*,params: {"branch":"999"}*/);
        // TODO: Handle this case.
        break;
      case NavigatoreTyp.popUntill:
        parms!=null?
        context.goNamed(nUri(name!).name,params: parms):
        context.goNamed(nUri(name!).name/*,params: {"branch":"999"}*/);
        // context.vxNav.clearAndPush(Uri(path:nUri(name!)));
        // TODO: Handle this case.
        break;
      case NavigatoreTyp.homenav:
        WidgetsBinding.instance?.addPostFrameCallback((_) { context.go("/admin/"+nUri(Routename.Home).path); });
        //GoRouter.of(context).pop();
        // GoRouter.of(context).refresh();
        GoRouter.of(context).notifyListeners();
        // context.vxNav.popToRoot();
        //});
        // TODO: Handle this case.
        break;
    }
  }
}