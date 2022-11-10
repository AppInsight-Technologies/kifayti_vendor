import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_usb_printer/flutter_usb_printer.dart';
// import '../..//feautures/grocbay_pos/domain/entities/cart_item_modle.dart';
// import '../..//core/util/calculations/cartcalculations.dart';
// import '../..//feautures/grocbay_pos/presentation/bloc/customers/userprofile_bloc.dart';
// import '../..//feautures/grocbay_pos/presentation/view/widgte/create_profilepopup.dart';
// import '../..//feautures/grocbay_pos/presentation/view/widgte/custom_stepper.dart';
// import '../..//feautures/grocbay_pos/presentation/view/widgte/dailog/alert%20_dailog.dart';
// import '../..//feautures/grocbay_pos/presentation/view/component/checkoutpopup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../../core/util/presentation/controller/global_focus.dart';
import '../../../../../core/util/presentation/controller/onpress_controller.dart';
import '../../../../../core/util/presentation/styles/screen_size_rario.dart';
import '../../../../../core/util/print/prin_usb.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/fetch_category_product.dart';
import '../../../domain/entities/get_profile_modle.dart';
import '../../../domain/entities/pos_ordersearch_model.dart';
import '../../../domain/entities/search_user_modle.dart';
import '../../../domain/entities/themedata/dash_page_info.dart';
import '../../../domain/entities/update_order_model.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../../bloc/homepage/category/category_bloc.dart';
import '../../bloc/order/order_managment_bloc.dart';
import '../../bloc/search/search_bloc.dart';
import '../../bloc/update_order/update_order_bloc.dart';
import '../../rought_genrator.dart';
import '../widgte/customer/customer_profile_button.dart';
import '../widgte/search_bar.dart';
import 'checkout_orderlist2.dart';

class RecentOrder extends StatefulWidget {

  @override
  _RecentOrderState createState() => _RecentOrderState();
}

class _RecentOrderState extends State<RecentOrder> with Navigations {
  final usbprinter = UsbPrinter(FlutterUsbPrinter());
  int i = 0;
  String orderid ="";

  @override
  void initState(){
    BlocProvider.of<OrderManagmentBloc>(context).add(const FetchOrder(query: '',start: 0));

    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(preferredSize: const Size.fromHeight(100),
          child: StatefulBuilder(
              builder: (context,setState) {
              return Container(
                padding: EdgeInsets.all(10),
                height: 50,
                color: Colors.black,
                child: Row(
                  children: [
                    Text("Recent Order", style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white
                    ),),
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          debugPrint("lkjhgfg...");
                          sl<SharedPreferences>().setBool("opendrawer", false);
                          debugPrint("lkjhgfg...1"+sl<SharedPreferences>().getBool("opendrawer").toString());

                        });
                      }, child: Icon(Icons.clear, color: Colors.white, size: 20,)),
                    SizedBox(width: 10,)
                  ],
                ),
              );
            }
          ),),
        body: BlocBuilder<OrderManagmentBloc, OrderManagmentState>(
            builder: (context, state) {

              if(state is OrderManagmentStateLoading){
                return Center(child: CircularProgressIndicator());
              }
              if(state is OrderManagmentStateSucsess<List<PosOrderSearch>>){

            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(color: Colors.black12,thickness: 2,),
                  shrinkWrap: true,
                  itemCount: state.data.length,
                  itemBuilder: (BuildContext context, int i) {
                    orderid = state.data[i].oId.toString();
                  //  BlocProvider.of<UpdateOrderBloc>(context).add(OnUpdateOrderEvent(state.data[i].oId!));
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                             Row(

                               children: [
                                 Container(
                                   width: 150,
                                   child: Text("Created on",style: TextStyle(
                                     fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black
                                   ),),
                                 ),
                                 SizedBox(width: 30,),
                                 Text(":"),
                                 SizedBox(width: 10,),
                                 Text(state.data[i].oDate!,style: TextStyle(
                                     fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black
                                 ),),
                               ],
                             ),
                          Row(
                            children: [
                              Container(
                                width: 150,
                                child: Text("Customer Details",style: TextStyle(
                                    fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black
                                ),),
                              ),
                              SizedBox(width: 30,),
                              Text(":"),
                              SizedBox(width: 10,),
                              Text(state.data[i].uName!,style: TextStyle(
                                  fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black
                              ),),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 150,
                                child: Text("Amount",style: TextStyle(
                                    fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black
                                ),),
                              ),
                              SizedBox(width: 30,),
                              Text(":"),
                              SizedBox(width: 10,),
                              Text(IConstants.currencyFormat+ state.data[i].payAmount.toString(),style: TextStyle(
                                  fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black
                              ),),
                            ],
                          ),

                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  sl<SharedPreferences>().setString("title","ORDERS");
                                  Navigation(context, navigatore: NavigatoreTyp.push,name: Routename.Home,parms: {'index':(DashBoardPageInfo({
                                    'oid':state.data[i].oId
                                  }).pagedatabvendore[7].pageKey).toLowerCase()},qparms: {
                                    'oid':state.data[i].oId
                                  });
                                },
                                child: Container(
                                  width: 180,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.green
                                    ),
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/icons/view.png",height: 15,width: 15,),
                                      SizedBox(width: 5,),
                                      Text("View Details",style: TextStyle(
                                          fontSize: 14,fontWeight: FontWeight.bold,color: Colors.green
                                      ),),

                                    ],
                                  ),
                                ),
                              ),
                              BlocBuilder<UpdateOrderBloc, UpdateOrderState>(
                                  builder: (context, state1) {
                                    if(state1 is UpdateOrderSucsess<List<UpdateOrderModel>>) {
                                      return GestureDetector(
                                        onTap: (){

                                          debugPrint("hihi..."+state1.data.length.toString()+"....."+state1.data[i].orderAmount!);
                                          usbprinter.printPosOrder(state1.data[i]);
                                        },
                                        child: Center(
                                          child: Container(
                                            width: 180,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.green
                                                ),
                                                borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Icon(Icons.print,color: Colors.green,),
                                                SizedBox(width: 5,),
                                                Text("Print invoice",style: TextStyle(
                                                    fontSize: 14,fontWeight: FontWeight.bold,color: Colors.green
                                                ),),

                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }else{
                                      return Container();
                                    }}
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
            );
              }else{
                return Container(
                    color: Colors.white,
                    child: Center(child: Image.asset("assets/icons/noorder.png",width: 200,height: 200,))
                );
              }

          }
        )
      //Text("abc"),
    );
  }
}
