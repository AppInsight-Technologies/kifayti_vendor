import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../../../core/util/presentation/controller/onpress_controller.dart';
import '../../../../../../core/util/presentation/styles/screen_size_rario.dart';
//import '../../../../../../core/util/scanner/barcode_listner.dart';
import '../../../../../../core/util/scanner/barcode_listner.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../injection_container.dart';
import '../../../../domain/entities/delivery_list_model.dart';
import '../../../../domain/entities/picker_list_model.dart';
import '../../../../domain/entities/update_order_model.dart';
import '../../../../domain/usecases/edit_order_status_usecase.dart';
import '../../../bloc/delivery_list/delivery_list_bloc.dart';
import '../../../bloc/edit_order_status/edit_order_status_bloc.dart';
import '../../../bloc/picker_list/picker_list_bloc.dart';
import '../../../bloc/shop/my_shop_bloc.dart';
import '../../../bloc/update_order/update_order_bloc.dart';
import '../../../bloc/update_order_status/update_order_status_bloc.dart';
import '../../widgte/dailog/alert _dailog.dart';

class UpdateOrderScreen extends StatefulWidget {
  final  Map<String, dynamic> value;

  const UpdateOrderScreen( this.value, {Key? key,/*required this.params*/}) : super(key: key);

  @override
  State<UpdateOrderScreen> createState() => _UpdateOrderScreenState();
}

class _UpdateOrderScreenState extends State<UpdateOrderScreen> {
  String dropdownValue = '';
  String dropdowndeliveryValue = '';
  var OrdersArray = [];
  bool is_order_ready = false;
  String   prepare =  "PREPARING";
  String orderId ="";
  int selectedIndex = 0;
  List preparedItem = [];
  TextEditingController _controller = TextEditingController();
  int _groupValue = -1;
  final _form = GlobalKey<FormState>();
  TextEditingController _ReceiverText = TextEditingController();
  String code = "";
  @override
  void initState() {
    // TODO: implement initState
    OrdersArray = [false,false] ;
    BlocProvider.of<UpdateOrderBloc>(context).add(OnUpdateOrderEvent(widget.value['oid']));
    BlocProvider.of<PickerListBloc>(context).add(OnPickerListEvent(sl<SharedPreferences>().getString(Prefrence.BRANCH)??''));
    BlocProvider.of<DeliveryListBloc>(context).add(OnDeliveryListEvent(sl<SharedPreferences>().getString(Prefrence.BRANCH)??''));

    orderId = widget.value['oid'];

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    showmeditpopup(Items e) {
      return (LayoutView(context).isMobile)?
      showModalBottomSheet(
          shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          context: context,
          builder: (BuildContext context)
          {
            return
              StatefulBuilder(
                builder: (context, setState1) {
                  return BlocBuilder<UpdateOrderBloc, UpdateOrderState>(
                      builder: (context, stateedit) {
                        if(stateedit is UpdateOrderSucsess<List<UpdateOrderModel>>)  {
                          return
                            SingleChildScrollView(
                              child: Padding(
                                padding: MediaQuery
                                    .of(context)
                                    .viewInsets,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20)),
                                    color: Colors.white,
                                  ),
                                  padding: LayoutView(context).isMobile?EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5):EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  width: (LayoutView(context).isMobile)?null:MediaQuery
                                      .of(context)
                                      .size
                                      .width / 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width / 1.2,
                                            child: Text(
                                              e.itemName!,
                                              overflow:
                                              TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),

                                          Text(
                                            e.priceVariavtion!,
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black26,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Divider(
                                        color: Colors.black12, thickness: 1,),
                                      SizedBox(height: 10,),
                                      (e.itemType == "0") ?
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text(S.of(context).original_ord_qty,
                                                style: TextStyle(
                                                    fontSize: (LayoutView(context).isMobile)?12:14,
                                                    fontWeight: FontWeight.bold),),
                                              SizedBox(height: 5,),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                height: 30,
                                                width: (LayoutView(context).isMobile)?120:150,
                                                color: Color(0xffE5F3F2),
                                                child: Row(
                                                  children: [
                                                    Text(e.quantity!,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold),),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .end,
                                            children: [
                                              Text(S.of(context).updated_item_qty,
                                                style: TextStyle(
                                                    fontSize: (LayoutView(context).isMobile)?12:14,
                                                    fontWeight: FontWeight.bold),),
                                              SizedBox(height: 5,),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                height: 30,
                                                width: (LayoutView(context).isMobile)?120:150,
                                                color: Color(0xffE5F3F2),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(e.uquantity!,
                                                        style: TextStyle(
                                                            fontWeight: FontWeight
                                                                .bold)),
                                                    PopupMenuButton(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      onSelected: (
                                                          selectedValue) {
                                                        setState1(() {
                                                          e.uquantity =
                                                              selectedValue
                                                                  .toString();
                                                          //prefs.setString("fixdate", date);
                                                        });
                                                      },
                                                      icon: Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color: Theme
                                                            .of(context)
                                                            .primaryColor,
                                                        size: 25,
                                                      ),
                                                      itemBuilder: (_) =>
                                                      <PopupMenuItem<String>>[
                                                        for(int j = 0; j <= double.parse(e.quantity!); j++)
                                                          PopupMenuItem<
                                                              String>(
                                                              child: Text(
                                                                  j.toString(),
                                                                  style: const TextStyle(
                                                                      fontSize: 15,
                                                                      color: Colors
                                                                          .black)),
                                                              value: j.toString()),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ) :
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text(S.of(context).original_ord_qty,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight
                                                        .bold),),
                                              SizedBox(height: 5,),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                height: 30,
                                                width: 150,
                                                color: Color(0xffE5F3F2),
                                                child: Row(
                                                  children: [
                                                    Text(e.weight!,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold),),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .end,
                                            children: [
                                              Text(S.of(context).updated_item_qty,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight
                                                        .bold),),
                                              SizedBox(height: 5,),
                                              Container(
                                                height: 30,
                                                width: 150,
                                                color: Color(0xffE5F3F2),
                                                child: TextFormField(
                                                  textAlign: TextAlign.left,
                                                  controller: _controller,
                                                  style: new TextStyle(
                                                      decorationColor: Theme
                                                          .of(context)
                                                          .primaryColor),
                                                  keyboardType: TextInputType
                                                      .numberWithOptions(
                                                      decimal: true),
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp(
                                                        r'^\d*\.?\d{0,2}')),
                                                  ],
                                                  decoration: InputDecoration(
                                                    hintText: S.of(context).edit_weight,
                                                    hintStyle: TextStyle(
                                                        fontSize: 12),
                                                    fillColor: Colors.green,
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(6),
                                                      borderSide: BorderSide(
                                                          color: Colors.grey),
                                                    ),
                                                    errorBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(6),
                                                      borderSide: BorderSide(
                                                          color: Colors.green),
                                                    ),
                                                    focusedErrorBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(6),
                                                      borderSide: BorderSide(
                                                          color: Colors.green),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(6),
                                                      borderSide:
                                                      BorderSide(
                                                          color: Colors.green,
                                                          width: 1.2),
                                                    ),
                                                  ),
                                                  onChanged: (
                                                      String value) async {
                                                    setState1(() {
                                                      if(_controller.text == ""||_controller.text == ".") {
                                                        e.uweight =  e.weight;
                                                        e.checkboxval = false;
                                                      } else {
                                                        e.uweight = _controller.text;
                                                        e.checkboxval = true;
                                                        e.varedit=true;
                                                      }
                                                    });
                                                  },
                                                ),
                                              ),

                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Divider(
                                        color: Colors.black12, thickness: 1,),
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          Text(
                                            S.of(context).reason_for_editing,
                                            style: TextStyle(color: Colors
                                                .grey,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      GestureDetector(
                                        onTap: () {
                                          setState1(() {
                                            _groupValue = 1;
                                          });
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  S.of(context).wrong_item_price,
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight
                                                          .bold),
                                                ),
                                                Text(
                                                  S.of(context).some_difference_in_current_price,
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight
                                                          .w400),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                _groupValue == 1 ?
                                                Container(
                                                  width: 20.0,
                                                  height: 20.0,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                      color: Theme
                                                          .of(context)
                                                          .accentColor,
                                                    ),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Container(
                                                    margin: EdgeInsets.all(1.8),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Icon(Icons.check,
                                                        color: Theme
                                                            .of(context)
                                                            .accentColor,
                                                        size: 15.0),
                                                  ),
                                                )
                                                    :
                                                Icon(
                                                    Icons
                                                        .radio_button_off_outlined,
                                                    color: Theme
                                                        .of(context)
                                                        .accentColor),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      GestureDetector(
                                        onTap: () {
                                          setState1(() {
                                            _groupValue = 2;
                                          });
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  S.of(context).out_of_stock,
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight
                                                          .bold),
                                                ),
                                                Text(
                                                  S.of(context).item_is_not_on_the_shelf,
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight
                                                          .w400),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                _groupValue == 2 ?
                                                Container(
                                                  width: 20.0,
                                                  height: 20.0,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                      color: Theme
                                                          .of(context)
                                                          .accentColor,
                                                    ),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Container(
                                                    margin: EdgeInsets.all(1.8),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Icon(Icons.check,
                                                        color: Theme
                                                            .of(context)
                                                            .accentColor,
                                                        size: 15.0),
                                                  ),
                                                )
                                                    :
                                                Icon(
                                                    Icons
                                                        .radio_button_off_outlined,
                                                    color: Theme
                                                        .of(context)
                                                        .accentColor),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      GestureDetector(
                                        onTap: () {
                                          setState1(() {
                                            _groupValue = 3;
                                          });
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  S.of(context).poor_quality,
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight
                                                          .bold),
                                                ),
                                                Text(
                                                  S.of(context).item_is_in_a_bad_condition,
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight
                                                          .w400),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                _groupValue == 3 ?
                                                Container(
                                                  width: 20.0,
                                                  height: 20.0,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                      color: Theme
                                                          .of(context)
                                                          .accentColor,
                                                    ),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Container(
                                                    margin: EdgeInsets.all(1.8),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Icon(Icons.check,
                                                        color: Theme
                                                            .of(context)
                                                            .accentColor,
                                                        size: 15.0),
                                                  ),
                                                )
                                                    :
                                                Icon(
                                                    Icons
                                                        .radio_button_off_outlined,
                                                    color: Theme
                                                        .of(context)
                                                        .accentColor),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(
                                        height: 10,
                                      ),

                                      SizedBox(
                                        height: 10,
                                      ),
                                      BlocListener<EditOrderStatusBloc,EditOrderStatusState>(
                                        listener: (context, state1) {
                                          print("moved inside.....1"+state1.toString());
                                          if(state1 is EditOrderStatusStateSucsess){
                                            print("moved inside....."+state1.toString());
                                            Navigator.pop(context);
                                           return BlocProvider.of<UpdateOrderBloc>(context).add(OnUpdateOrderEvent(widget.value['oid']));

                                          }
                                        },
                                        child: GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              if (_groupValue == 0) {
                                                e.selectedreason =_ReceiverText.text;
                                              } else if (_groupValue == 1) {
                                                e.selectedreason =
                                                    S.of(context).wrong_item_price;
                                              } else if (_groupValue == 2) {
                                                e.selectedreason =
                                                    S.of(context).out_of_stock;
                                              } else if (_groupValue == 3) {
                                                e.selectedreason =
                                                    S.of(context).poor_quality;
                                              }


                                              if(e.itemType == "1") {
                                                debugPrint("_controller.text..."+_controller.text);
                                                if (_controller.text ==
                                                    "" ||
                                                    _controller.text ==
                                                        ".") {
                                                  e.uweight = e.weight;
                                                  e.checkboxval = false;
                                                } else {
                                                  e.uweight =
                                                      _controller.text;
                                                  e.checkboxval = true;
                                                  e.varedit = true;
                                                }
                                              }

                                              if(e.itemType == "0") {
                                                if (double.parse(e.quantity!) <
                                                    double.parse(
                                                        e.uquantity!)) {
                                                  e.checkboxval = true;
                                                }
                                              }
                                            });
                                            if(double.parse(e.uweight!)>double.parse(e.weight!) && e.itemType == "1"){
                                              Alert().showallert(context,messege: S.of(context).cant_edit_more +e.weight!);
                                            }else if(_groupValue == 0 ){
                                              Alert().showallert(context,messege: S.of(context).please_enter_issue);
                                            }else{
                                             // Navigator.pop(context);
                                              List<ItemsList> items = [];

                                              items.add(ItemsList(id:e.id ,loyalty:e.loyalty ,oqty:e.itemType=="1"?"0":e.quantity ,qty:e.itemType=="1"?"0":e.uquantity ,reason:e.selectedreason,price: e.subTotal,weight: e.uweight,cweight: e.weight,type: e.itemType ));
                                              debugPrint("items..."+e.id!+"..."+e.loyalty!+"...."+e.uweight!+"..."+e.weight!+"..."+e.selectedreason!+"..."+e.price!);
                                              BlocProvider.of<EditOrderStatusBloc>(context).add(OnEditOrderStatusEvent(editOrderStatusParams(order: widget.value['oid'],items:items,deliveryBoy: "",isDelivery: "0" )));
                                              /*setState(() {
                                               e.prepare = S.of(context).prepared;
                                                e.colorCheck = true;
                                              });*/
                                            }
                                          },
                                          child: Container(
                                            height: 60,
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Theme.of(context).primaryColor,

                                            ),
                                            child: Center(child: Text(S.of(context).update,
                                              style: TextStyle(fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white
                                              ),
                                            )),
                                          ),
                                        )



