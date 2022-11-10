import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_usb_printer/flutter_usb_printer.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../../../core/util/presentation/controller/onpress_controller.dart';
import '../../../../../../core/util/presentation/styles/screen_size_rario.dart';
import '../../../../../../core/util/print/prin_usb.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../injection_container.dart';
import '../../../../domain/entities/delivery_list_model.dart';
import '../../../../domain/entities/picker_list_model.dart';
import '../../../../domain/entities/update_order_model.dart';
import '../../../../domain/usecases/edit_order_status_usecase.dart';
import '../../../bloc/delivery_list/delivery_list_bloc.dart';
import '../../../bloc/edit_order_status/edit_order_status_bloc.dart';
import '../../../bloc/picker_list/picker_list_bloc.dart';
import '../../../bloc/update_order/update_order_bloc.dart';
import '../../../bloc/update_order_status/update_order_status_bloc.dart';
import '../../widgte/dailog/alert _dailog.dart';

class UpdateOrderPosScreen extends StatefulWidget {
  final  Map<String, dynamic> value;

  const UpdateOrderPosScreen( this.value, {Key? key,/*required this.params*/}) : super(key: key);

  @override
  State<UpdateOrderPosScreen> createState() => _UpdateOrderPosScreenState();
}

class _UpdateOrderPosScreenState extends State<UpdateOrderPosScreen> {
  String dropdownValue = '';
  String dropdowndeliveryValue = '';
  var OrdersArray = [];
  bool is_order_ready = false;
  String   prepare =  "PREPARING";
  String orderId ="";
  List preparedItem = [];
  TextEditingController _controller = TextEditingController();
  int _groupValue = -1;
  final _form = GlobalKey<FormState>();
  TextEditingController _ReceiverText = TextEditingController();
  final usbprinter = UsbPrinter(FlutterUsbPrinter());
  Map<String, dynamic>? dropdownvalue;
  @override
  void initState() {
    // TODO: implement initState
    debugPrint("widget.value['oid']....hihihi...."+widget.value['oid'].toString());
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
            return StatefulBuilder(
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
                                                        .w500),),
                                              SizedBox(height: 5,),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                height: 30,
                                                width: (LayoutView(context).isMobile)?120:150,
                                                color: Colors.black12,
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
                                                        .w500),),
                                              SizedBox(height: 5,),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                height: 30,
                                                width: (LayoutView(context).isMobile)?120:150,
                                                color: Colors.black12,
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
                                                        .w500),),
                                              SizedBox(height: 5,),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                height: 30,
                                                width: 150,
                                                color: Colors.black12,
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
                                                        .w500),),
                                              SizedBox(height: 5,),
                                              Container(
                                                height: 30,
                                                width: 150,
                                                color: Colors.black12,
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
                                          }
                                        },
                                        child: Center(
                                          child: SizedBox(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width ,
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
                                                  Alert().showallert(context,messege: S.of(context).cant_edit_more +e.weight!);
                                                }else if(_groupValue == 0 ){
                                                  Alert().showallert(context,messege: S.of(context).please_enter_issue);
                                                }else{
                                                  Navigator.pop(context);
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
                                                          .w500),),
                                                SizedBox(height: 5,),
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  height: 30,
                                                  width: (LayoutView(context).isMobile)?120:150,
                                                  color: Colors.black12,
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
                                                          .w500),),
                                                SizedBox(height: 5,),
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  height: 30,
                                                  width: (LayoutView(context).isMobile)?120:150,
                                                  color: Colors.black12,
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
                                                          .w500),),
                                                SizedBox(height: 5,),
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  height: 30,
                                                  width: 150,
                                                  color: Colors.black12,
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
                                                          .w500),),
                                                SizedBox(height: 5,),
                                                Container(
                                                  height: 30,
                                                  width: 150,
                                                  color: Colors.black12,
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
                                                    Navigator.pop(context);
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

    return BlocBuilder<UpdateOrderBloc, UpdateOrderState>(
        builder: (context, state1) {
          if(state1 is UpdateOrderLoading){
            return const Center(child: SizedBox(height: 40,child: CircularProgressIndicator(),));
          }

          if(state1 is UpdateOrderSucsess<List<UpdateOrderModel>>) {
            OrdersArray = state1.data.first.items ?? [];

            return
              Scaffold(
                  bottomNavigationBar: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      LayoutView (context).isMobile? SizedBox.shrink(): Padding(
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
                          (state1.data.first.orderStatus == S.of(context).READY)?
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
                        (state1.data.first.orderStatus == S.of(context).COMPLETED)?SizedBox(width: 200,):
                          (state1.data.first.orderStatus == S.of(context).PICK || state1.data.first.orderStatus == S.of(context).RECEIVED )?
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
                                      if(state1.data.first.orderStatus == S.of(context).RECEIVED){
                                        print("state1.data.first.orderStatus....abc1"+state1.data.first.items!.length.toString()+"...."+preparedItem.length.toString());
                                        if(state1.data.first.items!.length == preparedItem.length){
                                          print("Prepared......");
                                          BlocProvider.of<UpdateOrderStatusBloc>(
                                              context).add(OrderReady(
                                              sl<SharedPreferences>().getString(
                                                  Prefrence.BRANCH) ?? '',
                                              widget.value['oid'], S.of(context).READY.toLowerCase(), "", ""));
                                          Alert().showSuccess(context,
                                              messege: S.of(context).order_updated_successfully);
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
                                            widget.value['oid'], S.of(context).READY.toLowerCase(), "", ""));
                                        Alert().showSuccess(context,
                                            messege: S.of(context).order_updated_successfully);
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
                                    width:(LayoutView (context).isMobile && state1.data.first.orderStatus != S.of(context).READY)? MediaQuery.of(context).size.width :MediaQuery.of(context).size.width/2,
                                    height:45,
                                    padding: EdgeInsets.only(left: 8,right: 8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: MaterialButton(onPressed:  (){
                                      if(state1.data.first.orderStatus == S.of(context).READY){

                                        (deliveryValueController.value.value == "")?
                                        Alert().showallert(context,
                                            messege: S.of(context).there_is_no_delivery,onpresscancel: (){},onpress: (){})
                                       : BlocProvider.of<UpdateOrderStatusBloc>(context).add(AssainDelevery(sl<SharedPreferences>().getString(Prefrence.BRANCH)??'',widget.value['oid'],S.of(context).DISPATCHED.toLowerCase(),deliveryValueController.value.value));

                                      }else if(state1.data.first.orderStatus ==  S.of(context).DISPATCHED){
                                        BlocProvider.of<UpdateOrderStatusBloc>(
                                            context).add(OrderReady(
                                            sl<SharedPreferences>().getString(
                                                Prefrence.BRANCH) ?? '',
                                            widget.value['oid'], S.of(context).delivered, "", ""));
                                      }
                                      else if( state1.data.first.orderStatus == S.of(context).delivered.toUpperCase()){
                                        BlocProvider.of<UpdateOrderStatusBloc>(
                                            context).add(OrderReady(
                                            sl<SharedPreferences>().getString(
                                                Prefrence.BRANCH) ?? '',
                                            widget.value['oid'], S.of(context).COMPLETED.toLowerCase(), "", ""));
                                      }else{

                                      }
                                    },
                                      color: (state1.data.first.orderStatus == S.of(context).READY || state1.data.first.orderStatus == S.of(context).DISPATCHED|| state1.data.first.orderStatus == S.of(context).delivered.toUpperCase() ) ?Colors.green :Colors.grey,
                                      child: Text( (state1.data.first.orderStatus == S.of(context).READY)? S.of(context).assign_to_delivery_partner:(state1.data.first.orderStatus == S.of(context).DISPATCHED)?S.of(context).delivered.toUpperCase():( state1.data.first.orderStatus == S.of(context).delivered.toUpperCase())?S.of(context).order_completed:S.of(context).order_ready,style: TextStyle(color:Colors.white,fontSize:15,fontWeight: FontWeight.bold),),
                                    ),
                                  ),
                                ),
                              ]
                          )
                        ],
                      ),
                      SizedBox(height: 85,)
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Spacer(),
                            LayoutView (context).isMobile?
                            (state1.data.first.orderStatus == S.of(context).RECEIVED)? BlocBuilder<PickerListBloc, PickerListState>(
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
                                                            BlocProvider.of<UpdateOrderStatusBloc>(context).add(AssainPicker(sl<SharedPreferences>().getString(Prefrence.BRANCH)??'',widget.value['oid'],S.of(context).PICK.toLowerCase(),newValue));

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
                                            Row(
                                                children: [
                                                  Text(S.of(context).order +state1.data.first.id!,
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight
                                                            .bold),),
                                                  Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.red
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets
                                                            .only(
                                                            left: 8.0,
                                                            right: 8.0),
                                                        child: state1.data.first.orderStatus! == S.of(context).RECEIVED?
                                                        Text(
                                                          S.of(context).preparing,
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.bold),
                                                        )
                                                        :Text(state1.data.first.orderStatus!,
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 8),),
                                                      )
                                                  )
                                                ]
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, bottom: 8.0),
                                              child: Text(state1.data.first.itemsCount.toString() + S.of(context).Item +". ₹"+ state1.data.first.orderAmount!,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 9),),
                                            )
                                          ]
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(state1.data.first.fixtime!,
                                            style: TextStyle(color: Colors.grey,
                                                fontSize: Vx.isWeb? 12:10,
                                                fontWeight: FontWeight.bold),),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, bottom: 8.0),
                                            child: Row(
                                              children: [
                                                SizedBox(width: 12,
                                                    child: Image.asset(
                                                        'assets/icons/card.png')),
                                                Text(' ₹${state1.data.first
                                                    .orderAmount} (${state1.data
                                                    .first.paymentType})',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12,
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
                                          (Vx.isWeb)?
                                          GestureDetector(
                                            onTap: (){
                                              debugPrint("kiki...1.."+state1.data.length.toString());
                                              usbprinter.printPosOrder(state1.data[0]);
                                            },
                                            child: Row(children: [
                                              Icon(Icons.print_outlined,
                                                color: Colors.grey, size: 17,),
                                              Text(S.of(context).Print, style: TextStyle(
                                                  color: Colors.grey, fontSize: 11))
                                            ]),
                                          ):
                                          FutureBuilder<List<Map<String, dynamic>>>(
                                            future: usbprinter.getDevicelist(),
                                            builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                                              debugPrint("kjhgfkjhg..."+snapshot.data.toString());
                                              if(snapshot.data!=null&&snapshot.data!.isNotEmpty){
                                                dropdownvalue = snapshot.data!.first;
                                                debugPrint("kjhgfkjhg..."+snapshot.data!.first.toString());
                                                usbprinter.connect(int.parse(dropdownvalue!["vendorId"]),int.parse(dropdownvalue!["productId"]));
                                                return GestureDetector(
                                                  onTap: (){
                                                    debugPrint("kiki..."+state1.data.length.toString());
                                                    usbprinter.printPosOrder(state1.data[0]);
                                                  },
                                                  child: Column(children: [
                                                    Icon(Icons.print_outlined,
                                                      color: Colors.grey, size: 15,),
                                                    Text(S.of(context).Print, style: TextStyle(
                                                        color: Colors.grey, fontSize: 10))
                                                  ]),
                                                );
                                              }else{
                                                return GestureDetector(onTap: (){
                                                  usbprinter.getDevicelist();
                                                },child: const Text(""));
                                              }
                                            },
                                          ),
                                          LayoutView(context).isMobile?
                                              SizedBox.shrink()
                                          :(state1.data.first.orderStatus == S.of(context).RECEIVED)? BlocBuilder<PickerListBloc, PickerListState>(
                                              builder: (context, state) {

                                                if(state is PickerListSucsess<List<PickerListModel>>) {

                                                  // ignore: unrelated_type_equality_checks
                                                  return (state.data.isNotEmpty && (state.data
                                                      .map((e) =>
                                                  e.isActive! == "1")).isNotEmpty )?ValueListenableBuilder<String>(
                                                      valueListenable: pickerValueController.value,
                                                      builder: (BuildContext context, String pickerlistmodel, widget1)
                                                      {
                                                        pickerValueController.value.value = state.data.first.firstName!;
                                                        return Padding(
                                                          padding: const EdgeInsets
                                                              .only(
                                                              top: 8.0,
                                                              bottom: 8.0),
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
                                                                          BlocProvider.of<UpdateOrderStatusBloc>(context).add(AssainPicker(sl<SharedPreferences>().getString(Prefrence.BRANCH)??'',widget.value['oid'],S.of(context).PICK.toLowerCase(),newValue));

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
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.0),
                                    border:
                                    Border.all(color: Colors.grey.shade400)),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child:  LayoutView(context).isMobile?
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
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
                                        ],
                                      ),

                                      Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  3,
                                              child: Text(e.itemName!),
                                            ),
                                            Text(e.itemType == "1" ?e.weight! : e.quantity!),
                                            Text(IConstants.currencyFormat+"${e.subTotal}"),
                                          ]),

                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        (state1.data.first.orderStatus! == S.of(context).COMPLETED || state1.data.first.orderStatus! == S.of(context).READY || state1.data.first.orderStatus! == S.of(context).DISPATCHED || state1.data.first.orderStatus! == S.of(context).PICK )?SizedBox(width: 30,) :
                                        GestureDetector(
                                          onTap: () {
                                             showmeditpopup(e);

                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.edit_outlined,
                                                color: Colors.green,
                                                size: 14,
                                              ),
                                              SizedBox(width: 5,),
                                              Text(
                                                S.of(context).edit,
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        (state1.data.first.orderStatus! == S.of(context).PICK )
                                            ? SizedBox(width: 50,): (state1.data.first.orderStatus! == S.of(context).RECEIVED)?
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
                                    ),

                                    ],
                                  )
                                      :Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                           // margin: EdgeInsets.only(top: 10.0, bottom: 8.0),
                                            child: CachedNetworkImage(
                                              imageUrl: e.image!,
                                              errorWidget: (context, url, error) => Image.asset(
                                                "assets/images/default_product.png",
                                                width: 80,
                                                height: 60,
                                              ),
                                              placeholder: (context, url) => Image.asset(
                                                "assets/images/default_product.png",
                                                width:80,
                                                height: 60,
                                              ),
                                              width:80,
                                              height:60,
                                              //  fit: BoxFit.fill,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  3,
                                              child: Text(e.itemName!),
                                            ),
                                            Text(e.itemType == "1" ?e.weight! : e.quantity!)
                                          ]),
                                      Text("₹${e.subTotal}"),
                                      (state1.data.first.orderStatus! == S.of(context).COMPLETED || state1.data.first.orderStatus! == S.of(context).READY || state1.data.first.orderStatus! == S.of(context).DISPATCHED || state1.data.first.orderStatus! == S.of(context).PICK )?SizedBox(width: 30,) :
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
                                      (state1.data.first.orderStatus! == S.of(context).PICK )
                                          ? SizedBox(width: 50,): (state1.data.first.orderStatus! == S.of(context).RECEIVED)?
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
                                        color: /*(e.colorCheck == true)
                                            ? Colors.green
                                            :*/ Colors.red,
                                        child: Text(
                                          e.prepare!,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                          :SizedBox.shrink()
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
                                )),
                          );
                        }),

                      ],),
                  )

              );
          }
          else{
            return SizedBox.shrink();
          }
        });
  }
}
