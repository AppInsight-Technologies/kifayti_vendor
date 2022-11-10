import 'package:flutter/material.dart';
// import '../..//feautures/grocbay_pos/presentation/view/screen/vendor/dashboard_menu.dart';
// import '../..//generated/l10n.dart';

import '../../../../../generated/l10n.dart';
import '../../../presentation/view/screen/create_order_screen.dart';
import '../../../presentation/view/screen/home.dart';
import '../../../presentation/view/screen/order_screen.dart';
import '../../../presentation/view/screen/vendor/dashboard_menu.dart';
import '../../../presentation/view/screen/vendor/update_order.dart';
import '../../../presentation/view/screen/vendor/update_order_pos.dart';

class DashBoardPageInfo{
   // Function(int)? ontapNavigat;
   Map<String, dynamic>? value ;
  DashBoardPageInfo([this.value]);
  List<DashBoardPageModle>get  pagedatabpos => [
    DashBoardPageModle(title: S.current.DASHBOARD, icon: Image.asset("assets/icons/home.png",width: 20,height: 20,),vstatus: true,widget: const Home(),pageKey: S.current.DASHBOARD.toLowerCase()),
    DashBoardPageModle(title: S.current.ORDERS,icon: Image.asset("assets/icons/order.png",width: 20,height: 20,),vstatus: true,widget:  Orders(value!),pageKey: S.current.ORDERS.toLowerCase()),
    DashBoardPageModle(title: S.current.MENU,icon: Image.asset("assets/icons/menu.png",width: 20,height: 20,),vstatus: true,widget: const DashboardMenu(),pageKey:  S.current.MENU.toLowerCase()),
    DashBoardPageModle(title: S.current.INSIGHTS,icon: Image.asset("assets/icons/insights.png",width: 20,height: 20,),vstatus: false,widget:  Orders(value!),pageKey: S.current.INSIGHTS.toLowerCase()),
    DashBoardPageModle(title: S.current.SETTINGS,icon: Image.asset("assets/icons/setting.png",width: 20,height: 20,),vstatus: false,widget:  Orders(value!),pageKey: S.current.SETTINGS.toLowerCase()),
    DashBoardPageModle(title: "",vstatus: false,widget:  CreateOrderScreen(),pageKey: "create"),
    DashBoardPageModle(title: "",vstatus: false,widget:  UpdateOrderScreen(value!),pageKey: "updateOrder"),
    DashBoardPageModle(title: "",vstatus: false,widget:  UpdateOrderPosScreen(value!),pageKey: "updateOrderPos"),
  ];
  List<DashBoardPageModle>get  pagedatabvendore => [
  //  DashBoardPageModle(title: S.current.DASHBOARD, icon: Image.asset("assets/icons/home.png",width: 20,height: 20,),vstatus: false,widget: const Home(),pageKey: S.current.DASHBOARD.toLowerCase()),
     DashBoardPageModle(title: S.current.DASHBOARD,icon: Image.asset("assets/icons/home.png",width: 20,height: 20,),vstatus: true,widget: const Home(),pageKey: S.current.DASHBOARD.toLowerCase()),
    // DashBoardPageModle(title: "Orders",icon: Icons.card_travel,vstatus: false,widget:  Orders(odTap: ontap,)),
    DashBoardPageModle(title: S.current.ORDERS,icon: Image.asset("assets/icons/order.png",width: 20,height: 20,),vstatus: true,widget:  Orders(value!),pageKey: S.current.ORDERS.toLowerCase()),
    DashBoardPageModle(title: S.current.INSIGHTS,icon: Image.asset("assets/icons/insights.png",width: 20,height: 20,),vstatus: false,widget:  UpdateOrderScreen(value!),pageKey: S.current.INSIGHTS.toLowerCase()),
    DashBoardPageModle(title: S.current.MENU,icon: Image.asset("assets/icons/menu.png",width: 20,height: 20,),vstatus: true,widget: const DashboardMenu(),pageKey: S.current.MENU.toLowerCase()),
    DashBoardPageModle(title: S.current.SETTINGS,icon: Image.asset("assets/icons/setting.png",width: 20,height: 20,),vstatus: false,widget:  Orders(value!),pageKey: S.current.SETTINGS.toLowerCase()),
    DashBoardPageModle(title: "",vstatus: false,widget:  CreateOrderScreen(),pageKey: "create"),
    DashBoardPageModle(title: "",vstatus: true,widget:  UpdateOrderScreen(value!),pageKey: "updateOrder"),
    DashBoardPageModle(title: "",vstatus: true,widget:  UpdateOrderPosScreen(value!),pageKey: "updateOrderPos"),

  ];
}
class DashBoardPageModle {
  late bool vstatus;
  String? title;
  Object? icon;
  Widget? widget;
 late String pageKey;

  DashBoardPageModle({required this.vstatus, this.title, this.icon, this.widget,required this.pageKey});

  DashBoardPageModle.fromJson(Map<String, dynamic> json) {
    vstatus = json['status'];
    title = json['title'];
    icon = json['icon'];
    widget = json['widget'];
    pageKey = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.vstatus;
    data['title'] = this.title;
    data['icon'] = this.icon;
    data['widget'] = this.widget;
    data['key'] = this.pageKey;
    return data;
  }
}
