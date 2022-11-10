

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:recase/recase.dart';

import '../../../../../core/util/presentation/styles/screen_size_rario.dart';
import '../../../../../generated/l10n.dart';
import '../../../domain/entities/themedata/dash_page_info.dart';
import '../../bloc/order/order_managment_bloc.dart';
import '../../rought_genrator.dart';
class SalesData extends StatefulWidget {
  final Color ic_color;
  final bool leading_box_enable;
 final String? text;
 final int? count;

  const SalesData({
    required this.ic_color,
    this.leading_box_enable = false,
    this.text,
    this.count,
    Key? key,
  }) : super(key: key);

  @override
  State<SalesData> createState() => _SalesDataState();
}

class _SalesDataState extends State<SalesData>  with Navigations{
  PageController tabcontroller = PageController(initialPage: 0);
  Map<String, String>? qparams = {};
  @override
  Widget build(BuildContext context) {
debugPrint("text...."+widget.text!);
    return   (LayoutView(context).isWeb || LayoutView(context).isTab)? SizedBox(
      width: 280,
      child: ListTile(subtitle: null,title:  Text(widget.text!,style: TextStyle(fontSize: 16.sp, color: Colors.black,fontWeight: FontWeight.bold)),leading:  Container(
        decoration: BoxDecoration(
            color: widget.leading_box_enable?widget.ic_color:null,
          borderRadius: BorderRadius.circular(5)
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 10.0,bottom: 10.0,left: 8,right: 8),
          child: Text((widget.count! <= 9)? "0" + widget.count.toString(): widget.count.toString(),style: TextStyle(color: widget.leading_box_enable?Colors.white:widget.ic_color,fontSize: 16.sp,fontWeight: FontWeight.bold),),
        ),
      ),onTap: ()=> {
      tabcontroller.jumpToPage((widget.text! == "Completed Order")?7:(widget.text! == "Pending Order")?1:(widget.text! == "Delivered Order")?6:
      (widget.text! == "Cancelled Order")?8:0),
      BlocProvider.of<OrderManagmentBloc>(context).add(
      FetchOrder(query: (widget.text! == "Completed Order")?"completed":(widget.text! == "Pending Order")?"received":(widget.text! == "Delivered Order")?"Delivered":
      (widget.text! == "Cancelled Order")?"cancelled":"", start: 0))
      },),
    ):
    GridTile(child:  Padding(
      padding: const EdgeInsets.only(right: 8.0,bottom: 5,top: 8),
      child: InkWell(
       // behavior: HitTestBehavior.translucent,
        onTap: () =>{
          //print("widget clicked......."+widget.text.toString()),

          // BlocProvider.of<OrderManagmentBloc>(context).add(
          // FetchOrder(query: (widget.text! == "Completed Order")?"completed":(widget.text! == "Pending Order")?"received":(widget.text! == "Delivered Order")?"Delivered":
          // (widget.text! == "Cancelled Order")?"cancelled":"", start: 0)),
          if(widget.text == S.of(context).Completed_Order ){
            Navigation(context, navigatore: NavigatoreTyp.push,
                name: Routename.Home,
                parms: {
                  'index': (DashBoardPageInfo(qparams).pagedatabpos[1].pageKey)
                      .toLowerCase(),
                },
            qparms: {
              "index value":"6",
              "clickvalue": "delivered",
            }),

            tabcontroller.jumpToPage((widget.text! == S.of(context).Completed_Order)?5:0/*:(widget.text! == "Pending Order")?1:(widget.text! == "Delivered Order")?6:
            (widget.text! == "Cancelled Order")?8:0*/),
          }
          else if(widget.text == S.of(context).Active_Orders){
            Navigation(context, navigatore: NavigatoreTyp.push,
                name: Routename.Home,
                parms: {
                  'index': (DashBoardPageInfo(qparams).pagedatabpos[1].pageKey)
                      .toLowerCase(),
                },
                qparms: {
                  "index value":"0",
                  "clickvalue":  "",
                }),

            tabcontroller.jumpToPage((widget.text! == S.of(context).Active_Orders)?0:0/*:(widget.text! == "Pending Order")?1:(widget.text! == "Delivered Order")?6:
            (widget.text! == "Cancelled Order")?8:0*/),
          }
          else if(widget.text == S.of(context).Return_Ready){
              Navigation(context, navigatore: NavigatoreTyp.push,
                  name: Routename.Home,
                  parms: {
                    'index': (DashBoardPageInfo(qparams).pagedatabpos[1].pageKey)
                        .toLowerCase(),
                  },
                  qparms: {
                    "index value":"3",
                    "clickvalue":  "ready"
                        ,
                  }),

              tabcontroller.jumpToPage((widget.text! == S.of(context).Return_Ready)?3:0/*:(widget.text! == "Pending Order")?1:(widget.text! == "Delivered Order")?6:
            (widget.text! == "Cancelled Order")?8:0*/),
            }
            else if(widget.text == S.of(context).Out_For_Delivery){
                Navigation(context, navigatore: NavigatoreTyp.push,
                    name: Routename.Home,
                    parms: {
                      'index': (DashBoardPageInfo(qparams).pagedatabpos[1].pageKey)
                          .toLowerCase(),
                    },
                    qparms: {
                      "index value":"5",
                      "clickvalue":  "onway",
                    }),

                tabcontroller.jumpToPage((widget.text! == S.of(context).Out_For_Delivery)?5:0/*:(widget.text! == "Pending Order")?1:(widget.text! == "Delivered Order")?6:
            (widget.text! == "Cancelled Order")?8:0*/),
              }
        },
        child: Container(
          padding: EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width/3.5,
          height: MediaQuery.of(context).size.height*0.14,
          decoration: BoxDecoration(
              //color: widget.leading_box_enable?widget.ic_color:null,
            border: Border.all(color:widget.ic_color ),
              borderRadius: BorderRadius.circular(8)
          ),
          child: Column(
             mainAxisAlignment: MainAxisAlignment.start,


            children: [
              Text((widget.count! <= 9)? "0" + widget.count.toString(): widget.count.toString(),style: TextStyle(color:  widget.leading_box_enable?widget.ic_color:null,fontSize: 30.sp,fontWeight: FontWeight.bold),),

              Text(widget.text!,style: TextStyle(fontSize: 12.sp, color:  widget.leading_box_enable?widget.ic_color:null,fontWeight: FontWeight.bold)),

            ],
          ),
        ),
      ),
    ),

    )
    ;
  }
}