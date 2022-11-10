
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:recase/recase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../../core/util/presentation/controller/scroll_controller.dart';
import '../../../../../core/util/presentation/styles/screen_size_rario.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/getAllCountModel.dart';
import '../../../domain/entities/pos_ordersearch_model.dart';
import '../../bloc/customers/userprofile_bloc.dart';
import '../../bloc/getAllCount/get_All_Count_bloc.dart';
import '../../bloc/order/order_managment_bloc.dart';
import '../component/order_data_grid.dart';
import '../widgte/calender_view_button.dart';
import '../widgte/custome_tab_view.dart';
import '../widgte/filter_view_button.dart';
import '../widgte/search_bar.dart';

class Orders extends StatefulWidget {
  final Function(Map<String,dynamic>)? odTap;
  final Map<String,dynamic>? indexvalue;
  int? index;
   Orders(this.indexvalue,{Key? key,this.odTap}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();

  }

class _OrdersState extends State<Orders> {
  List<PosOrderSearch> _data = [];
  bool endlist = false;
  bool isLoading = false;
  PageController? tabcontroller;// = PageController(initialPage: 0);
  String? type;


  Future<void> Refresh(BuildContext context) async {
    BlocProvider.of<OrderManagmentBloc>(context).add( FetchOrder(query: type!,start: 0));
    BlocProvider.of<GetAllCountBloc>(context).add(OnGetAllCountEvent(sl<SharedPreferences>().getString(Prefrence.BRANCH)??''));

  }
  @override
  void initState() {
    print("index value init...."+_data.toString());

    tabcontroller = PageController(initialPage: int.parse(widget.indexvalue!['index value'].toString()));
     type = widget.indexvalue!['clickvalue'].toString();
    print("index value init...."+_data.length.toString());
    orderscrollcontroller.addListener(() {
      debugPrint("orderscrollcontroller....");
     return pagination(_data, navigatorKey.currentContext);
    });
    // TODO: implement initState
    BlocProvider.of<OrderManagmentBloc>(context).add( FetchOrder(query: type!,start: _data.length));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: PreferredSize(preferredSize: Size.fromHeight(LayoutView(context).isMobile?150:60),
        child: BlocBuilder<GetAllCountBloc, GetAllCountState>(
            builder: (context, state) {
             /* if(state is GetAllCountLoading){
                return Center(child: CircularProgressIndicator());
              }*/
              if(state is GetAllCountSucsess<List<PosGetAllCount>>) {
                return CustomeTabView(

                    tabcontroller!,
                    mainAxisAlignment: MainAxisAlignment.start,
                    style: TabStyle(
                        bgcolor: LayoutView(context).isMobile ? Color(
                            0xffece9f6) : Colors.white),
                    tabs: LayoutView(context).isMobile?
                    [
                    TabData(ic_name: S
                        .of(context)
                        .ALL, icon_id: "0",count: state.data.first.allorderscount!),
                    TabData(ic_name: S
                        .of(context)
                        .new_delivery, icon_id: "1",count: state.data.first.pendingorderscount!),
                    TabData(ic_name: S
                        .of(context)
                        .processing_picking, icon_id: "2",count: state.data.first.processingorderscount!),
                    TabData(ic_name: S
                        .of(context)
                        .ready_delivery, icon_id: "3",count: state.data.first.readynorderscount!),
                    TabData(ic_name: S
                        .of(context)
                        .assigned, icon_id: "4",count: state.data.first.dispatchedorderscount!),
                    TabData(ic_name: S
                        .of(context)
                        .out_For_Delivery, icon_id: "5",count: state.data.first.onwayorderscount!),
                    TabData(ic_name:
                    ReCase(S
                        .of(context)
                        .delivered).titleCase, icon_id: "6",count: state.data.first.deliveredorderscount!),
                    // TabData(ic_name: S
                    //     .of(context)
                    //     .Completed, icon_id: "7"),
                    // TabData(ic_name: S
                    //     .of(context)
                    //     .Canceled, icon_id: "8"),
                    // TabData(ic_name: S
                    //     .of(context)
                    //     .failed, icon_id: "9"),
                    ]
                        :
                    [
                    TabData(ic_name: S
                        .of(context)
                    .ALL, icon_id: "0", ),
              TabData(ic_name: S
                  .of(context)
                  .Received, icon_id: "1"),
              TabData(ic_name:"Picker", icon_id: "2"),
              TabData(ic_name: S
                  .of(context)
                  .Ready, icon_id: "3"),
              TabData(ic_name: S
                  .of(context)
                  .Assigned_Delivery, icon_id: "4"),
              TabData(ic_name: S
                  .of(context)
                  .Out_For_Delivery, icon_id: "5"),
              TabData(ic_name: S
                  .of(context)
                  .delivered, icon_id: "6"),
              TabData(ic_name: S
                  .of(context)
                  .Completed, icon_id: "7"),
              TabData(ic_name: S
                  .of(context)
                  .Canceled, icon_id: "8"),
              TabData(ic_name: S
                  .of(context)
                  .failed, icon_id: "9"),
              ],
              onTap: (index)
              {

              if(LayoutView(context).isMobile) {
              //String type = '';
              switch (index) {
              case 0:
              type = "";
              break;
              case 1:
              type = "received";
              break;
              case 2:
              type ="pick";
              break;
              case 3:
              type = "ready";
              break;
              case 4:
              type = "dispatched";
              break;
              case 5:
              type ="onway";
              break;
              case 6:
              type = "delivered";
              break;
              // case 7:
              //   type = S
              //       .of(context)
              //       .COMPLETED
              //       .toLowerCase();
              //   break;
              // case 8:
              //   type = S
              //       .of(context)
              //       .CANCELLED
              //       .toLowerCase();
              //   break;
              // case 9:
              //   type = S
              //       .of(context)
              //       .failed;
              //   break;
              }

              BlocProvider.of<OrderManagmentBloc>(context).add(FetchOrder(query: type!, start: 0));
              }
              else {
              String type = '';
              switch (index) {
              case 0:
              type = "";
              break;
              case 1:
              type = S
                  .of(context)
                  .RECEIVED
                  .toLowerCase();
              break;
              case 2:
              type = S
                  .of(context)
                  .PICK
                  .toLowerCase();
              break;
              case 3:
              type = S
                  .of(context)
                  .READY
                  .toLowerCase();
              break;
              case 4:
              type = S
                  .of(context)
                  .DISPATCHED
                  .toLowerCase();
              break;
              case 5:
              type = S
                  .of(context)
                  .onway;
              break;
              case 6:
              type = S
                  .of(context)
                  .delivered;
              break;
              case 7:
              type = S
                  .of(context)
                  .COMPLETED
                  .toLowerCase();
              break;
              case 8:
              type = S
                  .of(context)
                  .CANCELLED
                  .toLowerCase();
              break;
              case 9:
              type = S
                  .of(context)
                  .failed;
              break;
              }
              BlocProvider.of<OrderManagmentBloc>(context).add(
              FetchOrder(query: type, start: 0));
              }

              }
              );
            }else{
                return SizedBox.shrink();
              }
          }
        )

            ),
        body: RefreshIndicator(
            onRefresh: () => Refresh(context),
              child: Padding(
                padding:  EdgeInsets.only(bottom: LayoutView(context).isMobile?80:0),
                child: BlocBuilder<OrderManagmentBloc, OrderManagmentState>(
      builder: (context, state) {
        print("order data");
        if (state is OrderManagmentStateLoading) {
          print("OrderManagmentStateLoading...");
          if(!state.ispaginated) {
            return const Center(child: CircularProgressIndicator());
          }
        }
        if(state is OrderManagmentStateSucsess<List<PosOrderSearch>>) {
          debugPrint("state.ispaginated..."+state.ispaginated.toString());
            if(state.ispaginated){
              debugPrint("state.data.isEmpty..."+state.data.isEmpty.toString());
              if(state.data.isEmpty){
                endlist = true;
              }
              _data.addAll(state.data);
            }else{
              _data = state.data;
            }

          print("order search"+_data.length.toString());
          if(_data.length > 0) {
                return OrderDataGrid(orderData: _data.map((e) =>
                    OrderData(onTapOrderData: widget.odTap,
                        c_name: e.uName!,
                        o_date: e.oDate!,
                        o_id: int.parse(e.oId!),
                        o_pay: (e.payAmount!).toDouble(),
                        o_pay_mode: e.payMode.toString(),
                        o_status: e.oStatus!)).toList(),
                      height: MediaQuery.of(context).size.width > 880 ? 16 : 17,
                  controller: orderscrollcontroller,
                );
          }else{
                return Container(

                  color: Colors.white,
                    child: Center(child: Image.asset("assets/icons/noorder.png",width: 200,height: 200,))
                );
          }
        }
        else if(state is OrderManagmentStateLoading){
          return const Center(child: CircularProgressIndicator());
        }
        else{
          return SizedBox.shrink();
        }
      },
    ),
              ),
            ));
  }

  void pagination(List<PosOrderSearch> data,context) {
    debugPrint("_data.length..."+ _data.length.toString());
    if ((orderscrollcontroller.position.pixels == orderscrollcontroller.position.maxScrollExtent) && (!endlist)) {
      BlocProvider.of<OrderManagmentBloc>(context).add(OrderPagination( type!,start: _data.length));
    }
  }

}


