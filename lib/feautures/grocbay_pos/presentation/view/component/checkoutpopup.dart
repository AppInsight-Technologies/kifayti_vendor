import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_usb_printer/flutter_usb_printer.dart';
import 'package:go_router/go_router.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/util/calculations/cartcalculations.dart';
import '../../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../../core/util/presentation/controller/onpress_controller.dart';
import '../../../../../core/util/presentation/styles/box_property.dart';
import '../../../../../core/util/presentation/styles/screen_size_rario.dart';
import '../../../../../core/util/print/prin_usb.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/cart_item_modle.dart';
import '../../../domain/entities/get_profile_modle.dart';
import '../../../domain/usecases/check_out_usecase.dart';
import '../../bloc/Loyalty/loyalty_bloc.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../../bloc/checkout/check_out_bloc.dart';
import '../../bloc/customers/userprofile_bloc.dart';
import '../widgte/checkbox_tab.dart';
import '../widgte/dailog/alert _dailog.dart';
import '../widgte/navigatore_tab.dart';


class CHeckOutPopup extends StatefulWidget {
  // final CheckoutValueController _checkoutvalcontroller = CheckoutValueController(CheckoutModel());
  List<CartItemModel> list_cart_items = [];
  // List<CartItemModel> list_cart_item = [];
  GetCustomerProfile user;
  // final String user_data;

  CHeckOutPopup(this.list_cart_items, this.user, {Key? key,}) : super(key: key);


  @override
  _CHeckOutPopupState createState() => _CHeckOutPopupState();
}

class _CHeckOutPopupState extends State<CHeckOutPopup> {
  bool dailog = false;
  PageController orderTypeController = PageController(initialPage: 0);
  CartCalculationsState cal = CartCalculationsState();
  bool iswalletenable = false;
  bool isloyalityenable = false;
  String promocode ="";
  String promoAmount ="";
  CheckoutModel checkoutModel = CheckoutModel();
  final usbprinter = UsbPrinter(FlutterUsbPrinter());
  int paymodeindex = 0;
  bool _switchValue=true;

  Map<String, dynamic>? dropdownvalue;

  String waletamt = '0';
  @override
  void initState(){

    debugPrint("amt init"+cal.calculateTotalAmount(widget.list_cart_items,widget.user.data?.first.membership=="1"));

    checkoutModel.apiKey = widget.user.data!.first.apiKey;
    checkoutModel.paymentType = 'cash';
    checkoutCalculate();
    // Future.delayed(const Duration(seconds: 1),() async{
    //   GetLoyaltyDatabase _getloyalty = GetLoyaltyDatabase(context,sl<SharedPreferences>().getString(Prefrence.BRANCH));
    //   CheckLoyaltyDatabase _checkloyalty = CheckLoyaltyDatabase(context, "500", sl<SharedPreferences>().getString(Prefrence.BRANCH));
    //   _getloyalty(sucsess:(getLoyalty data){
    //   },failes:(messege){
    //     //Navigation(context, navigatore: NavigatoreTyp.pushReplacment,name: Routename.Login);
    //   });
    //
    //   _checkloyalty(sucsess:(checkLoyalty data){
    //
    //   },failes:(messege){
    //     //Navigation(context, navigatore: NavigatoreTyp.pushReplacment,name: Routename.Login);
    //   });
    // });
  }


