import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../../core/util/presentation/controller/global_focus.dart';
import '../../../../../core/util/presentation/controller/onpress_controller.dart';
import '../../../../../core/util/presentation/styles/screen_size_rario.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/fetch_category_product.dart';
import '../../../domain/entities/getAllCountModel.dart';
import '../../../domain/entities/themedata/dash_page_info.dart';
import '../../bloc/getAllCount/get_All_Count_bloc.dart';
import '../../bloc/order/order_managment_bloc.dart';
import '../../bloc/search/search_bloc.dart';
import '../../rought_genrator.dart';
import '../component/variation_drawer.dart';
import '../component/vendore_dashboard_analitics/delevery_analitics.dart';
import '../component/vendore_dashboard_analitics/order_analitics.dart';
import '../widgte/calender_view_button.dart';
import '../widgte/charts/linearcharts.dart';
import '../widgte/custom_card_view.dart';
import '../widgte/custome_tab_view.dart';
import '../widgte/sales_data.dart';
import '../widgte/search_bar.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with Navigations{
  PageController tabcontroller = PageController(initialPage: 0);
  bool search_status = false;

@override
  void initState() {
    // TODO: implement initState
  // SearchRepo().orderSearch().then((value) => print("stored:${value.first.oId}"));
  BlocProvider.of<GetAllCountBloc>(context).add(OnGetAllCountEvent(sl<SharedPreferences>().getString(Prefrence.BRANCH)??''));

  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        SystemNavigator.pop();
        return Future.value(true);
      },
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0,bottom: 12,top: 12,right: 12),
          child: ListView(
            scrollDirection: Axis.vertical,
            children:  [
              (LayoutView(context).isWeb || LayoutView(context).isTab)? SizedBox.shrink():
              // PreferredSize(preferredSize: const Size.fromHeight(100),child:SearchBar<PosOrderSearch>((query,context){
              //   BlocProvider.of<SearchBloc>(context).add(OnSearch(query, SearchType.order));
              // },/*empty: const Text("No Matches found....",style: TextStyle(
              //     color: Colors.black
              // )),*/
              //     focus: FocusN.f_order_search,
              //     onSubmit: (e){
              //       print("search submit...");
              //
              //     },
              //     listdata: (e,index,active) {
              //       return Padding(
              //         padding: const EdgeInsets.only(bottom: 8.0,right: 10),
              //         child: GestureDetector(
              //           behavior: HitTestBehavior.translucent,
              //           onTap: (){
              //             sl<SharedPreferences>().setString("title", "viewOrder");
              //             Navigation(context,
              //                 navigatore: NavigatoreTyp.push,
              //                 name: Routename.Home,
              //                 parms: {
              //                   'index':
              //                   (DashBoardPageInfo({'oid': e.oId})
              //                       .pagedatabvendore[6]
              //                       .pageKey)
              //                       .toLowerCase()
              //                 },
              //                 qparms: {
              //                   'oid':  e.oId
              //                 });
              //           },
              //           child: Container(
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular((5.0)),
              //               border: Border.all(color:Theme.of(context).primaryColor,),
              //             ),
              //             child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               crossAxisAlignment: CrossAxisAlignment.center,
              //               children: [
              //                 Row(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   mainAxisAlignment: MainAxisAlignment.start,
              //                   children: [
              //                     Container(
              //                       width: MediaQuery.of(context).size.width * 0.25,
              //                       child: Padding(
              //                         padding: const EdgeInsets.all(4.0),
              //                         child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center,children: [
              //                           Padding(
              //                             padding: const EdgeInsets.all(8.0),
              //                             child: Text("Order #${e.oId}",style: const TextStyle(fontFamily: 'Segoe',fontSize: 14,fontWeight: FontWeight.w600)),
              //                           ),
              //                           Padding(
              //                             padding: const EdgeInsets.all(8.0),
              //                             child: Text("${e.oDate}",style: const TextStyle(fontFamily: 'Segoe',fontSize: 12)),
              //                           ),
              //                         ],),
              //                       ),
              //                     ),
              //                     Container(
              //                       width: MediaQuery.of(context).size.width * 0.3,
              //                       child: Padding(
              //                         padding: const EdgeInsets.all(4.0),
              //                         child: Column(
              //                           crossAxisAlignment: CrossAxisAlignment.start,
              //                           mainAxisAlignment: MainAxisAlignment.center,
              //                           children: [
              //                             Padding(padding: const EdgeInsets.all(8.0), child: SizedBox(
              //                               child: Row(
              //                                 children: [
              //                                   Padding(
              //                                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //                                     child: SizedBox(width: 12,child: Image.asset('assets/icons/icon_user.png')),
              //                                   ),
              //                                   Expanded(child: Text("${e.uName}",maxLines:2,overflow: TextOverflow.ellipsis,style: const TextStyle(fontSize: 14,fontFamily: 'Segoe',fontWeight: FontWeight.w600,overflow: TextOverflow.fade,))),
              //                                 ],
              //                               ),
              //                             ),),
              //                             Padding(
              //                               padding: const EdgeInsets.all(8.0),
              //                               child: Row(
              //                                 children: [
              //                                   Padding(
              //                                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //                                     child: SizedBox(width: 12,child: Image.asset('assets/icons/card.png')),
              //                                   ),
              //                                   Expanded(child: Text(IConstants.currencyFormat+"${e.payAmount}",maxLines:2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12,))),
              //                                 ],
              //                               ),
              //                             ),
              //
              //                           ],),
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //             Padding(
              //               padding: const EdgeInsets.only(right: 40.0),
              //               child: Center(
              //                 child: Text("${e.oStatus}",maxLines:2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12,)),),
              //             ),
              //
              //               ],),
              //           ),
              //         ),
              //       );
              //     },
              //     searchstatus:(iseSearching){
              //       debugPrint("iseSearching..."+iseSearching.toString());
              //       if (sl<SharedPreferences>().getBool(Prefrence.showSearchbar)??false ) {
              //         if(!search_status){
              //           // BlocProvider.of<CategoryBloc>(context).add(const CategoryEventInitial());
              //         }
              //         search_status = iseSearching;
              //       }else{
              //
              //       }
              //     },
              //     listnsearch: (users){
              //       debugPrint("iseSearching1..."+users.toString());
              //       // BlocProvider.of<ProductBloc>(context).add(OnProductGet(users as List<FetchCategoryProduct>));
              //
              //     },
              //     hintText: S.current.search_by_order,//"Search For Products",
              //     type:SearchType.product,
              //
              //     style: SearchBarStyle(iconalign: IconAlign.leading,contentPadding:
              //     const EdgeInsets.symmetric(horizontal: 15,vertical: 11),
              //         decoration: BoxDecoration(
              //       color:Color(0xffF5F5F5),
              //       borderRadius: BorderRadius.circular(8),
              //     )),
              //   errorText: "No Order details found",
              // ),
              // ),


              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Navigation(context, navigatore: NavigatoreTyp.push,name: Routename.SearchOrderScreen);
                },
                child: Container(
                 // width: MediaQuery.of(context).size.width ,
                  height: 50,
                  padding: EdgeInsets.only(right: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color:Color(0xffF5F5F5),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 15,),
                      Icon(Icons.search,size: 22,
                          color:(LayoutView(context).isWeb || LayoutView(context).isTab)?Color(0xff32B847):Colors.black),
                      SizedBox(width: 15,),
                      Text(
                        // S.current.search_by_order,
                        S.of(context).search_by_order,
                        style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,
                            color: (LayoutView(context).isWeb || LayoutView(context).isTab)?Color(0xff32B847):Colors.black),
                      ),

                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child:
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Column(
              //         children:const [
              //           Text("DashBoard",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
              //         ],
              //       ),
              //       const CalenderViewButton(),
              //     ],
              //   ),
              // ),
              // salees_data_new(),
              const OrderAnalitics(),
              // Column(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(top: 20),
              //       child: CustomeTabView(tabcontroller,mainAxisAlignment: MainAxisAlignment.start,style: TabStyle(bgcolor: Colors.white),tabs: [
              //         TabData(ic_name: S.of(context).yesterday,icon_id: "0"),
              //         TabData(ic_name: S.of(context).today,icon_id: "1"),
              //         TabData(ic_name: S.of(context).week,icon_id: "2"),
              //         TabData(ic_name: S.of(context).month,icon_id: "3"),
              //         TabData(ic_name: S.of(context).year,icon_id: "4"),
              //       ],onTap: (index){
              //         final type;
              //         switch(index){
              //           case 0:type = S.of(context).delivered; break;
              //           case 1:type = S.of(context).delivered; break;
              //           case 2:type = S.of(context).delivered; break;
              //           case 3:type = S.of(context).delivered; break;
              //           case 4:type = S.of(context).failed; break;
              //           case 5:type = S.of(context).delivered; break;
              //           case 6:type = S.of(context).failed; break;
              //         }
              //         // BlocProvider.of<OrderManagmentBloc>(context).add(const FetchOrder(query: '',start: 0));
              //
              //       }),
              //     ),
              //     // SizedBox(
              //     //   height: (LayoutView(context).isWeb || LayoutView(context).isTab)?MediaQuery.of(context).size.height/2:MediaQuery.of(context).size.height/3,
              //     //   child: Row(children:[
              //     //     const CCardView(child: LineChartView(),),
              //     //     CCardView(child:
              //     //     Stack(
              //     //       children: [
              //     //         PieChart(PieChartData(
              //     //             centerSpaceRadius: (LayoutView(context).isWeb || LayoutView(context).isTab)?80:45,
              //     //             centerSpaceColor: Colors.white,
              //     //             sectionsSpace: 5,
              //     //             borderData: FlBorderData(show: false),
              //     //             sections: [
              //     //               PieChartSectionData(value: 60, color: Colors.green,radius: (LayoutView(context).isWeb || LayoutView(context).isTab)?30:20,),
              //     //               PieChartSectionData(value: 30, color: Colors.blue,radius: (LayoutView(context).isWeb || LayoutView(context).isTab)?30:20,),
              //     //               PieChartSectionData(value: 10, color: Colors.red,radius: (LayoutView(context).isWeb || LayoutView(context).isTab)?30:20,),
              //     //             ]
              //     //         )
              //     //         ),
              //     //         Padding(
              //     //           padding:  EdgeInsets.only(left: 20.0,top: 15),
              //     //           child: Text("Total Income",style: TextStyle(
              //     //               color: Colors.black,fontSize:  (LayoutView(context).isWeb || LayoutView(context).isTab)?20:16,fontWeight: FontWeight.bold
              //     //           ),),
              //     //         ),
              //     //       ],
              //     //     ),),
              //     //     (LayoutView(context).isWeb || LayoutView(context).isTab)?
              //     //     Expanded(flex: 1,child: Column(
              //     //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     //     children: [
              //     //       CCardView(child: Container(
              //     //        child: Column(
              //     //           children: [
              //     //             SizedBox(height: 10,),
              //     //             Row(
              //     //               children: [
              //     //                 SizedBox(width: 10,),
              //     //                 Container(
              //     //                   decoration: BoxDecoration(
              //     //                     color: Colors.red,
              //     //                     borderRadius: BorderRadius.all(
              //     //                         Radius.circular(5.0),
              //     //                     )
              //     //                   ),
              //     //                     height: 40,
              //     //                     width: 40,
              //     //                     child: Image.asset('assets/icons/total.png')),
              //     //                 SizedBox(width: 10,),
              //     //                 Column(
              //     //                   mainAxisAlignment: MainAxisAlignment.start,
              //     //                   crossAxisAlignment: CrossAxisAlignment.start,
              //     //                   children: [
              //     //                     Text("Total Orders",style: TextStyle(
              //     //                       color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold
              //     //                     ),),
              //     //                     SizedBox(height: 3,),
              //     //                    /* Text("-2.86%",style: TextStyle(
              //     //                         color: Colors.red,fontSize: 12
              //     //                     ),),*/
              //     //                   ],
              //     //                 )
              //     //               ],
              //     //             ),
              //     //             SizedBox(height: 40,),
              //     //             BlocBuilder<GetAllCountBloc, GetAllCountState>(
              //     //               builder: (context, state) {
              //     //
              //     //                 if(state is GetAllCountSucsess<List<PosGetAllCount>>) {
              //     //                   return Center(
              //     //                     child: Text(state.data.first.allorderscount.toString(),style: TextStyle(
              //     //                         color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold
              //     //                     ),),
              //     //                   );
              //     //                 }
              //     //
              //     //                 else{
              //     //                   return SizedBox.shrink();
              //     //                 }
              //     //               },
              //     //             )
              //     //
              //     //           ],
              //     //         )
              //     //       ),),
              //     //       CCardView(child: Container(
              //     //           child: Column(
              //     //             children: [
              //     //               SizedBox(height: 10,),
              //     //               Row(
              //     //                 children: [
              //     //                   SizedBox(width: 10,),
              //     //                   Container(
              //     //                       decoration: BoxDecoration(
              //     //                           color:  Color(0xff142134),
              //     //                           borderRadius: BorderRadius.all(
              //     //                             Radius.circular(5.0),
              //     //                           )
              //     //                       ),
              //     //                       height: 40,
              //     //                       width: 40,
              //     //                       child: Image.asset('assets/icons/customer.png')),
              //     //                   SizedBox(width: 10,),
              //     //                   Column(
              //     //                     mainAxisAlignment: MainAxisAlignment.start,
              //     //                     crossAxisAlignment: CrossAxisAlignment.start,
              //     //                     children: [
              //     //                       Text("New Customer",style: TextStyle(
              //     //                           color: Color(0xff142134),fontSize: 20,fontWeight: FontWeight.bold
              //     //                       ),),
              //     //                       SizedBox(height: 3,),
              //     //                       /*Text("+32.86%",style: TextStyle(
              //     //                           color: Colors.red,fontSize: 12
              //     //                       ),),*/
              //     //                     ],
              //     //                   )
              //     //                 ],
              //     //               ),
              //     //               SizedBox(height: 40,),
              //     //               BlocBuilder<GetAllCountBloc, GetAllCountState>(
              //     //                 builder: (context, state) {
              //     //                   if(state is GetAllCountSucsess<List<PosGetAllCount>>) {
              //     //                     return Center(
              //     //                       child: Text(state.data.first.customerscount.toString(),style: TextStyle(
              //     //                           color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold
              //     //                       ),),
              //     //                     );
              //     //                   }
              //     //
              //     //                   else{
              //     //                     return SizedBox.shrink();
              //     //                   }
              //     //                 },
              //     //               )
              //     //             ],
              //     //           )
              //     //       ),),
              //     //     ],
              //     //   )):SizedBox.shrink(),]),
              //     // ),
              //     (LayoutView(context).isWeb || LayoutView(context).isTab)?SizedBox.shrink():
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         CCardView(child: Container(
              //           height:130,
              //             child: Column(
              //               children: [
              //                 SizedBox(height: 10,),
              //                 Row(
              //                   children: [
              //                     SizedBox(width: 7,),
              //                     Container(
              //                         decoration: BoxDecoration(
              //                             color: Colors.red,
              //                             borderRadius: BorderRadius.all(
              //                               Radius.circular(5.0),
              //                             )
              //                         ),
              //                         height: 38,
              //                         width: 38,
              //                         child: Image.asset('assets/icons/total.png')),
              //                     SizedBox(width: 5,),
              //                     Column(
              //                       mainAxisAlignment: MainAxisAlignment.start,
              //                       crossAxisAlignment: CrossAxisAlignment.start,
              //                       children: [
              //                         Text("Total Orders",style: TextStyle(
              //                             color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold
              //                         ),),
              //                         SizedBox(height: 3,),
              //                         /* Text("-2.86%",style: TextStyle(
              //                             color: Colors.red,fontSize: 12
              //                         ),),*/
              //                       ],
              //                     )
              //                   ],
              //                 ),
              //                 SizedBox(height: 20,),
              //                 BlocBuilder<GetAllCountBloc, GetAllCountState>(
              //                   builder: (context, state) {
              //
              //                     if(state is GetAllCountSucsess<List<PosGetAllCount>>) {
              //                       return Center(
              //                         child: Text(state.data.first.allorderscount.toString(),style: TextStyle(
              //                             color: Colors.black,fontSize: 35,fontWeight: FontWeight.bold
              //                         ),),
              //                       );
              //                     }
              //
              //                     else{
              //                       return SizedBox.shrink();
              //                     }
              //                   },
              //                 ),
              //                 SizedBox(height: 10,),
              //               ],
              //             )
              //         ),),
              //         CCardView(child: Container(
              //             height:130,
              //             child: Column(
              //               children: [
              //                 SizedBox(height: 10,),
              //                 Row(
              //                   children: [
              //                     SizedBox(width: 7,),
              //                     Container(
              //                         decoration: BoxDecoration(
              //                             color:  Color(0xff142134),
              //                             borderRadius: BorderRadius.all(
              //                               Radius.circular(5.0),
              //                             )
              //                         ),
              //                         height: 38,
              //                         width:38,
              //                         child: Image.asset('assets/icons/customer.png')),
              //                     SizedBox(width: 5,),
              //                     Column(
              //                       mainAxisAlignment: MainAxisAlignment.start,
              //                       crossAxisAlignment: CrossAxisAlignment.start,
              //                       children: [
              //                         Text("New Customer",style: TextStyle(
              //                             color: Color(0xff142134),fontSize: 16,fontWeight: FontWeight.bold
              //                         ),),
              //                         SizedBox(height: 3,),
              //                         /*Text("+32.86%",style: TextStyle(
              //                               color: Colors.red,fontSize: 12
              //                           ),),*/
              //                       ],
              //                     )
              //                   ],
              //                 ),
              //                 SizedBox(height: 20,),
              //                 BlocBuilder<GetAllCountBloc, GetAllCountState>(
              //                   builder: (context, state) {
              //                     if(state is GetAllCountSucsess<List<PosGetAllCount>>) {
              //                       return Center(
              //                         child: Text(state.data.first.customerscount.toString(),style: TextStyle(
              //                             color: Colors.black,fontSize: 35,fontWeight: FontWeight.bold
              //                         ),),
              //                       );
              //                     }
              //
              //                     else{
              //                       return SizedBox.shrink();
              //                     }
              //                   },
              //                 ),
              //                 SizedBox(height: 10,),
              //               ],
              //             )
              //         ),),
              //       ],
              //     )
              //   ],
              // ),
              (LayoutView(context).isWeb || LayoutView(context).isTab)?
              const DeleveryAnalitics():
              BlocBuilder<GetAllCountBloc, GetAllCountState>(
                builder: (context, state) {
                 /* if(state is GetAllCountLoading){
                    return Center(child: CircularProgressIndicator());
                  }*/
                  if(state is GetAllCountSucsess<List<PosGetAllCount>>) {
                    return   SizedBox(
                     // width: MediaQuery.of(context).size.width,
                      //height:(LayoutView(context).isWeb || LayoutView(context).isTab)?80:150,
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          Container(
                            // width: 110,
                            // height: 120,
                            width: MediaQuery.of(context).size.width/3.3,
                            height: MediaQuery.of(context).size.height*0.16,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)
                            ),

                            child: Card(elevation: 2,child:  Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(S.of(context).home_delivery,style: TextStyle(fontSize: 12, color: Colors.black,fontWeight: FontWeight.bold)),
                                  SizedBox(height: 10,),
                                  Text((state.data.first.homedeliveriescount! <= 9)? "0" + state.data.first.homedeliveriescount.toString(): state.data.first.homedeliveriescount.toString(),style: TextStyle(color: Colors.orange,fontSize: 45,fontWeight: FontWeight.bold),),
                                 ],
                              ),
                            ),
                           ),
                          ),
                          Container(
                            // width: 110,
                            // height: 120,
                            width: MediaQuery.of(context).size.width/3.3,
                            height: MediaQuery.of(context).size.height*0.16,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)
                            ),

                            child: Card(elevation: 2,child:
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(S.of(context).express_delivery,style: TextStyle(fontSize: 12, color: Colors.black,fontWeight: FontWeight.bold)),
                                   SizedBox(height: 10,),
                                  Text((state.data.first.expressorderscount! <= 9)? "0" + state.data.first.expressorderscount.toString(): state.data.first.expressorderscount.toString(),style: TextStyle(color: Colors.green,fontSize: 45,fontWeight: FontWeight.bold),),
                                   ],
                              ),
                            ),
                            ),
                          ),
                          Container(
                          //  padding: EdgeInsets.all(5),
                          //   width: 120,
                          //   height: 120,
                            width: MediaQuery.of(context).size.width/3.3,
                            height: MediaQuery.of(context).size.height*0.16,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)
                            ),

                            child: Card(elevation: 2,child:
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(S.of(context).pick_up_from_store,style: TextStyle(fontSize: 11.5, color: Colors.black,fontWeight: FontWeight.bold)),
                                  SizedBox(height: 10,),
                                  Text((state.data.first.pickuporderscount! <= 9)? "0" + state.data.first.pickuporderscount.toString(): state.data.first.pickuporderscount.toString(),style: TextStyle(color:  Colors.blueAccent,fontSize: 45,fontWeight: FontWeight.bold),),
                                 ],
                              ),
                            ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  else{
                    return SizedBox.shrink();
                  }
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}