                                        // Center(
                                        //   child: SizedBox(
                                        //     width: MediaQuery
                                        //         .of(context)
                                        //         .size
                                        //         .width ,
                                        //     child: FlatButton(
                                        //       onPressed: () {
                                        //         setState(() {
                                        //           if (_groupValue == 0) {
                                        //             e.selectedreason =_ReceiverText.text;
                                        //           } else if (_groupValue == 1) {
                                        //             e.selectedreason =
                                        //            S.of(context).wrong_item_price;
                                        //           } else if (_groupValue == 2) {
                                        //             e.selectedreason =
                                        //             S.of(context).out_of_stock;
                                        //           } else if (_groupValue == 3) {
                                        //             e.selectedreason =
                                        //             S.of(context).poor_quality;
                                        //           }
                                        //
                                        //
                                        //           if(e.itemType == "1") {
                                        //             debugPrint("_controller.text..."+_controller.text);
                                        //             if (_controller.text ==
                                        //                 "" ||
                                        //                 _controller.text ==
                                        //                     ".") {
                                        //               e.uweight = e.weight;
                                        //               e.checkboxval = false;
                                        //             } else {
                                        //               e.uweight =
                                        //                   _controller.text;
                                        //               e.checkboxval = true;
                                        //               e.varedit = true;
                                        //             }
                                        //           }
                                        //
                                        //           if(e.itemType == "0") {
                                        //             if (double.parse(e.quantity!) <
                                        //                 double.parse(
                                        //                     e.uquantity!)) {
                                        //               e.checkboxval = true;
                                        //             }
                                        //           }
                                        //         });
                                        //         if(double.parse(e.uweight!)>double.parse(e.weight!) && e.itemType == "1"){
                                        //           Alert().showallert(context,messege: S.of(context).cant_edit_more +e.weight!);
                                        //         }else if(_groupValue == 0 ){
                                        //           Alert().showallert(context,messege: S.of(context).please_enter_issue);
                                        //         }else{
                                        //           Navigator.pop(context);
                                        //           List<ItemsList> items = [];
                                        //           items.add(ItemsList(id:e.id ,loyalty:e.loyalty ,oqty:e.itemType=="1"?"0":e.quantity ,qty:e.itemType=="1"?"0":e.uquantity ,reason:e.selectedreason,price: e.subTotal,weight: e.uweight,cweight: e.weight,type: e.itemType ));
                                        //           debugPrint("items..."+e.id!+"..."+e.loyalty!+"...."+e.uweight!+"..."+e.weight!+"..."+e.selectedreason!+"..."+e.price!);
                                        //           BlocProvider.of<EditOrderStatusBloc>(context).add(OnEditOrderStatusEvent(editOrderStatusParams(order: widget.value['oid'],items:items,deliveryBoy: "",isDelivery: "0" )));// Alert().showSuccess(context,messege: "Item Edited Successfully");
                                        //
                                        //         }
                                        //
                                        //       },
                                        //       padding: EdgeInsets.symmetric(
                                        //           vertical: 14),
                                        //       color: Theme
                                        //           .of(context)
                                        //           .accentColor,
                                        //       shape: RoundedRectangleBorder(
                                        //         borderRadius: BorderRadius.circular(
                                        //             5),
                                        //       ),
                                        //       child: Text(
                                        //        S.of(context).update,
                                        //         textAlign: TextAlign.start,
                                        //         style: TextStyle(
                                        //             color: Colors.white,
                                        //             fontSize: 16,
                                        //             fontWeight: FontWeight.bold),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );

                        }
                        else{
                          return SizedBox.shrink();
                        }
                      });
                });

          }):
      showDialog(
          context: context,
          builder: (BuildContext context)
          {
            return StatefulBuilder(
                builder: (context, setState1) {
                  return BlocBuilder<UpdateOrderBloc, UpdateOrderState>(
                      builder: (context, stateedit) {
                        if(stateedit is UpdateOrderSucsess<List<UpdateOrderModel>>)  {
                               return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                        child:
                               SingleChildScrollView(
                                child: Padding(
                                  padding: MediaQuery
                                      .of(context)
                                      .viewInsets,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)),
                                      color: Colors.white,
                                    ),
                                    padding: LayoutView(context).isMobile?EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5):EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    width: (LayoutView(context).isMobile)?null:MediaQuery
                                        .of(context)
                                        .size
                                        .width / 3,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(
                                              e.itemName!,
                                              overflow:
                                              TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                  color: Colors.black),
                                            ),
                                            SizedBox(height: 5,),
                                            Text(
                                              e.priceVariavtion!,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Divider(
                                          color: Colors.black12, thickness: 1,),
                                        SizedBox(height: 10,),
                                        (e.itemType == "0") ?
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(S.of(context).original_ord_qty,
                                                  style: TextStyle(
                                                      fontSize: (LayoutView(context).isMobile)?12:14,
                                                      fontWeight: FontWeight
                                                          .bold),),
                                                SizedBox(height: 5,),
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  height: 30,
                                                  width: (LayoutView(context).isMobile)?120:150,
                                                  color:Color(0xffE5F3F2),
                                                  child: Row(
                                                    children: [
                                                      Text(e.quantity!,
                                                        style: TextStyle(
                                                            fontWeight: FontWeight
                                                                .bold),),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .end,
                                              children: [
                                                Text(S.of(context).updated_item_qty,
                                                  style: TextStyle(
                                                      fontSize: (LayoutView(context).isMobile)?12:14,
                                                      fontWeight: FontWeight
                                                          .bold),),
                                                SizedBox(height: 5,),
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  height: 30,
                                                  width: (LayoutView(context).isMobile)?120:150,
                                                  color:Color(0xffE5F3F2),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Text(e.uquantity!,
                                                          style: TextStyle(
                                                              fontWeight: FontWeight
                                                                  .bold)),
                                                      PopupMenuButton(
                                                        padding: EdgeInsets.only(
                                                            bottom: 10),
                                                        onSelected: (
                                                            selectedValue) {
                                                          setState1(() {
                                                            e.uquantity =
                                                                selectedValue
                                                                    .toString();
                                                            //prefs.setString("fixdate", date);
                                                          });
                                                        },
                                                        icon: Icon(
                                                          Icons
                                                              .keyboard_arrow_down,
                                                          color: Theme
                                                              .of(context)
                                                              .primaryColor,
                                                          size: 25,
                                                        ),
                                                        itemBuilder: (_) =>
                                                        <PopupMenuItem<String>>[
                                                          for(int j = 0; j <= double.parse(e.quantity!); j++)
                                                             PopupMenuItem<
                                                                String>(
                                                                child: Text(
                                                                    j.toString(),
                                                                    style: const TextStyle(
                                                                        fontSize: 15,
                                                                        color: Colors
                                                                            .black)),
                                                                value: j.toString()),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ) :
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(S.of(context).original_ord_qty,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight
                                                          .bold),),
                                                SizedBox(height: 5,),
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  height: 30,
                                                  width: 150,
                                                  color: Color(0xffE5F3F2),
                                                  child: Row(
                                                    children: [
                                                      Text(e.weight!,
                                                        style: TextStyle(
                                                            fontWeight: FontWeight
                                                                .bold),),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .end,
                                              children: [
                                                Text(S.of(context).updated_item_qty,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight
                                                          .bold),),
                                                SizedBox(height: 5,),
                                                Container(
                                                  height: 30,
                                                  width: 150,
                                                  color: Color(0xffE5F3F2),
                                                  child: TextFormField(
                                                    textAlign: TextAlign.left,
                                                    controller: _controller,
                                                    style: new TextStyle(
                                                        decorationColor: Theme
                                                            .of(context)
                                                            .primaryColor),
                                                    keyboardType: TextInputType
                                                        .numberWithOptions(
                                                        decimal: true),
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(RegExp(
                                                          r'^\d*\.?\d{0,2}')),
                                                    ],
                                                    decoration: InputDecoration(
                                                      hintText: S.of(context).edit_weight,
                                                      hintStyle: TextStyle(
                                                          fontSize: 12),
                                                      fillColor: Colors.green,
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .circular(6),
                                                        borderSide: BorderSide(
                                                            color: Colors.grey),
                                                      ),
                                                      errorBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .circular(6),
                                                        borderSide: BorderSide(
                                                            color: Colors.green),
                                                      ),
                                                      focusedErrorBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .circular(6),
                                                        borderSide: BorderSide(
                                                            color: Colors.green),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .circular(6),
                                                        borderSide:
                                                        BorderSide(
                                                            color: Colors.green,
                                                            width: 1.2),
                                                      ),
                                                    ),
                                                    onChanged: (
                                                        String value) async {
                                                      setState1(() {
                                                        if(_controller.text == ""||_controller.text == ".") {
                                                          e.uweight =  e.weight;
                                                          e.checkboxval = false;
                                                        } else {
                                                          e.uweight = _controller.text;
                                                          e.checkboxval = true;
                                                          e.varedit=true;
                                                        }
                                                      });
                                                    },
                                                  ),
                                                ),

                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Divider(
                                          color: Colors.black12, thickness: 1,),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Text(
                                              S.of(context).reason_for_editing,
                                              style: TextStyle(color: Colors
                                                  .grey,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        GestureDetector(
                                          onTap: () {
                                            setState1(() {
                                              _groupValue = 1;
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    S.of(context).wrong_item_price,
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight
                                                            .bold),
                                                  ),
                                                  Text(
                                                    S.of(context).some_difference_in_current_price,
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight
                                                            .w400),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  _groupValue == 1 ?
                                                  Container(
                                                    width: 20.0,
                                                    height: 20.0,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color: Theme
                                                            .of(context)
                                                            .accentColor,
                                                      ),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Container(
                                                      margin: EdgeInsets.all(1.8),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Icon(Icons.check,
                                                          color: Theme
                                                              .of(context)
                                                              .accentColor,
                                                          size: 15.0),
                                                    ),
                                                  )
                                                      :
                                                  Icon(
                                                      Icons
                                                          .radio_button_off_outlined,
                                                      color: Theme
                                                          .of(context)
                                                          .accentColor),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        GestureDetector(
                                          onTap: () {
                                            setState1(() {
                                              _groupValue = 2;
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    S.of(context).out_of_stock,
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight
                                                            .bold),
                                                  ),
                                                  Text(
                                                    S.of(context).item_is_not_on_the_shelf,
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight
                                                            .w400),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  _groupValue == 2 ?
                                                  Container(
                                                    width: 20.0,
                                                    height: 20.0,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color: Theme
                                                            .of(context)
                                                            .accentColor,
                                                      ),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Container(
                                                      margin: EdgeInsets.all(1.8),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Icon(Icons.check,
                                                          color: Theme
                                                              .of(context)
                                                              .accentColor,
                                                          size: 15.0),
                                                    ),
                                                  )
                                                      :
                                                  Icon(
                                                      Icons
                                                          .radio_button_off_outlined,
                                                      color: Theme
                                                          .of(context)
                                                          .accentColor),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        GestureDetector(
                                          onTap: () {
                                            setState1(() {
                                              _groupValue = 3;
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    S.of(context).poor_quality,
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight
                                                            .bold),
                                                  ),
                                                  Text(
                                                    S.of(context).item_is_in_a_bad_condition,
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight
                                                            .w400),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  _groupValue == 3 ?
                                                  Container(
                                                    width: 20.0,
                                                    height: 20.0,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color: Theme
                                                            .of(context)
                                                            .accentColor,
                                                      ),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Container(
                                                      margin: EdgeInsets.all(1.8),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Icon(Icons.check,
                                                          color: Theme
                                                              .of(context)
                                                              .accentColor,
                                                          size: 15.0),
                                                    ),
                                                  )
                                                      :
                                                  Icon(
                                                      Icons
                                                          .radio_button_off_outlined,
                                                      color: Theme
                                                          .of(context)
                                                          .accentColor),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                        SizedBox(
                                          height: 10,
                                        ),

                                        SizedBox(
                                          height: 10,
                                        ),
                                        BlocListener<EditOrderStatusBloc,EditOrderStatusState>(
                                          listener: (context, state1) {
                                            print("moved inside.....1"+state1.toString());
                                            if(state1 is EditOrderStatusStateSucsess){
                                              print("moved inside....."+state1.toString());

                                              BlocProvider.of<UpdateOrderBloc>(context).add(OnUpdateOrderEvent(widget.value['oid']));
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: Center(
                                            child: SizedBox(
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width / 3,
                                              child: FlatButton(
                                                onPressed: () {
                                                  setState(() {
                                                    if (_groupValue == 0) {
                                                      e.selectedreason =_ReceiverText.text;
                                                    } else if (_groupValue == 1) {
                                                      e.selectedreason =
                                                          S.of(context).wrong_item_price;
                                                    } else if (_groupValue == 2) {
                                                      e.selectedreason =
                                                          S.of(context).out_of_stock;
                                                    } else if (_groupValue == 3) {
                                                      e.selectedreason =
                                                          S.of(context).poor_quality;
                                                    }


                                                    if(e.itemType == "1") {
                                                      debugPrint("_controller.text..."+_controller.text);
                                                      if (_controller.text ==
                                                          "" ||
                                                          _controller.text ==
                                                              ".") {
                                                        e.uweight = e.weight;
                                                        e.checkboxval = false;
                                                      } else {
                                                        e.uweight =
                                                            _controller.text;
                                                        e.checkboxval = true;
                                                        e.varedit = true;
                                                      }
                                                    }

                                                    if(e.itemType == "0") {
                                                      if (double.parse(e.quantity!) <
                                                          double.parse(
                                                              e.uquantity!)) {
                                                        e.checkboxval = true;
                                                      }
                                                    }
                                                  });
                                                  if(double.parse(e.uweight!)>double.parse(e.weight!) && e.itemType == "1"){
                                                    Alert().showallert(context,messege:  S.of(context).cant_edit_more +e.weight!);
                                                  }else if(_groupValue == 0 ){
                                                    Alert().showallert(context,messege: S.of(context).please_enter_issue);
                                                  }else{
                                                  //  Navigator.pop(context);
                                                    List<ItemsList> items = [];
                                                    items.add(ItemsList(id:e.id ,loyalty:e.loyalty ,oqty:e.itemType=="1"?"0":e.quantity ,qty:e.itemType=="1"?"0":e.uquantity ,reason:e.selectedreason,price: e.subTotal,weight: e.uweight,cweight: e.weight,type: e.itemType ));
                                                    debugPrint("items..."+e.id!+"..."+e.loyalty!+"...."+e.uweight!+"..."+e.weight!+"..."+e.selectedreason!+"..."+e.price!);
                                                    BlocProvider.of<EditOrderStatusBloc>(context).add(OnEditOrderStatusEvent(editOrderStatusParams(order: widget.value['oid'],items:items,deliveryBoy: "",isDelivery: "0" )));// Alert().showSuccess(context,messege: "Item Edited Successfully");

                                                  }

                                                },
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 14),
                                                color: Theme
                                                    .of(context)
                                                    .accentColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(
                                                      5),
                                                ),
                                                child: Text(
                                                  S.of(context).update,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              );
                            }
                        else{
                              return SizedBox.shrink();
                            }
                        });
                });

          });
    }



    bottomsheetforDeliveryboy() {

      return (LayoutView(context).isMobile)?
      showModalBottomSheet(
          shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          context: context,
          builder: (BuildContext context)
          {
            return StatefulBuilder(
                builder: (context, setState1) {
                  return  BlocBuilder<DeliveryListBloc, DeliveryListState>(
                      builder: (context, state) {
                        if (state is DeliveryListSucsess<List<DeliveryListModel>>) {
                          debugPrint("state..."+state.data.length.toString());
                          return Wrap(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10,),
                                    Text(S.of(context).select_delivery_partner,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                    SizedBox(height: 10,),
                                    SizedBox(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          //scrollDirection: Axis.horizontal,
                                          itemCount: state.data.length,
                                          itemBuilder: (_, i)
                                          {
                                            debugPrint("i..."+i.toString());
                                            return  GestureDetector(
                                              onTap: () {
                                                setState1(() {
                                                  selectedIndex = i;
                                                });
                                               debugPrint("selected...index.."+selectedIndex.toString());
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 5.0,bottom: 5,left: 15,right: 15),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      state.data[i].firstName!,
                                                      style: TextStyle(
                                                          color: (selectedIndex ==
                                                              i)
                                                              ? Theme.of(context)
                                                              .primaryColor
                                                              : Colors.black26,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 14),
                                                    ),

                                                    handler(i),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                    SizedBox(height: 20,),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.pop(context);

                                        BlocProvider.of<UpdateOrderStatusBloc>(context).add(
                                            AssainDelevery(sl<SharedPreferences>().getString(Prefrence.BRANCH)??'',
                                                orderId,"dispatched",
                                                state.data[selectedIndex].id!));

                                        /*BlocProvider.of<
                                            UpdateOrderStatusBloc>(
                                            context).add(OrderReady(
                                            sl<SharedPreferences>()
                                                .getString(
                                                Prefrence.BRANCH) ?? '',
                                            orderId, S
                                            .of(context)
                                            .READY
                                            .toLowerCase(), "", state.data[selectedIndex].firstName!));*/
                                        /*Alert().showSuccess(context,
                                            messege: S
                                                .of(context)
                                                .order_updated_successfully);*/
                                      },
                                      child: Container(
                                        height: 60,
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Theme.of(context).primaryColor,

                                        ),
                                        child: Center(child: Text(S.of(context).update,
                                          style: TextStyle(fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white
                                          ),
                                        )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                        else{
                          return SizedBox.shrink();
                        }
                      });
                });

          }):
      showDialog(
          context: context,
          builder: (BuildContext context)
          {
            return  BlocBuilder<DeliveryListBloc, DeliveryListState>(
                builder: (context, state) {
                  if (state is DeliveryListSucsess<List<DeliveryListModel>>) {
                    return Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: state.data.length,
                        itemBuilder: (_, i) =>
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(state.data[i].firstName!),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    //  handler(i),
                                  ],
                                ),
                              ],
                            ),
                      ),
                    );
                  } else{
                    return SizedBox.shrink();
                  }
                }
            );

          });
    }

    Future<void> scanBarcodeNormal(UpdateOrderModel data) async {
      String barcodeScanRes;
      try {
        barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE);
        print("barcodeScanRes...."+barcodeScanRes+"..."+data.items!.length.toString());
        // code = barcodeScanRes;
        if(barcodeScanRes == "-1"){

        }else {
          for (int i = 0; i < data.items!.length; i++) {
            debugPrint(
                "itemid..." + data.items![i].barcode.toString() + "....." +
                    barcodeScanRes);
            if (data.items![i].barcode == barcodeScanRes) {
              showmeditpopup(data.items![i]);
            } else {
              Alert().showallert(
                  context, messege: S.current.barcode_doesnt_match, onpress: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }, onpresscancel: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              });
            }
          }
        }
        // (data.items??[]).map((e) {
        //   debugPrint("itemid..."+e.barcode!+"....."+barcodeScanRes);
        //   if (e.barcode == barcodeScanRes) {
        //     showmeditpopup(e);
        //   }
        // });

      } on PlatformException {
        barcodeScanRes = 'Failed to get platform version.';
      }



      if (!mounted) return;

    }
    return BlocBuilder<UpdateOrderBloc, UpdateOrderState>(
        builder: (context, state1) {
          if(state1 is UpdateOrderLoading){
            return const Center(child: SizedBox(height: 40,child: CircularProgressIndicator(),));
          }

          if(state1 is UpdateOrderSucsess<List<UpdateOrderModel>>) {
            OrdersArray = state1.data.first.items ?? [];

            return
              WillPopScope(
                onWillPop: (){
                  sl<SharedPreferences>().setString("title", "ORDERS");
                  Navigator.pop(context);
                  return Future.value(false);
                },
                child: Scaffold(
                  backgroundColor: LayoutView(context).isMobile? Colors.white:null,
                    bottomNavigationBar:LayoutView(context).isMobile? SizedBox.shrink():Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        LayoutView (context).isMobile? SizedBox.shrink():
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(color: Colors.transparent)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(
                                              S.of(context).delivery_type, style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, bottom: 8.0),
                                              child: Text(state1.data.first.orderType!,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight
                                                        .bold),),
                                            )
                                          ]
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(S.of(context).delivery, style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, bottom: 8.0),
                                            child: Text(state1.data.first.orderType!,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(S.of(context).grand_total, style: TextStyle(
                                              color: Colors.grey, fontSize: 12)),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, bottom: 8.0),
                                            child: Text(IConstants.currencyFormat+'${state1.data.first.orderAmount}', style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),),
                                          )
                                        ],
                                      )
                                    ]

                                ),
                              )
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (state1.data.first.orderStatus == "READY")?
                            BlocBuilder<DeliveryListBloc, DeliveryListState>(
                                builder: (context, state) {

                                  if(state is DeliveryListSucsess<List<DeliveryListModel>>) {
                                    if(state.data.isNotEmpty)
                                    deliveryValueController.value.value = state.data.first.firstName!;
                                    return (state.data.isNotEmpty)?ValueListenableBuilder<String>(
                                        valueListenable: deliveryValueController.value,
                                        builder: (BuildContext context, String deliverylistmodel, widget2)
                                        {
                                          return Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .only(
                                                  top: 8.0,
                                                  bottom: 8.0),
                                              child: Column(
                                                children: [
                                                  Text(S.of(context).assign_to_delivery_partner, style: TextStyle(fontSize: 14,color: Colors.grey),),
                                                  SizedBox(height: 5,),
                                                  Container(
                                                    height: 25,
                                                    // decoration: BoxDecoration(
                                                    //     color: Colors.blue,
                                                    //     borderRadius: BorderRadius
                                                    //         .circular(
                                                    //         2.0)
                                                    // ),
                                                    child:
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .only(
                                                          left: 8.0,
                                                          right: 8.0),
                                                      child: DropdownButton<
                                                          String>(
                                                        value: deliveryValueController.value.value,
                                                        focusColor: Colors.transparent,
                                                        icon: const Icon(
                                                          Icons
                                                              .keyboard_arrow_down_outlined,),
                                                        elevation: 10,
                                                        style: const TextStyle(
                                                            color: Colors
                                                                .white),
                                                        underline: SizedBox(),
                                                        onChanged: (
                                                            String? newValue) {
                                                          deliveryValueController.value.value = newValue!;
                                                          /* Alert().showSuccess(context,messege: "Are you Sure you want to assign order to ${newValue}", onpress: (){

                                                      },onpresscancel: (){

                                                      });*/
                                                        },
                                                        items: state.data
                                                            .map((e) =>
                                                        e.firstName!)
                                                            .map<
                                                            DropdownMenuItem<
                                                                String>>((
                                                            String value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(
                                                              value,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight: FontWeight.bold
                                                              ),),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),

                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }):SizedBox.shrink();
                                  }
                                  else{
                                    return SizedBox.shrink();
                                  }
                                }):LayoutView (context).isMobile? SizedBox.shrink():SizedBox(width: 100,),
                          (state1.data.first.orderStatus == "COMPLETED" || state1.data.first.orderStatus == "CANCELLED")?SizedBox(width: 200,):
                            (state1.data.first.orderStatus == "PICK" || state1.data.first.orderStatus == "RECEIVED" )?
                            Column(
                                children:[
                                  BlocListener<UpdateOrderStatusBloc,UpdateOrderStatusState>(
                                    listener: (context, state) {
                                      if(state is UpdateOrderStatusSucsess){
                                        BlocProvider.of<UpdateOrderBloc>(context).add(OnUpdateOrderEvent(widget.value['oid']));
                                      }
                                    },
                                    child: Container(
                                      width: (LayoutView (context).isMobile && state1.data.first.orderStatus != "READY")? MediaQuery.of(context).size.width :MediaQuery.of(context).size.width/2,
                                      height:45,
                                      padding: EdgeInsets.only(left: 8,right: 8),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: MaterialButton(onPressed:  (){
                                        if(state1.data.first.orderStatus == "RECEIVED"){
                                          print("state1.data.first.orderStatus....abc1"+state1.data.first.items!.length.toString()+"...."+preparedItem.length.toString());
                                          if(state1.data.first.items!.length == preparedItem.length){
                                            print("Prepared......");
                                            BlocProvider.of<UpdateOrderStatusBloc>(
                                                context).add(OrderReady(
                                                sl<SharedPreferences>().getString(
                                                    Prefrence.BRANCH) ?? '',
                                                orderId, "ready", "", ""));
                                            /*Alert().showSuccess(context,
                                                messege: S.of(context).order_updated_successfully);*/
                                          }else{
                                            print("Prepared......1");
                                            Alert().showallert(context,
                                                messege: S.of(context).all_item_need,onpresscancel: (){},onpress: (){});
                                          }

                                          /* (state1.data.first.items??[]).map((e) {
                                            print("state1.data.first.orderStatus....abc"+state1.data.first.orderStatus!);
                                            if(e.prepare == "Prepared"){
                                              print("Prepared......");
                                              BlocProvider.of<UpdateOrderStatusBloc>(
                                                  context).add(OrderReady(
                                                  sl<SharedPreferences>().getString(
                                                      Prefrence.BRANCH) ?? '',
                                                  orderId, "ready", "", ""));
                                              Alert().showSuccess(context,
                                                  messege: "Order updated successfully");
                                            }else{
                                              print("Prepared......1");
                                              Alert().showallert(context,
                                                  messege: "All items need to be prepared to update the order");
                                            }
                                          });*/
                                        }else {
                                          BlocProvider.of<UpdateOrderStatusBloc>(
                                              context).add(OrderReady(
                                              sl<SharedPreferences>().getString(
                                                  Prefrence.BRANCH) ?? '',
                                              orderId, "ready", "", ""));
                                          /*Alert().showSuccess(context,
                                              messege: S.of(context).order_updated_successfully);*/
                                        }
                                      },
                                        color: Colors.green,
                                        child: Text(S.of(context).order_ready,style: TextStyle(color:Colors.white,fontSize:15,fontWeight: FontWeight.bold),),
                                      ),
                                    ),
                                  ),
                                ]
                            ):
                            Column(
                                children:[
                                  BlocListener<UpdateOrderStatusBloc,UpdateOrderStatusState>(
                                    listener: (context, state) {
                                      if(state is UpdateOrderStatusSucsess){
                                        BlocProvider.of<UpdateOrderBloc>(context).add(OnUpdateOrderEvent(widget.value['oid']));
                                      }
                                    },
                                    child: Container(
                                      width:(LayoutView (context).isMobile && state1.data.first.orderStatus != "READY")? MediaQuery.of(context).size.width :MediaQuery.of(context).size.width/2,
                                      height:45,
                                      padding: EdgeInsets.only(left: 8,right: 8),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: MaterialButton(onPressed:  (){
                                        if(state1.data.first.orderStatus == "READY"){

                                          (deliveryValueController.value.value == "")?
                                          Alert().showallert(context,
                                              messege: S.of(context).there_is_no_delivery,onpresscancel: (){},onpress: (){})
                                         : BlocProvider.of<UpdateOrderStatusBloc>(context).add(AssainDelevery(sl<SharedPreferences>().getString(Prefrence.BRANCH)??'',orderId, "dispatched",deliveryValueController.value.value));

                                        }else if(state1.data.first.orderStatus ==  "DISPATCHED"){
                                          BlocProvider.of<UpdateOrderStatusBloc>(
                                              context).add(OrderReady(
                                              sl<SharedPreferences>().getString(
                                                  Prefrence.BRANCH) ?? '',
                                              orderId, "delivered", "", ""));
                                        }
                                        else if( state1.data.first.orderStatus == "DELIVERED"){
                                          BlocProvider.of<UpdateOrderStatusBloc>(
                                              context).add(OrderReady(
                                              sl<SharedPreferences>().getString(
                                                  Prefrence.BRANCH) ?? '',
                                              orderId, "completed", "", ""));
                                        }else{

                                        }
                                      },
                                        color: (state1.data.first.orderStatus == "READY" || state1.data.first.orderStatus == "DISPATCHED"|| state1.data.first.orderStatus == "DELIVERED" ) ?Colors.green :Colors.grey,
                                        child: Text( (state1.data.first.orderStatus == S.of(context).READY)? S.of(context).assign_to_delivery_partner:(state1.data.first.orderStatus == S.of(context).DISPATCHED)?S.of(context).delivered.toUpperCase():( state1.data.first.orderStatus == S.of(context).delivered.toUpperCase())?S.of(context).order_completed:S.of(context).order_ready,style: TextStyle(color:Colors.white,fontSize:15,fontWeight: FontWeight.bold),),
                                      ),
                                    ),
                                  ),
                                ]
                            )
                          ],
                        ),
                      //  SizedBox(height: 80,)
                      ],
                    ),
                    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                    floatingActionButton: (!LayoutView(context).isMobile)?null:
                    BlocBuilder<MyShopBloc, MyShopState>(
                        builder: (context, stateres) {
                          if(stateres is MyShopSucsess) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                (state1.data.first.orderStatus == S
                                    .of(context)
                                    .READY && stateres.shopdata.deliveryLocationType == "1") ?
                                BlocListener<UpdateOrderStatusBloc, UpdateOrderStatusState>(
                                  listener: (context, state) {
                                    if (state is UpdateOrderStatusSucsess) {
                                      BlocProvider.of<UpdateOrderBloc>(context).add(
                                          OnUpdateOrderEvent(widget.value['oid']));
                                    }
                                  },
                                  child: GestureDetector(
                                    onTap: () {
                                      bottomsheetforDeliveryboy();
                                    },
                                    child: Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width - 20,
                                        margin: EdgeInsets.all(10.0),
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                          color: Theme
                                              .of(context)
                                              .primaryColor,
                                        ),
                                        // color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                                        child: Center(
                                            child: Text(S
                                                .of(context)
                                                .Assigned_Delivery,
                                              style: TextStyle(color: Colors.white,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),))),
                                  ),

                                ) :
                                (state1.data.first.orderStatus == "COMPLETED" ||state1.data.first.orderStatus == "ONWAY"||
                                    state1.data.first.orderStatus == "CANCELLED" ||
                                    state1.data.first.orderStatus == "READY" ||  state1.data.first.orderStatus == "DISPATCHED" ||
                                    state1.data.first.orderStatus == "DELIVERED" ||  state1.data.first.orderStatus == "REACHED") ?
                                SizedBox.shrink() :
                                (state1.data.first.orderStatus == "RECEIVED") ?
                                BlocListener<UpdateOrderStatusBloc, UpdateOrderStatusState>(
                                  listener: (context, state) {
                                    if (state is UpdateOrderStatusSucsess) {
                                      BlocProvider.of<UpdateOrderBloc>(context).add(
                                          OnUpdateOrderEvent(widget.value['oid']));
                                    }
                                  },
                                  child: GestureDetector(
                                    onTap: () {
                                      if (state1.data.first.orderStatus == S
                                          .of(context)
                                          .RECEIVED) {

                                        print("state1.data.first.orderStatus....abc1" +
                                            state1.data.first.items!.length.toString() + "...." +
                                            preparedItem.length.toString());
                                        if (state1.data.first.items!.length == preparedItem.length) {
                                          print("Prepared......abc.."+stateres.shopdata.deliveryLocationType!);
                                          if(stateres.shopdata.deliveryLocationType == "1"){
                                            debugPrint("state.data.length...1..");
                                              bottomsheetforDeliveryboy();

                                          }else {
                                            BlocProvider.of<
                                                UpdateOrderStatusBloc>(
                                                context).add(OrderReady(
                                                sl<SharedPreferences>()
                                                    .getString(
                                                    Prefrence.BRANCH) ?? '',
                                                orderId, S
                                                .of(context)
                                                .READY
                                                .toLowerCase(), "", ""));
                                           /* Alert().showSuccess(context,
                                                messege: S
                                                    .of(context)
                                                    .order_updated_successfully);*/
                                          }
                                        } else {
                                          print("Prepared......1");
                                          Alert().showallert(context,
                                              messege: S
                                                  .of(context)
                                                  .all_item_need,
                                              onpresscancel: () {},
                                              onpress: () {});
                                        }
                                      } else {
                                        BlocProvider.of<UpdateOrderStatusBloc>(
                                            context).add(OrderReady(
                                            sl<SharedPreferences>().getString(
                                                Prefrence.BRANCH) ?? '',
                                            orderId, S
                                            .of(context)
                                            .READY
                                            .toLowerCase(), "", ""));
                                        /*Alert().showSuccess(context,
                                            messege: S
                                                .of(context)
                                                .order_updated_successfully);*/
                                      }
                                    },
                                    child: Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width - 20,
                                        margin: EdgeInsets.all(10.0),
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                          color: (state1.data.first.items!.length == preparedItem.length)?Theme
                                              .of(context)
                                              .primaryColor:Colors.grey,
                                        ),
                                        // color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                                        child: Center(
                                            child: Text(S
                                                .of(context)
                                                .order_ready,
                                              style: TextStyle(color: Colors.white,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),))),
                                  ),

                                ) :
                                Column(
                                    children: [
                                      BlocListener<UpdateOrderStatusBloc, UpdateOrderStatusState>(
                                        listener: (context, state) {
                                          if (state is UpdateOrderStatusSucsess) {
                                            BlocProvider.of<UpdateOrderBloc>(context).add(
                                                OnUpdateOrderEvent(widget.value['oid']));
                                          }
                                        },
                                        child: Container(
                                          width: (LayoutView(context).isMobile &&
                                              state1.data.first.orderStatus != "READY") ? MediaQuery
                                              .of(context)
                                              .size
                                              .width : MediaQuery
                                              .of(context)
                                              .size
                                              .width / 2,
                                          height: 45,
                                          padding: EdgeInsets.only(left: 8, right: 8),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: MaterialButton(onPressed: () {
                                            if (state1.data.first.orderStatus == "READY") {
                                              (deliveryValueController.value.value == "") ?
                                              Alert().showallert(context,
                                                  messege: S
                                                      .of(context)
                                                      .there_is_no_delivery,
                                                  onpresscancel: () {},
                                                  onpress: () {})
                                                  : BlocProvider.of<UpdateOrderStatusBloc>(context)
                                                  .add(AssainDelevery(
                                                  sl<SharedPreferences>().getString(
                                                      Prefrence.BRANCH) ?? '', orderId, "dispatched",
                                                  deliveryValueController.value.value));
                                            } else if (state1.data.first.orderStatus == "DISPATCHED") {
                                              BlocProvider.of<UpdateOrderStatusBloc>(
                                                  context).add(OrderReady(
                                                  sl<SharedPreferences>().getString(
                                                      Prefrence.BRANCH) ?? '',
                                                  orderId, "delivered", "", ""));
                                            }
                                            else if (state1.data.first.orderStatus == "DELIVERED") {
                                              BlocProvider.of<UpdateOrderStatusBloc>(
                                                  context).add(OrderReady(
                                                  sl<SharedPreferences>().getString(
                                                      Prefrence.BRANCH) ?? '',
                                                  orderId, "completed", "", ""));
                                            } else {

                                            }
                                          },
                                            color: (state1.data.first.orderStatus == "READY" || state1.data.first.orderStatus == "DISPATCHED" ||
                                                state1.data.first.orderStatus == "DELIVERED") ? Colors.green : Colors.grey,
                                            child: Text((state1.data.first.orderStatus == "READY") ? S
                                                .of(context)
                                                .assign_to_delivery_partner : (state1.data.first
                                                .orderStatus == "DISPATCHED") ? S
                                                .of(context)
                                                .delivered
                                                .toUpperCase() : (state1.data.first.orderStatus == "DELIVERED") ? S
                                                .of(context)
                                                .order_completed : S
                                                .of(context)
                                                .order_ready, style: TextStyle(color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),),
                                          ),
                                        ),
                                      ),
                                    ]
                                )
                              ],
                            );
                          }else{
                            return SizedBox.shrink();
                          }
                      }
                    ),
                    body: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Spacer(),
                              LayoutView (context).isMobile?
                              (state1.data.first.orderStatus == "RECEIVED")? BlocBuilder<PickerListBloc, PickerListState>(
                                  builder: (context, state) {

                                    if(state is PickerListSucsess<List<PickerListModel>>) {
                                      print("state.data.isNotEmpty..."+state.data.isNotEmpty.toString());
                                      if(state.data.isNotEmpty)
                                        pickerValueController.value.value = state.data.first.firstName!;
                                      // ignore: unrelated_type_equality_checks
                                      return (state.data.isNotEmpty && (state.data
                                          .map((e) =>
                                      e.isActive! == "1")).isNotEmpty )?ValueListenableBuilder<String>(
                                          valueListenable: pickerValueController.value,
                                          builder: (BuildContext context, String pickerlistmodel, widget1)
                                          {
                                            return Padding(
                                              padding: const EdgeInsets
                                                  .all(10
                                              ),
                                              child: Column(

                                                children: [
                                                  Text(S.of(context).assign_to_picker, style: TextStyle(fontSize: 14,color: Colors.grey),),
                                                  SizedBox(height: 5,),
                                                  Container(
                                                    height: 25,
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius: BorderRadius
                                                            .circular(
                                                            2.0)
                                                    ),
                                                    child:
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .only(
                                                          left: 8.0,
                                                          right: 8.0),
                                                      child: BlocListener<UpdateOrderStatusBloc,UpdateOrderStatusState>(
                                                        listener: (context, state) {
                                                          if(state is UpdateOrderStatusSucsess){
                                                            BlocProvider.of<UpdateOrderBloc>(context).add(OnUpdateOrderEvent(widget.value['oid']));
                                                          }
                                                        },
                                                        child: DropdownButton<
                                                            String>(
                                                          focusColor: Colors.transparent,
                                                          value: pickerValueController.value.value,
                                                          icon: const Icon(
                                                              Icons
                                                                  .keyboard_arrow_down_outlined,color: Colors.black),
                                                          elevation: 10,
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .white),
                                                          underline: SizedBox(),
                                                          onChanged: (
                                                              String? newValue) {
                                                            pickerValueController.value.value = newValue!;
                                                            Alert().showallert(context,messege: S.of(context).are_you_sure +newValue,onpress: (){
                                                              BlocProvider.of<UpdateOrderStatusBloc>(context).add(AssainPicker(sl<SharedPreferences>().getString(Prefrence.BRANCH)??'',orderId,"pick",newValue));

                                                            },onpresscancel: (){

                                                            });
                                                          },

                                                          items: state.data
                                                              .map((e) =>
                                                          e.firstName!)
                                                              .map<
                                                              DropdownMenuItem<
                                                                  String>>((
                                                              String value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child: Text(
                                                                value,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black
                                                                ),),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ),
                                                    ),

                                                  ),
                                                ],
                                              ),
                                            );
                                          }):SizedBox.shrink();
                                    }
                                    else{
                                      return SizedBox.shrink();
                                    }
                                  }):SizedBox.shrink()
                                  :SizedBox.shrink(),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 20,bottom: 8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xffece9f6),
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(color: Colors.transparent)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 8.0),
                                                      child: Text(S.of(context).order +" #"+state1.data.first.id!,
                                                        style: TextStyle(
                                                            color: Color(0xff503C8C),
                                                            fontSize: 14,
                                                            fontWeight: FontWeight
                                                                .bold),),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 8.0,left: 15),
                                                      child: Container(
                                                          decoration: BoxDecoration(
                                                              color: Color(0xff503C8C)
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets
                                                                .only(
                                                                left: 8.0,
                                                                right: 8.0,top: 3,bottom: 3),
                                                            child: Text((state1.data.first.orderStatus == "RECEIVED")? S.of(context).preparing:state1.data.first.orderStatus!,
                                                              style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 8),),
                                                          )
                                                      ),
                                                    )
                                                  ]
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20.0, bottom: 5.0),
                                                child: Text(state1.data.first.itemsCount.toString() + " "+S.of(context).Item +" .  TL"+ double.parse(state1.data.first.orderAmount!).toStringAsFixed(2),
                                                  style: TextStyle(
                                                      color: Colors.black26,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 10),),
                                              )
                                            ]
                                        ),
                                        // Column(
                                        //   crossAxisAlignment: CrossAxisAlignment
                                        //       .start,
                                        //   children: [
                                        //     Text(state1.data.first.fixtime!,
                                        //       style: TextStyle(color: Colors.grey,
                                        //           fontSize: Vx.isWeb? 12:10,
                                        //           fontWeight: FontWeight.bold),),
                                        //     Padding(
                                        //       padding: const EdgeInsets.only(
                                        //           top: 8.0, bottom: 8.0),
                                        //       child: Row(
                                        //         children: [
                                        //           SizedBox(width: 12,
                                        //               child: Image.asset(
                                        //                   'assets/icons/card.png')),
                                        //           Text(' ₹${state1.data.first
                                        //               .orderAmount} (${state1.data
                                        //               .first.paymentType})',
                                        //             style: TextStyle(
                                        //                 color: Colors.grey,
                                        //                 fontSize: 12,
                                        //                 fontWeight: FontWeight
                                        //                     .bold),),
                                        //         ],
                                        //       ),
                                        //     )
                                        //   ],
                                        // ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .end,
                                          children: [
                                            /*(Vx.isWeb)?*/
                                            (state1.data.first.orderStatus! == "COMPLETED" ||
                                                state1.data.first.orderStatus! == "CANCELLED" ||
                                                state1.data.first.orderStatus! == "READY" ||
                                                state1.data.first.orderStatus! == "DISPATCHED" ||
                                                state1.data.first.orderStatus! == "PICK" ||
                                                state1.data.first.orderStatus! == "ONWAY" ||state1.data.first.orderStatus! == "REACHED" )?SizedBox(width: 30,) :
                                            // BarCodeListner(
                                            //    usekey: true,
                                            //   listen: (code ) {
                                            //     print("Barcode code:$code}");
                                            //     if(code!="") {
                                            //       print("Barcode number:$code}");
                                            //        state1.data.first.items?.map((e) {
                                            //          debugPrint("itemid..."+e.itemId!+"...."+e.id!+"....."+code);
                                            //
                                            //         if (e.itemType == "1"?e.itemId == code:e.id ==code) {
                                            //           showmeditpopup(e);
                                            //         }
                                            //        });
                                            //     //  BlocProvider.of<CartItemBloc>(context).add(CartAdd(u_id: checkoutValueController.value.value.apiKey.toString(),data: FetchCategoryProduct(),varid: code,quantity: 1, membered_user:checkoutValueController.value.value.is_membered_user??"0", idtype: IDType.barcode));
                                            //     }
                                            //   },
                                            //   child:
                                            // Padding(
                                            //   padding: const EdgeInsets.only(top: 8.0),
                                            //   child: Row(children: [
                                            //     Image.asset("assets/icons/barcode.png",width: 15,height: 15,color: Colors.black26),
                                            //    SizedBox(width: 3,),
                                            //     Text(S.of(context).Print, style: TextStyle(
                                            //         color: Colors.black26, fontSize: 10, fontWeight: FontWeight.bold,))
                                            //   ]),
                                            // )
                                            // )
                                            GestureDetector(
                                              onTap: (){
                                                print("click...");
                                                scanBarcodeNormal(state1.data.first);

                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 8.0),
                                                child: Row(children: [
                                                  Image.asset("assets/icons/barcode.png",width: 15,height: 15,color: Colors.black26),
                                                  SizedBox(width: 3,),
                                                  Text(S.of(context).Print, style: TextStyle(
                                                    color: Colors.black26, fontSize: 10, fontWeight: FontWeight.bold,))
                                                ]),
                                              ),
                                            )
                                            /*: Column(children: [
                                              Icon(Icons.print_outlined,
                                                color: Colors.grey, size: 15,),
                                              Text(S.of(context).Print, style: TextStyle(
                                                  color: Colors.grey, fontSize: 10))
                                            ])*/,
                                            Padding(
                                              padding: const EdgeInsets.only(top: 20.0,bottom: 5.0),
                                              child: Text(state1.data.first.fixtime!,
                                                style: TextStyle(color: Colors.black26,
                                                    fontSize: Vx.isWeb? 12:10,
                                                    fontWeight: FontWeight.bold),),
                                            ),
                                            // LayoutView(context).isMobile?
                                            //     SizedBox.shrink()
                                            // :(state1.data.first.orderStatus == S.of(context).RECEIVED)?
                                            // BlocBuilder<PickerListBloc, PickerListState>(
                                            //     builder: (context, state) {
                                            //
                                            //       if(state is PickerListSucsess<List<PickerListModel>>) {
                                            //         pickerValueController.value.value = state.data.first.firstName!;
                                            //         // ignore: unrelated_type_equality_checks
                                            //         return (state.data.isNotEmpty && (state.data
                                            //             .map((e) =>
                                            //         e.isActive! == "1")).isNotEmpty )?ValueListenableBuilder<String>(
                                            //             valueListenable: pickerValueController.value,
                                            //             builder: (BuildContext context, String pickerlistmodel, widget1)
                                            //             {
                                            //               return Padding(
                                            //                 padding: const EdgeInsets
                                            //                     .only(
                                            //                     top: 8.0,
                                            //                     bottom: 8.0),
                                            //                 child: Column(
                                            //                   children: [
                                            //                     Text(S.of(context).assign_to_picker, style: TextStyle(fontSize: 14,color: Colors.grey),),
                                            //                     SizedBox(height: 5,),
                                            //                     Container(
                                            //                       height: 25,
                                            //                       decoration: BoxDecoration(
                                            //                           color: Colors.blue,
                                            //                           borderRadius: BorderRadius
                                            //                               .circular(
                                            //                               2.0)
                                            //                       ),
                                            //                       child:
                                            //                       Padding(
                                            //                         padding: const EdgeInsets
                                            //                             .only(
                                            //                             left: 8.0,
                                            //                             right: 8.0),
                                            //                         child: BlocListener<UpdateOrderStatusBloc,UpdateOrderStatusState>(
                                            //                           listener: (context, state) {
                                            //                             if(state is UpdateOrderStatusSucsess){
                                            //                               BlocProvider.of<UpdateOrderBloc>(context).add(OnUpdateOrderEvent(widget.value['oid']));
                                            //                             }
                                            //                           },
                                            //                           child: DropdownButton<
                                            //                               String>(
                                            //                             focusColor: Colors.transparent,
                                            //                             value: pickerValueController.value.value,
                                            //                             icon: const Icon(
                                            //                                 Icons
                                            //                                     .keyboard_arrow_down_outlined,color: Colors.black),
                                            //                             elevation: 10,
                                            //                             style: const TextStyle(
                                            //                                 color: Colors
                                            //                                     .white),
                                            //                             underline: SizedBox(),
                                            //                             onChanged: (
                                            //                                 String? newValue) {
                                            //                               pickerValueController.value.value = newValue!;
                                            //                               Alert().showallert(context,messege: S.of(context).are_you_sure +newValue,onpress: (){
                                            //                                 BlocProvider.of<UpdateOrderStatusBloc>(context).add(AssainPicker(sl<SharedPreferences>().getString(Prefrence.BRANCH)??'',orderId,S.of(context).PICK.toLowerCase(),newValue));
                                            //
                                            //                               },onpresscancel: (){
                                            //
                                            //                               });
                                            //                             },
                                            //
                                            //                             items: state.data
                                            //                                 .map((e) =>
                                            //                             e.firstName!)
                                            //                                 .map<
                                            //                                 DropdownMenuItem<
                                            //                                     String>>((
                                            //                                 String value) {
                                            //                               return DropdownMenuItem<
                                            //                                   String>(
                                            //                                 value: value,
                                            //                                 child: Text(
                                            //                                   value,
                                            //                                   style: const TextStyle(
                                            //                                       color: Colors
                                            //                                           .black
                                            //                                   ),),
                                            //                               );
                                            //                             }).toList(),
                                            //                           ),
                                            //                         ),
                                            //                       ),
                                            //
                                            //                     ),
                                            //                   ],
                                            //                 ),
                                            //               );
                                            //             }):SizedBox.shrink();
                                            //       }
                                            //       else{
                                            //         return SizedBox.shrink();
                                            //       }
                                            //     }):SizedBox.shrink()
                                          ],
                                        )
                                      ]

                                  ),
                                )
                            ),
                          ),

                          ...(state1.data.first.items ?? []).map((e)
                          {

                            print("state.data.first.orderStatus!.."+e.image!);
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color:LayoutView(context).isMobile? null:Colors.white,
                                         ),
                                      child: LayoutView(context).isMobile?
                                      Row(
                                      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 10.0, bottom: 8.0),
                                            child: CachedNetworkImage(
                                              imageUrl: e.image!,
                                              errorWidget: (context, url, error) => Image.asset(
                                                "assets/images/default_product.png",
                                                width: 80,
                                                height: 100,
                                              ),
                                              placeholder: (context, url) => Image.asset(
                                                "assets/images/default_product.png",
                                                width:80,
                                                height: 100,
                                              ),
                                              width:80,
                                              height:100,
                                              //  fit: BoxFit.fill,
                                            ),
                                          ),
                                          SizedBox(width: 5,),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width / 1.4,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                        width: MediaQuery.of(context)
                                                            .size
                                                            .width / 2,
                                                        child: Text(e.itemName!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),)),
                                                    SizedBox(width: 10,),

                                                    (state1.data.first.orderStatus! == "COMPLETED" ||
                                                        state1.data.first.orderStatus! == "CANCELLED" ||
                                                        state1.data.first.orderStatus! == "READY" ||
                                                        state1.data.first.orderStatus! == "DISPATCHED" ||
                                                        state1.data.first.orderStatus! == "PICK" ||
                                                        state1.data.first.orderStatus! == "ONWAY" ||state1.data.first.orderStatus! == "REACHED" )?SizedBox(width: 30,) :
                                                    GestureDetector(
                                                      onTap: () {
                                                        showmeditpopup(e);

                                                      },
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height:40,
                                                            width:40,
                                                            child: Icon(
                                                              Icons.edit_outlined,
                                                              color: Colors.green,
                                                              size: 16,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(e.itemType == "1" ?"Qty: "+e.weight!  :"Qty: "+ e.quantity! ,style: TextStyle(fontSize: 9,fontWeight: FontWeight.bold, color: Colors.black26),),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [

                                                    Text(IConstants.currencyFormat+ "${double.parse(e.subTotal.toString()).toStringAsFixed(2)}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.black)),

                                                    (state1.data.first.orderStatus! == "PICK" )
                                                        ? SizedBox(width: 50,): (state1.data.first.orderStatus! == "RECEIVED")?
                                                    MaterialButton(
                                                      onPressed: () {
                                                        if(e.prepare == S.of(context).prepared){

                                                        }else {
                                                          setState(() {
                                                            e.prepare = S.of(context).prepared;
                                                            e.colorCheck = true;
                                                          });
                                                          preparedItem.add(e.prepare);
                                                          print("preparedItem...." +
                                                              preparedItem.length.toString());
                                                        }
                                                      },
                                                      color: (e.colorCheck == true)
                                                          ? Colors.green
                                                          : Colors.red,
                                                      child: Text(
                                                        e.prepare!,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    )
                                                        :SizedBox.shrink()
                                                  ],
                                                )
                                                ],
                                            ),
                                          ),



                                        ],
                                      )
                                          :Container(

                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                         border: Border.all(color:Colors.grey ),
                                               ),
                                            child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                            Container(
                                              margin: EdgeInsets.only(top: 10.0, bottom: 8.0),
                                              child: CachedNetworkImage(
                                                imageUrl: e.image!,
                                                errorWidget: (context, url, error) => Image.asset(
                                                  "assets/images/default_product.png",
                                                  width: 100,
                                                  height: 100,
                                                ),
                                                placeholder: (context, url) => Image.asset(
                                                  "assets/images/default_product.png",
                                                  width:100,
                                                  height: 100,
                                                ),
                                                width:100,
                                                height:100,
                                                //  fit: BoxFit.fill,
                                              ),
                                            ),
                                           // SizedBox(width: 10,),
                                            Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width / 3,
                                                    child: Text(e.itemName!),
                                                  ),
                                                  SizedBox(height: 3,),
                                                  Text(e.itemType == "1" ?S.current.Qty +e.weight! : S.current.Qty +e.quantity!,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black26,fontSize: 9),)
                                                ]),
                                            Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width / 5,
                                                child:
                                            Text(IConstants.currencyFormat+"${e.subTotal}")),
                                          (state1.data.first.orderStatus! == "COMPLETED" ||
                                              state1.data.first.orderStatus! == "CANCELLED" || state1.data.first.orderStatus! == "READY" ||
                                              state1.data.first.orderStatus! == "DISPATCHED" || state1.data.first.orderStatus! == "PICK" )?SizedBox(width: 30,) :
                                          GestureDetector(
                                              onTap: () {
                                                showmeditpopup(e);

                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.edit_outlined,
                                                    color: Colors.green,
                                                    size: 12,
                                                  ),
                                                  Text(
                                                    S.of(context).edit,
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          (state1.data.first.orderStatus! == "PICK" )
                                              ? SizedBox(width: 50,): (state1.data.first.orderStatus! == "RECEIVED")?
                                          Container(
                                            padding: EdgeInsets.only(right: 10),
                                            child: MaterialButton(
                                              onPressed: () {
                                                if(e.prepare == S.of(context).prepared){

                                                }else {
                                                  setState(() {
                                                    e.prepare = S.of(context).prepared;
                                                    e.colorCheck = true;
                                                  });
                                                  preparedItem.add(e.prepare);
                                                  print("preparedItem...." +
                                                      preparedItem.length.toString());
                                                }
                                              },
                                              color: (e.colorCheck == true)
                                                  ? Colors.green
                                                  : Colors.red,
                                              child: Text(
                                                e.prepare!,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          )
                                              :SizedBox.shrink(),

                                            // MaterialButton(
                                            //   onPressed: () {
                                            //     /*   setState(() {
                                            //       e.prepare = "Prepared";
                                            //       e.colorCheck = true;
                                            //     });*/
                                            //   },
                                            //   color: Colors.green,
                                            //   child: Text(
                                            //     state1.data.first.orderStatus!,
                                            //     style: TextStyle(
                                            //         color: Colors.white,
                                            //         fontSize: 12,
                                            //         fontWeight: FontWeight.bold),
                                            //   ),
                                            // )
                                            /* : MaterialButton(
                                              onPressed: () {
                                               if (state1.data.first.orderStatus! == "COMPLETED"){

                                               }else {
                                                 setState(() {
                                                   e.prepare = "Prepared";
                                                   e.colorCheck = true;
                                                 });
                                               }
                                              },
                                              color: (e.colorCheck == true)
                                                  ? Colors.green
                                                  : Colors.red,
                                              child: Text(
                                                (state1.data.first.orderStatus! == "COMPLETED")? "COMPLETED":e.prepare!,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),*/
                                        ],
                                      ),
                                          ),
                                  ),
                                ),
                                LayoutView(context).isMobile? Divider(thickness: 2,color: Colors.black12,) :SizedBox.shrink(),

                              ],
                            );
                          }),
                          SizedBox(height: 70,)
                        ],),
                    )

                ),
              );
          }
          else{
            return SizedBox.shrink();
          }
        });
  }

  handler(int i) {
  return  (i == selectedIndex) ?
     Icon(
        Icons.radio_button_checked_outlined,
        color: Theme.of(context).primaryColor)
     :
    Icon(
        Icons.radio_button_off_outlined,
        color: Colors.black12);

  }



}