  @override
  Widget build(BuildContext contextx) {
    orderTypeController.addListener(() {
      debugPrint("xxv");
      checkoutModel.paymentType = orderTypeController.page==0?"cash": orderTypeController.page==1?"sod":"online";
    });
    return KeyboardListener(
      onKeyEvent: (event){
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
            if(paymodeindex<3) {
              orderTypeController.jumpToPage(paymodeindex++);
            }
            // setState(()=>index++);
          } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            if(paymodeindex>0) {
              orderTypeController.jumpToPage(paymodeindex--);
            }
          }
          else if (event.logicalKey == LogicalKeyboardKey.enter) {

          }
          else if (event.logicalKey == LogicalKeyboardKey.space) {
            BlocProvider.of<CheckOutBloc>(context).add(OnCheckOut(widget.list_cart_items,checkoutModel));
          }
          else{
            debugPrint(event.logicalKey.toString());
          }
        } else {
          return;
        }
      },
      autofocus: true,
      focusNode: FocusNode(),
      child: Padding(
        padding: (LayoutView(context).isWeb || LayoutView(context).isTab) ? const EdgeInsets.only(left:50.0,right: 50,top:50.0,bottom: 10.0) : const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
            // width:MediaQuery.of(context).size.width/0.5,
            //  height:MediaQuery.of(context).size.height/0.5,
            child:/*  (LayoutView(context).isWeb || LayoutView(context).isTab) ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex:1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BlocBuilder<UserProfileBloc, UserProfileState>(
                        builder: (context, state) {
                          if(state is UserProfileLoading){
                            return const SizedBox(height: 60,child: CircularProgressIndicator(),);
                          }
                          if(state is UserProfileSucsess<GetCustomerProfile>) {
                            checkoutValueController.value.value.is_membered_user = state.data.data!.first.membership;
                            return CheckboxTab(checkoutValueController,pageViewController,style: BoxStyle(width: MediaQuery.of(context).size.width),align:Axis.vertical,tabs: [
                              WalletTabData(enable: true,active: checkoutModel.walletType,ic_name: "Wallet",icon:Image.asset("assets/icons/credit-card.png"),w_type: "wallet",balance: (state.data.prepaid!.first.prepaid as num).toDouble(),description: "Wallet Balance ₹ ${(state.data.prepaid!.first.prepaid as num).toDouble()}", onchanged: (bool , walletamount ) {
                                checkoutModel.walletType = bool;
                                checkoutModel.walletBalance = walletamount.toString();
                                checkoutCalculate();
                              }),
                              WalletTabData(enable: true,active: checkoutModel.loyalty,ic_name: "Loyalty",icon:Image.asset("assets/icons/loyalty.png",color:(state.data.prepaid!.first.loyalty as num).toDouble()<0?Colors.grey.shade700:null ),w_type: "loyalty",balance: (state.data.prepaid!.first.loyalty as num).toDouble(), onchanged: (bool , loyalityamount ) {
                                checkoutModel.loyalty = bool;
                                checkoutModel.loyaltyPoints = loyalityamount.toString();
                                checkoutCalculate();                            }),
                              // WalletTabData(enable: true,active: checkoutModel.promocode !="",ic_name: "Apply Promo Code",icon:Image.asset("assets/icons/promo.png"),w_type: "promo", onchanged: (bool , wallwtamount ) {
                              //   // widget.list_cart_items.forEach((e) {
                              //   //   l.add(json.encode({"itemid":e.varId.toString(),"qty":e.quantity.toString(),"price":e.price}));
                              //   // });
                              //   BlocProvider.of<PromoCodeBloc>(context).add( FetchPromoCode(GetPromoParams(user: checkoutModel.apiKey!, price: cal.calculateTotalAmount(widget.list_cart_items),  items: widget.list_cart_items.map((e) => {"itemid":e.varId.toString(),"qty":e.quantity.toString(),"price":e.price}).toList().toString(),)));
                              //   // checkoutModel.is_promo=!checkoutModel.is_promo;
                              //   showDialog(
                              //     context: context,
                              //     builder: (BuildContext context) {
                              //       return  Dialog(child: Promo_Popup(onTap: (promo) {
                              //         checkoutModel.promocode =promo;
                              //         checkoutModel.promo =promo;
                              //         checkoutCalculate();
                              //       },));
                              //     },
                              //   );
                              // })
                            ]);
                          }
                          return const SizedBox.shrink();
                        },
                      ),

                      ApplyPromocodeText(promocode,onCodeSumit: (text){
                        checkoutModel.promocode =text;
                        checkoutModel.promo =text;
                        checkoutCalculate();
                      }, onCancelPromocode: () {
                        checkoutModel.promocode ="";
                        checkoutModel.promo ="";
                        checkoutCalculate();
                      },),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Payment Method",style: TextStyle(color: Colors.black,fontSize:12,fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      NavigatorTab(pageViewController,style:BoxStyle(
                          borderenabel:true,
                          width: MediaQuery.of(context).size.width,
                          height: 70),align:Axis.horizontal,islist: true,tabs: [
                        TabData(active: true,ic_name: "Cash",icon:  Image.asset("assets/icons/money.png",height: 20,width: 25)),
                        TabData(active: true,ic_name: "Card",icon:  Image.asset("assets/icons/credit-card.png",height: 20,width: 25)),
                        TabData(active: true,ic_name: "UPI",icon:  Image.asset("assets/icons/UPI.png",height: 20,width: 25)),
                      ])
                    ],
                  ),
                ),
                Expanded(
                  flex:1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BlocConsumer<LoyaltyBloc, LoyaltyState>(
                            listener: (context, state) {
                              // TODO: implement listener
                              if(state is LoyaltySucsess<String>){
                                if(state.promomsg!=""||state.promomsg!=null){
                                  print(state.promomsg);
                                  setState(() {
                                    promocode  =state.promomsg;
                                  });
                                }else{
                                  setState(() {
                                    promocode  ="";
                                  });
                                }
                              }
                            },
                            builder: (context, state) {
                              String totalamount ="";
                              String loyaltyPoints ="";
                              if(state is LoyaltySucsess<String>){
                                print("state.data"+state.data.toString());
                                totalamount = (double.parse(state.data)).toString();
                                checkoutModel.loyalty = double.parse(state.loyality)>0;
                                loyaltyPoints = state.loyality;
                                // checkoutModel.walletBalance = state.walletused;
                                print("wltused${ state.walletused}");
                                //checkoutModel.total = totalamount;
                              }
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: widget.list_cart_items.isNotEmpty ? Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          // mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children:[
                                              const Text("Your Cart Value",style: TextStyle(color: Colors.grey,fontSize:10,fontWeight: FontWeight.bold)),
                                              Text("₹${cal.calculateTotalMRP(widget.list_cart_items) }",style: const TextStyle(color: Colors.grey,fontSize:10,fontWeight: FontWeight.bold)),
                                            ]),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.all(8.0),
                                      //   child: Row(
                                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //       children:[
                                      //         const Text("Delivary Charges",style: TextStyle(color: Colors.grey,fontSize:10,fontWeight: FontWeight.bold)),
                                      //         Text("₹${cal.calculateDeliveryCharge(widget.list_cart_item)??0 }",style: const TextStyle(color: Colors.grey,fontSize:10,fontWeight: FontWeight.bold)),
                                      //       ]),
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          // mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children:[
                                              const Text("You saved (Loyalty Coins)",style: TextStyle(color: Colors.grey,fontSize:10,fontWeight: FontWeight.bold)),
                                              Text("${checkoutModel.loyalty?loyaltyPoints:0 }",style: const TextStyle(color: Colors.grey,fontSize:10,fontWeight: FontWeight.bold)),
                                            ]),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          // mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children:[
                                              const Text("Your Wallet Amount",style: TextStyle(color: Colors.grey,fontSize:10,fontWeight: FontWeight.bold)),
                    ApplyPromocodeText(promocode,onCodeSumit: (text){
                      checkoutModel.promocode =text;
                      checkoutModel.promo =text;
                      checkoutCalculate();
                    }, onCancelPromocode: () {
                      checkoutModel.promocode ="";
                      checkoutModel.promo ="";
                      checkoutCalculate();
                    },),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Payment Method",style: TextStyle(color: Colors.black,fontSize:12,fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    NavigatorTab(pageViewController,style:BoxStyle(
                      borderenabel:true,
                        width: MediaQuery.of(context).size.width,
                        height: 70),align:Axis.horizontal,islist: true,tabs: [
                      TabData(active: true,ic_name: "Cash",icon:  Image.asset("assets/icons/money.png",height: 20,width: 25)),
                      TabData(active: true,ic_name: "Card",icon:  Image.asset("assets/icons/credit-card.png",height: 20,width: 25)),
                      TabData(active: true,ic_name: "UPI",icon:  Image.asset("assets/icons/UPI.png",height: 20,width: 25)),
                    ])
                  ],
                ),
              ),
              Expanded(
                flex:1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BlocConsumer<LoyaltyBloc, LoyaltyState>(
                          listener: (context, state) {
                            // TODO: implement listener
                            if(state is LoyaltySucsess<String>){
                              if(state.promomsg!=""||state.promomsg!=null){
                                print(state.promomsg);
                               setState(() {
                                 promocode  =state.promomsg;
                               });
                              }else{
                               setState(() {
                                 promocode  ="";
                               });
                              }
                            }
                          },
                          builder: (context, state) {
                            String totalamount ="";
                            String loyaltyPoints ="";
                            if(state is LoyaltySucsess<String>){
                              print("state.data"+state.data.toString());
                              totalamount = (double.parse(state.data)).toString();
                              checkoutModel.loyalty = double.parse(state.loyality)>0;
                              loyaltyPoints = state.loyality;
                              // checkoutModel.walletBalance = state.walletused;
                              print("wltused${ state.walletused}");
                              //checkoutModel.total = totalamount;
                            }
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: widget.list_cart_items.isNotEmpty ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        // mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children:[
                                            const Text("Your Cart Value",style: TextStyle(color: Colors.grey,fontSize:10,fontWeight: FontWeight.bold)),
                                            Text("₹${cal.calculateTotalMRP(widget.list_cart_items) }",style: const TextStyle(color: Colors.grey,fontSize:10,fontWeight: FontWeight.bold)),
                                          ]),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Row(
                                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //       children:[
                                    //         const Text("Delivary Charges",style: TextStyle(color: Colors.grey,fontSize:10,fontWeight: FontWeight.bold)),
                                    //         Text("₹${cal.calculateDeliveryCharge(widget.list_cart_item)??0 }",style: const TextStyle(color: Colors.grey,fontSize:10,fontWeight: FontWeight.bold)),
                                    //       ]),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        // mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children:[
                                            const Text("You saved (Loyalty Coins)",style: TextStyle(color: Colors.grey,fontSize:10,fontWeight: FontWeight.bold)),
                                            Text("${checkoutModel.loyalty?loyaltyPoints:0 }",style: const TextStyle(color: Colors.grey,fontSize:10,fontWeight: FontWeight.bold)),
                                          ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        // mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children:[
                                            const Text("Your Wallet Amount",style: TextStyle(color: Colors.grey,fontSize:10,fontWeight: FontWeight.bold)),

// if()
                                            Text("₹${state is LoyaltySucsess<String>?state.walletused:0 }",style: const TextStyle(color: Colors.grey,fontSize:10,fontWeight: FontWeight.bold)),
                                          ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        // mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children:[
                                            const  Text("Total Amount Payable",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                                              Text("₹${state is LoyaltySucsess<String>?state.walletused:0 }",style: const TextStyle(color: Colors.grey,fontSize:10,fontWeight: FontWeight.bold)),
                                            ]),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          // mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children:[
                                              const  Text("Total Amount Payable",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),

                                            Text("₹${totalamount}",style: const TextStyle(color: Colors.blue,fontSize:12,fontWeight: FontWeight.bold)),
                                          ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:5.0,left:5.0,right:5.0),
                                      child: Row(
                                        //mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children:[
                                            const Text("Your Savings",style: TextStyle(color: Colors.green,fontWeight: FontWeight.normal),),
                                            Text("₹${ cal.calculateTotalDiscount(widget.list_cart_items) }",style: const TextStyle(color: Colors.grey,fontSize:10,fontWeight: FontWeight.bold)),
                                          ]),
                                    ),
                                  ],
                                ):const SizedBox.shrink(),
                              ),
                            );
                          },
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left:8.0,right:8.0),
                            child: MaterialButton(onPressed: (){
                              BlocProvider.of<CheckOutBloc>(context).add(OnCheckOut(widget.list_cart_items,checkoutModel));
                            },color: Colors.green,
                                child:BlocConsumer<CheckOutBloc,CheckOutState>(
                                  builder: (contexts,state) {
                                    if(state is CheckOutLoading){
                                      return const Center(child: CircularProgressIndicator(),);
                                    }
                                    if(state is CheckOutSucsess){
                                      BlocProvider.of<CartItemBloc>(context).add(const ClearCart());
                                              Text("₹${totalamount}",style: const TextStyle(color: Colors.blue,fontSize:12,fontWeight: FontWeight.bold)),
                                            ]),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          //mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children:[
                                              const Text("Your Savings",style: TextStyle(color: Colors.green,fontWeight: FontWeight.normal),),
                                              Text("₹${ cal.calculateTotalDiscount(widget.list_cart_items) }",style: const TextStyle(color: Colors.grey,fontSize:10,fontWeight: FontWeight.bold)),
                                            ]),
                                      ),
                                    ],
                                  ):const SizedBox.shrink(),
                                ),
                              );
                            },
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top:15.0,left:8.0,right:8.0),
                              child: MaterialButton(onPressed: (){
                                BlocProvider.of<CheckOutBloc>(context).add(OnCheckOut(widget.list_cart_items,checkoutModel));
                              },color: Colors.green,
                                  child:BlocConsumer<CheckOutBloc,CheckOutState>(
                                    builder: (contexts,state) {
                                      if(state is CheckOutLoading){
                                        return const Center(child: CircularProgressIndicator(),);
                                      }
                                      if(state is CheckOutSucsess){
                                        BlocProvider.of<CartItemBloc>(context).add(const ClearCart());

                                      // BlocProvider.of<UserProfileBloc>(context).add( ClearCustomerData("0"));
                                    }
                                    return const Center(
                                        child: Text("COMPLETE",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),));
                                  }, listener: (BuildContext context, state) {
                                  if(state is CheckOutSucsess<OrderItem>){
                                    print("sucsess: ${state.data.id}");
                                    Navigator.pop(context);
                                    // Alert().showSuccess(context,messege: "Order Placed");
                                    if(_switchValue) {
                                      UniversalPrint(widget.user,state.data,widget.list_cart_items).print();
                                    }
                                  }else if(state is CheckOutError){
                                    print(state.e);
                                    Alert().showallert(context,messege: state.e);
                                  }
                                },
                                )
                            )
                        ),
                        Row(
                          children: [
                            const Text("Print",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                            Transform.scale(
                              scale: 0.6,
                              child: CupertinoSwitch(
                                value: _switchValue,
                                onChanged: (bool value) {
                                  setState(() {
                                    _switchValue = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
              : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    flex:1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BlocBuilder<UserProfileBloc, UserProfileState>(
                          builder: (context, state) {
                            if(state is UserProfileLoading){
                              return const SizedBox(height: 60,child: CircularProgressIndicator(),);
                            }
                            if(state is UserProfileSucsess<GetCustomerProfile>) {
                              checkoutValueController.value.value.is_membered_user = state.data.data!.first.membership;
                              return CheckboxTab(checkoutValueController,pageViewController,style: BoxStyle(width: MediaQuery.of(context).size.width),align:Axis.vertical,tabs: [
                                WalletTabData(enable: true,active: checkoutModel.walletType,ic_name: "Wallet",icon:Image.asset("assets/icons/credit-card.png"),w_type: "wallet",balance: (state.data.prepaid!.first.prepaid as num).toDouble(),description: "Wallet Balance ₹ ${(state.data.prepaid!.first.prepaid as num).toDouble()}", onchanged: (bool , walletamount ) {
                                  checkoutModel.walletType = bool;
                                  checkoutModel.walletBalance = walletamount.toString();
                                  checkoutCalculate();
                                }),
                                WalletTabData(enable: true,active: checkoutModel.loyalty,ic_name: "Loyalty",icon:Image.asset("assets/icons/loyalty.png",color:(state.data.prepaid!.first.loyalty as num).toDouble()<0?Colors.grey.shade700:null ),w_type: "loyalty",balance: (state.data.prepaid!.first.loyalty as num).toDouble(), onchanged: (bool , loyalityamount ) {
                                  checkoutModel.loyalty = bool;
                                  checkoutModel.loyaltyPoints = loyalityamount.toString();
                                  checkoutCalculate();                            }),
                                // WalletTabData(enable: true,active: checkoutModel.promocode !="",ic_name: "Apply Promo Code",icon:Image.asset("assets/icons/promo.png"),w_type: "promo", onchanged: (bool , wallwtamount ) {
                                //   // widget.list_cart_items.forEach((e) {
                                //   //   l.add(json.encode({"itemid":e.varId.toString(),"qty":e.quantity.toString(),"price":e.price}));
                                //   // });
                                //   BlocProvider.of<PromoCodeBloc>(context).add( FetchPromoCode(GetPromoParams(user: checkoutModel.apiKey!, price: cal.calculateTotalAmount(widget.list_cart_items),  items: widget.list_cart_items.map((e) => {"itemid":e.varId.toString(),"qty":e.quantity.toString(),"price":e.price}).toList().toString(),)));
                                //   // checkoutModel.is_promo=!checkoutModel.is_promo;
                                //   showDialog(
                                //     context: context,
                                //     builder: (BuildContext context) {
                                //       return  Dialog(child: Promo_Popup(onTap: (promo) {
                                //         checkoutModel.promocode =promo;
                                //         checkoutModel.promo =promo;
                                //         checkoutCalculate();
                                //       },));
                                //     },
                                //   );
                                // })
                              ]);
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                                        // BlocProvider.of<UserProfileBloc>(context).add( ClearCustomerData("0"));
                                      }
                                      return const Center(
                                          child: Text("COMPLETE",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),));
                                    }, listener: (BuildContext context, state) {
                                    if(state is CheckOutSucsess<OrderItem>){
                                      print("sucsess: ${state.data.id}");
                                      Navigator.pop(context);
                                      // Alert().showSuccess(context,messege: "Order Placed");
                                      if(_switchValue) {
                                        usbprinter.print();
                                        // UniversalPrint(widget.user,state.data,widget.list_cart_items).print();
                                      }
                                    }else if(state is CheckOutError){
                                      print(state.e);
                                      Alert().showallert(context,messege: state.e);
                                    }
                                  },
                                  )
                              )
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Text("Print",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                                Transform.scale(
                                  scale: 0.6,
                                  child: CupertinoSwitch(
                                    value: _switchValue,
                                    onChanged: (bool value) {
                                      setState(() {
                                        _switchValue = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )
                :*/ Wrap(
              direction: Axis.horizontal,
              children: [
                SizedBox(
                 height:(LayoutView(context).isWeb || LayoutView(context).isTab) ? MediaQuery.of(context).size.width/3 :MediaQuery.of(context).size.width,
                  width: (LayoutView(context).isWeb || LayoutView(context).isTab) ? MediaQuery.of(context).size.width/3:MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // BlocBuilder<UserProfileBloc, UserProfileState>(
                      //   builder: (context, state) {
                      //     if(state is UserProfileLoading){
                      //       return const SizedBox(height: 60,child: CircularProgressIndicator(),);
                      //     }
                      //     if(state is UserProfileSucsess<GetCustomerProfile>) {
                      //       checkoutValueController.value.value.is_membered_user = state.data.data!.first.membership;
                      //       return CheckboxTab(checkoutValueController,orderTypeController,style: BoxStyle(width: MediaQuery.of(context).size.width),align:Axis.vertical,tabs: [
                      //         WalletTabData(enable: true,active: checkoutModel.walletType,ic_name: "Wallet",icon:Image.asset("assets/icons/credit-card.png"),w_type: "wallet",balance: (state.data.prepaid!.first.prepaid as num).toDouble(),description: "Wallet Balance ₹ ${(state.data.prepaid!.first.prepaid as num).toDouble()}", onchanged: (bool , walletamount ) {
                      //           checkoutModel.walletType = bool;
                      //           checkoutModel.walletBalance = walletamount.toString();
                      //           checkoutCalculate();
                      //         }),
                      //         WalletTabData(enable: true,active: checkoutModel.loyalty,ic_name: "Loyalty",icon:Image.asset("assets/icons/loyalty.png",color:(state.data.prepaid!.first.loyalty as num).toDouble()<0?Colors.grey.shade700:null ),w_type: "loyalty",balance: (state.data.prepaid!.first.loyalty as num).toDouble(), onchanged: (bool , loyalityamount ) {
                      //           checkoutModel.loyalty = bool;
                      //           checkoutModel.loyaltyPoints = loyalityamount.toString();
                      //           checkoutCalculate();                            }),
                      //         // WalletTabData(enable: true,active: checkoutModel.promocode !="",ic_name: "Apply Promo Code",icon:Image.asset("assets/icons/promo.png"),w_type: "promo", onchanged: (bool , wallwtamount ) {
                      //         //   // widget.list_cart_items.forEach((e) {
                      //         //   //   l.add(json.encode({"itemid":e.varId.toString(),"qty":e.quantity.toString(),"price":e.price}));
                      //         //   // });
                      //         //   BlocProvider.of<PromoCodeBloc>(context).add( FetchPromoCode(GetPromoParams(user: checkoutModel.apiKey!, price: cal.calculateTotalAmount(widget.list_cart_items),  items: widget.list_cart_items.map((e) => {"itemid":e.varId.toString(),"qty":e.quantity.toString(),"price":e.price}).toList().toString(),)));
                      //         //   // checkoutModel.is_promo=!checkoutModel.is_promo;
                      //         //   showDialog(
                      //         //     context: context,
                      //         //     builder: (BuildContext context) {
                      //         //       return  Dialog(child: Promo_Popup(onTap: (promo) {
                      //         //         checkoutModel.promocode =promo;
                      //         //         checkoutModel.promo =promo;
                      //         //         checkoutCalculate();
                      //         //       },));
                      //         //     },
                      //         //   );
                      //         // })
                      //       ]);
                      //     }
                      //     return const SizedBox.shrink();
                      //   },
                      // ),
                      //
                      // ApplyPromocodeText(promocode,onCodeSumit: (text){
                      //   checkoutModel.promocode =text;
                      //   checkoutModel.promo =text;
                      //   checkoutCalculate();
                      // }, onCancelPromocode: () {
                      //   checkoutModel.promocode ="";
                      //   checkoutModel.promo ="";
                      //   checkoutCalculate();
                      // },),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text("Payment Method",style: TextStyle(color: Colors.black,fontSize:15,fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      NavigatorTab(PageController(initialPage: -1),
                        style:BoxStyle(
                          borderenabel:true,
                          width: MediaQuery.of(context).size.width,
                          height: 90,
                      ),align:Axis.horizontal,islist: true,tabs: [
                        TabData(active: true,ic_name: "Cash",fontSize:14,icon:  Image.asset("assets/icons/money.png",height: 30,width: 35,),index: ()=>setState(()=>checkoutModel.paymentType = 'cash')),
                        TabData(active: true,ic_name: "Card",fontSize:14,icon:  Image.asset("assets/icons/credit-card.png",height: 30,width: 35),index: ()=>setState(()=>checkoutModel.paymentType = 'card')),
                        TabData(active: true,ic_name: "UPI",fontSize:14,icon:  Image.asset("assets/icons/UPI.png",height: 30,width: 35),index: () {
                          print("selected order type online");
                          setState(()=>checkoutModel.paymentType = 'online');
                        }),
                      ],
                        onTabTap: (_){},
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height:(LayoutView(context).isWeb || LayoutView(context).isTab) ? MediaQuery.of(context).size.width/3 :MediaQuery.of(context).size.width,

                  width: (LayoutView(context).isWeb || LayoutView(context).isTab) ? MediaQuery.of(context).size.width/3:MediaQuery.of(context).size.width,

                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      BlocConsumer<LoyaltyBloc, LoyaltyState>(
                        listener: (context, state) {
                          // TODO: implement listener
                          if(state is LoyaltySucsess<String>){
                            checkoutModel.point = state.loyaltyPoint;
                            print("state.promoamount..."+checkoutModel.point!);
                            if(dailog) {
                              context.pop();
                            }
                            if(state.promomsg!=""||state.promomsg!=null){
                              print(state.promomsg);
                              print("state.promoamount..."+state.promoamount);
                              setState(() {
                                promocode  =state.promomsg;
                                promoAmount = state.promoamount;
                              });
                            }else if(state is LoyaltyLoading){
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    dailog = true;
                                    return StatefulBuilder(builder: (context, setState) {
                                      return AbsorbPointer(
                                        child: Container(
                                          color: Colors.transparent,
                                          height: double.infinity,
                                          width: double.infinity,
                                          alignment: Alignment.center,
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    });
                                  });
                            }
                              else{
                              if(dailog) {
                                context.pop();
                              }
                              setState(() {
                                promocode  ="";
                              });
                            }
                          }
                        },
                        builder: (context, state) {
                          String totalamount ="";
                          String loyaltyPoints ="";
                          if(state is LoyaltySucsess<String>){
                            print("state.data"+state.data.toString());
                            totalamount = (double.parse(state.data)).toStringAsFixed(2);
                            checkoutModel.loyalty = double.parse(state.loyality)>0;
                            loyaltyPoints = state.loyality;
                           waletamt = state.walletused;
                            // checkoutModel.walletBalance = state.walletused;
                            print("wltused${ state.walletused}");
                            //checkoutModel.total = totalamount;
                          }
                          return Padding(
                            padding: const EdgeInsets.only(left:10.0,right:20.0,top: 40.0),
                            child: Container(
                              child: widget.list_cart_items.isNotEmpty ?
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      // mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children:[
                                          const Text("Your Cart Value",style: TextStyle(color: Colors.black,fontSize:14,fontWeight: FontWeight.bold)),
                                          Text("₹${cal.calculateTotalMRP(widget.list_cart_items) }",style: const TextStyle(color: Colors.black,fontSize:14,fontWeight: FontWeight.bold)),
                                        ]),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: Row(
                                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //       children:[
                                  //         const Text("Delivary Charges",style: TextStyle(color: Colors.grey,fontSize:10,fontWeight: FontWeight.bold)),
                                  //         Text("₹${cal.calculateDeliveryCharge(widget.list_cart_item)??0 }",style: const TextStyle(color: Colors.grey,fontSize:10,fontWeight: FontWeight.bold)),
                                  //       ]),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      // mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children:[
                                          const Text("You saved (Loyalty Coins)",style: TextStyle(color: Colors.black,fontSize:14,fontWeight: FontWeight.bold)),
                                          Text("${checkoutModel.loyalty?loyaltyPoints:0 }",style: const TextStyle(color: Colors.black,fontSize:14,fontWeight: FontWeight.bold)),
                                        ]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      // mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children:[
                                          const Text("Your Wallet Amount",style: TextStyle(color: Colors.black,fontSize:14,fontWeight: FontWeight.bold)),

// if()
                                          Text("₹${state is LoyaltySucsess<String>?state.walletused:0 }",style: const TextStyle(color: Colors.black,fontSize:14,fontWeight: FontWeight.bold)),
                                        ]),
                                  ),
                                  (checkoutModel.promocode! != "" && (promocode != "invalid promocode!"))? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      // mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children:[
                                           Text("You have applied "+"("+ checkoutModel.promocode!+ ")"+ " promocode",style: TextStyle(color: Colors.black,fontSize:14,fontWeight: FontWeight.bold)),

// if()
                                         Text("₹${state is LoyaltySucsess<String>?state.promoamount:0 }",style: const TextStyle(color: Colors.black,fontSize:14,fontWeight: FontWeight.bold)),
                                        ]),
                                  ):SizedBox.shrink(),

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      // mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children:[
                                          const  Text("Total Amount Payable",style: TextStyle(color: Colors.blue,fontSize:16,fontWeight: FontWeight.bold),),

                                          Text("₹${totalamount}",style: const TextStyle(color: Colors.blue,fontSize:16,fontWeight: FontWeight.bold)),
                                        ]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      //mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children:[
                                          const Text("Your Savings",style: TextStyle(color: Colors.green,fontWeight: FontWeight.normal),),
                                          Text("₹${ cal.calculateTotalDiscount(widget.list_cart_items,widget.user.data?.first.membership=="1") }",style: const TextStyle(color: Colors.black,fontSize:12,fontWeight: FontWeight.bold)),
                                        ]),
                                  ),
                                ],
                              ):const SizedBox.shrink(),
                            ),
                          );
                        },
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top:15.0,left:8.0,right:8.0),
                          child: MaterialButton(onPressed: (){
                            if(checkoutModel.paymentType != ''){
                              BlocProvider.of<CheckOutBloc>(context).add(OnCheckOut(widget.list_cart_items,checkoutModel));
                            }else{
                              Alert().showallert(context,messege: 'Select Payment Method');
                            }
                          },color: Colors.green,
                              child:BlocConsumer<CheckOutBloc,CheckOutState>(
                                builder: (contexts,state) {
                                  if(state is CheckOutLoading){
                                    return const Center(child: CircularProgressIndicator(),);
                                  }
                                  if(state is CheckOutSucsess){
                                    BlocProvider.of<CartItemBloc>(context).add(const ClearCart());
                                    BlocProvider.of<UserProfileBloc>(context).add( ClearCustomerData(checkoutModel.apiKey!));
                                    sl<SharedPreferences>().setBool(Prefrence.showSearchbar, false);
                                  }
                                  return const Center(
                                      child: Text("COMPLETE",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),));
                                }, listener: (BuildContext context, state) {
                                if(state is CheckOutSucsess<OrderItem>){
                                  print("sucsess: ${state.data.id}");
                                  Navigator.pop(context);
                                  // Alert().showSuccess(context,messege: "Order Placed");
                                  if(_switchValue) {
                                   // (kIsWeb)?
                                  //  UniversalPrint(widget.user,state.data,widget.list_cart_items).print():
                                    usbprinter.print(state.data,widget.list_cart_items,widget.user,waletamt);
                                  }
                                  print("wb : "+waletamt);
                                }else if(state is CheckOutError){
                                  print(state.e);
                                  Alert().showallert(context,messege: state.e);
                                }
                              },
                              )
                          )
                      ),
                      // Text("${dropdownvalue?["vendorId"]}"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text("Print",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                            Transform.scale(
                              scale: 0.6,
                              child: CupertinoSwitch(
                                value: _switchValue,
                                onChanged: (bool value) {
                                  setState(() {
                                    _switchValue = value;
                                  });
                                },
                              ),
                            ),
                            FutureBuilder<List<Map<String, dynamic>>>(
                              future: usbprinter.getDevicelist(),
                              builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                                if(snapshot.data!=null&&snapshot.data!.isNotEmpty){
                                  dropdownvalue = snapshot.data!.first;
                                  usbprinter.connect(int.parse(dropdownvalue!["vendorId"]),int.parse(dropdownvalue!["productId"]));
                                  return StatefulBuilder(builder: (context, setState) {
                                   return SizedBox(
                                      height: 30,
                                      child: DropdownButton<Map<String, dynamic>>(
                                          value: dropdownvalue,
                                          items: snapshot.data?.map((device) => DropdownMenuItem(
                                            value: device,
                                            child: Text(device['manufacturer']),
                                          )).toList(),
                                          onChanged: (Map<String, dynamic>? val) {
                                            print(" print vi: ${val!["vendorId"]}");
                                            print(" print pi: ${val["productId"]}");
                                            usbprinter.connect(int.parse(val["vendorId"]),int.parse(val["productId"]));
                                            setState(() {
                                              dropdownvalue = val;
                                            });
                                          }),
                                    );
                                  });
                                }else{
                                  return GestureDetector(onTap: (){
                                    usbprinter.getDevicelist();
                                  },child: const Text("Refresh"));
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )

        ),
      ),
    );

  }
  checkoutCalculate(){
    print("wallwt loading");
    BlocProvider.of<LoyaltyBloc>(context).add( OnCheckLoyalty(branch: sl<SharedPreferences>().getString(Prefrence.BRANCH)!, user_point:checkoutModel.loyaltyPoints!,lenable:checkoutModel.loyalty, wallet_amount:checkoutModel.walletBalance!, wenable: checkoutModel.walletType,user:checkoutModel.apiKey!,items: widget.list_cart_items,promocode:checkoutModel.promocode!,promoenable: checkoutModel.promocode!.isNotEmpty, ismember: widget.user.data?.first.membership=="1"));
  }
}
