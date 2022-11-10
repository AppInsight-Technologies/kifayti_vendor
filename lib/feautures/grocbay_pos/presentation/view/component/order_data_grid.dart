import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import 'package:recase/recase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../../core/util/presentation/controller/scroll_controller.dart';
import '../../../../../core/util/presentation/styles/screen_size_rario.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/themedata/dash_page_info.dart';
import '../../bloc/delivery_list/delivery_list_bloc.dart';
import '../../bloc/picker_list/picker_list_bloc.dart';
import '../../bloc/shop/my_shop_bloc.dart';
import '../../bloc/update_order/update_order_bloc.dart';
import '../../bloc/update_order_status/update_order_status_bloc.dart';
import '../../rought_genrator.dart';
import '../widgte/gridview/custome_gridview.dart';

class OrderDataGrid extends StatefulWidget {
  final List<OrderData> orderData ;
  final double height;
  final ScrollController? controller;
  // final Function(int)? onTapOrderData;
  const OrderDataGrid({Key? key,required this.orderData,required this.height, this.controller,}) : super(key: key);

  @override
  State<OrderDataGrid> createState() => _OrderDataGridState();
}

class _OrderDataGridState extends State<OrderDataGrid> with Navigations {

  @override
  void initState() {
    // TODO: implement initState
    // BlocProvider.of<UpdateOrderBloc>(context).add(OnUpdateOrderEvent(widget.value['oid']));
    // BlocProvider.of<PickerListBloc>(context).add(OnPickerListEvent(sl<SharedPreferences>().getString(Prefrence.BRANCH)??''));
    // BlocProvider.of<DeliveryListBloc>(context).add(OnDeliveryListEvent(sl<SharedPreferences>().getString(Prefrence.BRANCH)??''));

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print("controller...."+widget.controller.toString());
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: (){
        sl<SharedPreferences>().setString("title", "ORDERS");
        Navigator.pop(context);
        return Future.value(false);
      },
      child: CustomeGridView(context,itemcount: size.width>880? 2:1, height: widget.height,
        grid_items:
      List.generate(widget.orderData.length, (index) {
        final status = widget.orderData[index].o_status;
        return GestureDetector(
          onTap: ()
          {
            sl<SharedPreferences>().setString("title", "viewOrder");
              Navigation(context,
                  navigatore: NavigatoreTyp.push,
                  name: Routename.Home,
                  parms: {
                    'index':
                        (DashBoardPageInfo({'oid': widget.orderData[index].o_id})
                                .pagedatabvendore[6]
                                .pageKey)
                            .toLowerCase()
                  },
                  qparms: {
                    'oid': widget.orderData[index].o_id
                  });
            },
            child:LayoutView(context).isMobile?
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10),
              child: Card(
                elevation: 1,
                child:
              Padding(padding: const EdgeInsets.all(4.0), child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center,children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(S.of(context).ORDERS+" #${widget.orderData[index].o_id}",style: const TextStyle(fontFamily: 'Segoe',fontSize: 14,fontWeight: FontWeight.w600)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(widget.orderData[index].o_date,style: const TextStyle(fontFamily: 'Segoe',fontSize: 12)),
                          ),
                        ],),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Padding(padding: const EdgeInsets.all(8.0), child: SizedBox(
                            child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: SizedBox(width: 12,child: Image.asset('assets/icons/icon_user.png')),
                                  ),
                                  Expanded(child: Text(widget.orderData[index].c_name,maxLines:2,overflow: TextOverflow.ellipsis,style: const TextStyle(fontSize: 14,fontFamily: 'Segoe',fontWeight: FontWeight.w600,overflow: TextOverflow.fade,))),
                                ],
                              ),
                          ),),
                           Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: SizedBox(width: 12,child: Image.asset('assets/icons/card.png')),
                                ),
                                Expanded(child: Text(IConstants.currencyFormat+widget.orderData[index].o_pay.toStringAsFixed(2)+" ("+widget.orderData[index].o_pay_mode+")",maxLines:2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12,))),
                              ],
                            ),
                          ),
                        ],),
                      ),
                    ),
                  ],
                ),
                BlocBuilder<MyShopBloc, MyShopState>(
                    builder: (context, state) {
                      if(state is MyShopSucsess) {

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(children: [ Icon(Icons.circle, size: 12, color:
                            (widget.orderData[index].o_status == "completed")
                                ? Color(0xff37BD6A)
                                : (widget.orderData[index].o_status == "received")
                                ? Color(0xffF3853B)
                                :
                            (widget.orderData[index].o_status == "pick") ? Color(
                                0xff006395) : (widget.orderData[index].o_status ==
                                "ready") ? Color(0xff37BD6A) :
                            (widget.orderData[index].o_status == "dispatched")
                                ? Color(0xffF3853B)
                                : (widget.orderData[index].o_status == "delivered")
                                ? Color(0xffFFD600)
                                :
                            (widget.orderData[index].o_status == "cancelled")
                                ? Color(0xffFF3434)
                                : Colors.red
                            ), Padding(
                              padding: const EdgeInsets.all(8.0),

                              child: Text(
                                (widget.orderData[index].o_status == "received")
                                    ? ReCase(S
                                    .of(context)
                                    .Received).titleCase
                                    : ReCase(widget.orderData[index].o_status)
                                    .titleCase, style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold,
                                  color: (widget.orderData[index].o_status ==
                                      "completed") ? Color(0xff37BD6A) : (widget
                                      .orderData[index].o_status == "received")
                                      ? Color(0xffF3853B)
                                      :
                                  (widget.orderData[index].o_status == "pick")
                                      ? Color(0xff006395)
                                      : (widget.orderData[index].o_status ==
                                      "ready") ? Color(0xff37BD6A) :
                                  (widget.orderData[index].o_status == "dispatched")
                                      ? Color(0xffF3853B)
                                      : (widget.orderData[index].o_status ==
                                      "delivered") ? Color(0xffFFD600) :
                                  (widget.orderData[index].o_status == "cancelled")
                                      ? Color(0xffFF3434)
                                      : Colors.red),),
                            )
                            ],),
                            (widget.orderData[index].o_status == "completed" ||widget.orderData[index].o_status == "onway" ||
                                widget.orderData[index].o_status == "cancelled" || widget.orderData[index].o_status == "reached"||
                                widget.orderData[index].o_status == "failed" ||((widget.orderData[index].o_status == "ready")
                                && (state.shopdata.deliveryLocationType == "0")) || widget.orderData[index].o_status == "pick")
                                ||(widget.orderData[index].o_status == "dispatched" /*&& (state.shopdata.deliveryLocationType == "0")*/
                            ) || (widget.orderData[index].o_status == "delivered" /*&& (state.shopdata.deliveryLocationType == "0")*/) ?
                            SizedBox.shrink()
                                : Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4,),
                              child: MaterialButton(
                                height: 30,
                                minWidth: 90,
                                color: (widget.orderData[index].o_status ==
                                    "completed") ? Color(0xff37BD6A) : (widget
                                    .orderData[index].o_status == "received")
                                    ? Color(0xffFF3434)
                                    :
                                (widget.orderData[index].o_status == "pick")
                                    ? Color(0xff006395)
                                    : (widget.orderData[index].o_status == "ready")
                                    ? Color(0xff0890E7)
                                    :
                                (widget.orderData[index].o_status == "dispatched")
                                    ? Color(0xffF3853B)
                                    : (widget.orderData[index].o_status ==
                                    "delivered") ? Color(0xffFFD600) :
                                (widget.orderData[index].o_status == "cancelled")
                                    ? Color(0xffFF3434)
                                    : Colors.red,
                                onPressed: () {
                                  sl<SharedPreferences>().setString("title", "viewOrder");
                                  Navigation(
                                      context, navigatore: NavigatoreTyp.push,
                                      name: Routename.Home,
                                      parms: {
                                        'index': (DashBoardPageInfo({
                                          'oid': widget.orderData[index].o_id
                                        }).pagedatabvendore[6].pageKey)
                                            .toLowerCase()
                                      },
                                      qparms: {
                                        'oid': widget.orderData[index].o_id
                                      });
                                },
                                child: Text(
                                    (widget.orderData[index].o_status == "received")
                                        ? "Mark as Preparing"
                                        : (widget.orderData[index].o_status ==
                                        "ready")
                                        ? "Assign to Deliver"
                                        : (widget.orderData[index].o_status ==
                                        "dispatched")
                                        ? "Mark as Delivered"
                                        : (widget.orderData[index].o_status ==
                                        "delivered") ? "Mark as Completed" : "",
                                    style: const TextStyle(color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold)),),
                            )
                          ],
                        );
                      }else{
                        return SizedBox.shrink();
                      }
                  }
                )
                      ],),
              ),
              ),
            ):
            Card(child: Padding(padding: const EdgeInsets.all(4.0), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center,children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Order #${widget.orderData[index].o_id}",style: const TextStyle(fontFamily: 'Segoe',fontSize: 14,fontWeight: FontWeight.w600)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(widget.orderData[index].o_date,style: const TextStyle(fontFamily: 'Segoe',fontSize: 12)),
                            ),
                          ],),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(padding: const EdgeInsets.all(8.0), child: SizedBox(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: SizedBox(width: 12,child: Image.asset('assets/icons/icon_user.png')),
                                    ),
                                    Expanded(child: Text(widget.orderData[index].c_name,maxLines:2,overflow: TextOverflow.ellipsis,style: const TextStyle(fontSize: 14,fontFamily: 'Segoe',fontWeight: FontWeight.w600,overflow: TextOverflow.fade,))),
                                  ],
                                ),
                              ),),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: SizedBox(width: 12,child: Image.asset('assets/icons/card.png')),
                                    ),
                                    Expanded(child: Text(IConstants.currencyFormat+widget.orderData[index].o_pay.toStringAsFixed(2)+" ("+widget.orderData[index].o_pay_mode+")",maxLines:2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12,))),
                                  ],
                                ),
                              ),
                            ],),
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<MyShopBloc, MyShopState>(
                    builder: (context, state) {
                      if(state is MyShopSucsess) {

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(children: [ Icon(Icons.circle, size: 12, color:
                            (widget.orderData[index].o_status == "completed")
                                ? Color(0xff37BD6A)
                                : (widget.orderData[index].o_status == "received")
                                ? Color(0xffF3853B)
                                :
                            (widget.orderData[index].o_status == "pick") ? Color(
                                0xff006395) : (widget.orderData[index].o_status ==
                                "ready") ? Color(0xff37BD6A) :
                            (widget.orderData[index].o_status == "dispatched")
                                ? Color(0xffF3853B)
                                : (widget.orderData[index].o_status == "delivered")
                                ? Color(0xffFFD600)
                                :
                            (widget.orderData[index].o_status == "cancelled")
                                ? Color(0xffFF3434)
                                : Colors.red
                            ), Padding(
                              padding: const EdgeInsets.all(8.0),

                              child: Text(
                                (widget.orderData[index].o_status == "received")
                                    ? ReCase(S
                                    .of(context)
                                    .Received).titleCase
                                    : ReCase(widget.orderData[index].o_status)
                                    .titleCase, style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold,
                                  color: (widget.orderData[index].o_status ==
                                      "completed") ? Color(0xff37BD6A) : (widget
                                      .orderData[index].o_status == "received")
                                      ? Color(0xffF3853B)
                                      :
                                  (widget.orderData[index].o_status == "pick")
                                      ? Color(0xff006395)
                                      : (widget.orderData[index].o_status ==
                                      "ready") ? Color(0xff37BD6A) :
                                  (widget.orderData[index].o_status == "dispatched")
                                      ? Color(0xffF3853B)
                                      : (widget.orderData[index].o_status ==
                                      "delivered") ? Color(0xffFFD600) :
                                  (widget.orderData[index].o_status == "cancelled")
                                      ? Color(0xffFF3434)
                                      : Colors.red),),
                            )
                            ],),
                            (widget.orderData[index].o_status == "completed" ||
                                widget.orderData[index].o_status == "cancelled" ||
                                widget.orderData[index].o_status == "failed" ||((widget.orderData[index].o_status == "ready")
                                && (state.shopdata.deliveryLocationType == "0")) || widget.orderData[index].o_status == "pick")
                                ||(widget.orderData[index].o_status == "dispatched" /*&& (state.shopdata.deliveryLocationType == "0")*/
                            ) || (widget.orderData[index].o_status == "delivered" /*&& (state.shopdata.deliveryLocationType == "0")*/) ?
                            SizedBox.shrink()
                                : Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4,),
                              child: MaterialButton(
                                height: 30,
                                minWidth: 90,
                                color: (widget.orderData[index].o_status ==
                                    "completed") ? Color(0xff37BD6A) : (widget
                                    .orderData[index].o_status == "received")
                                    ? Color(0xffFF3434)
                                    :
                                (widget.orderData[index].o_status == "pick")
                                    ? Color(0xff006395)
                                    : (widget.orderData[index].o_status == "ready")
                                    ? Color(0xff0890E7)
                                    :
                                (widget.orderData[index].o_status == "dispatched")
                                    ? Color(0xffF3853B)
                                    : (widget.orderData[index].o_status ==
                                    "delivered") ? Color(0xffFFD600) :
                                (widget.orderData[index].o_status == "cancelled")
                                    ? Color(0xffFF3434)
                                    : Colors.red,
                                onPressed: () {
                                  sl<SharedPreferences>().setString("title", "viewOrder");
                                  Navigation(
                                      context, navigatore: NavigatoreTyp.push,
                                      name: Routename.Home,
                                      parms: {
                                        'index': (DashBoardPageInfo({
                                          'oid': widget.orderData[index].o_id
                                        }).pagedatabvendore[6].pageKey)
                                            .toLowerCase()
                                      },
                                      qparms: {
                                        'oid': widget.orderData[index].o_id
                                      });
                                },
                                child: Text(
                                    (widget.orderData[index].o_status == "received")
                                        ? "Mark as Preparing"
                                        : (widget.orderData[index].o_status ==
                                        "ready")
                                        ? "Assign to Deliver"
                                        : (widget.orderData[index].o_status ==
                                        "dispatched")
                                        ? "Mark as Delivered"
                                        : (widget.orderData[index].o_status ==
                                        "delivered") ? "Mark as Completed" : "",
                                    style: const TextStyle(color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold)),),
                            )
                          ],
                        );
                      }else{
                        return SizedBox.shrink();
                      }
                    }
                )
              ],),),),

        );
          }
          ), scolldirection: Axis.vertical,
      ),
    );
  }


}

class OrderData{
  int o_id;
  String o_date;
  String c_name;
  double o_pay;
  String o_pay_mode;
  String o_status = "";
  Function(Map<String,dynamic>)? onTapOrderData;
  OrderData({required this.o_id, required this.o_date, required this.c_name,required this.o_pay_mode, required this.o_pay,required this.o_status,this.onTapOrderData}){
   // switch(o_status) {
   //   case 0: this.o_status = _OrderStatus.pending; break;
   //   case 1: this.o_status = _OrderStatus.completed; break;
   //   case -1: this.o_status = _OrderStatus.cancel; break;
   // }
  }
}
enum _OrderStatus{
  completed,cancel,pending
}
