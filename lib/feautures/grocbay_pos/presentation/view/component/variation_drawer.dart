import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../../core/util/calculations/validations.dart';
import '../../../../../core/util/presentation/controller/global_focus.dart';
import '../../../../../core/util/presentation/controller/onpress_controller.dart';
import '../../../../../core/util/presentation/styles/screen_size_rario.dart';
import '../../../domain/entities/fetch_category_product.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../widgte/custom_stepper.dart';
import '../widgte/variation_radio_button.dart';
import 'checkout_orderlist.dart';
class VariationDialog extends StatefulWidget {
  final FetchCategoryProduct  product;
  final BuildContext context;

  // final ProductValueController _conpressproduct;
  // final CheckoutValueController _checkoutval;
  const VariationDialog(this.product, this.context,  {Key? key}) : super(key: key);
  @override
  _VariationDialogState createState() => _VariationDialogState();
}

class _VariationDialogState extends State<VariationDialog> {
  final PageController? _controler = PageController(initialPage: 0);
  double quantity = 0;
  int _index = 0;
  bool keyupdate =true;
  List<VartationData> tabs = [];
  double q_unit = 1;
  late TextEditingController textcontroller = TextEditingController(text: '0');

  @override
  void initState() {
    // TODO: implement initState
    textcontroller.text = '0';
    q_unit = double.parse(widget.product.increament??"1");
    tabs = (widget.product.priceVariation?.map((e) => VartationData(v_id: e.id!,var_name: "${e.variationName!} ${e.unit}",description:e.mrp.toString(),balance: double.parse(((checkoutValueController.value.value.is_membered_user==null||checkoutValueController.value.value.is_membered_user=="0")?e.price:(e.membershipPrice! > 0) ? e.membershipPrice : e.price).toString()), onTap: (){
      Navigator.pop(widget.context);
      if(quantity>0.0){
        BlocProvider.of<CartItemBloc>(widget.context).add(CartAdd(u_id: checkoutValueController.value.value.apiKey??"0",data: widget.product,varid: e.id.toString(),quantity: quantity,membered_user: checkoutValueController.value.value.is_membered_user??"1", idtype: IDType.variation));
      }
    }))??[]).toList();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    // FocusN.f_quantity_variation.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // debugPrint("checkoutvallistner"+(checkoutValueController.value.value.total_paybleamount).toString());
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    debugPrint("here");
    debugPrint("conpressproduct"+widget.product.regularPrice.toString());
    return KeyboardListener(
      focusNode: FocusN.f_quantity_variation,
      autofocus: widget.product.type=='0',
      onKeyEvent: (event){
        if (event is KeyDownEvent) {
          debugPrint("typr: ${widget.product.type}");
          if(widget.product.type=='0'){
            if(Validate().isnumerical(event.logicalKey.keyLabel)){
              final qty = int.parse(event.logicalKey.keyLabel);
              if(quantity>1||!keyupdate) {
                setState(() =>quantity = quantity *10+qty);
              }else{
                keyupdate = false;
                setState(() =>quantity = (qty).toDouble());
              }
            }
            if (event.logicalKey == LogicalKeyboardKey.backspace) {
              setState(() =>quantity = ((quantity ~/10)).toDouble());
            }
            if (event.logicalKey == LogicalKeyboardKey.delete) {
              setState(() => quantity = 0);
            }
            if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
              debugPrint("event");
              if(_index>0) {
                setState(() => --_index);
              }
              // setState(()=>index++);
            }
            else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
              debugPrint("event");
              if(_index<widget.product.priceVariation!.length-1) {
                setState(() => ++_index);
              }
            }
            if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
              debugPrint("event");
              setState(()=>quantity =quantity+q_unit);
            }
            else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
              debugPrint("event");
              if(quantity>1){
                setState(() => quantity =quantity-q_unit);
              }
            }
          }else{

            if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
              debugPrint("event");
              setState(()=>quantity =quantity+q_unit);
              textcontroller.value = TextEditingValue(text: quantity.toString());
            }
           /* else if (event.logicalKey == LogicalKeyboardKey.backspace) {
              debugPrint("event");
              setState(() =>quantity = (0));
                textcontroller.value = TextEditingValue(text: quantity.toString());
            }*/ else if  (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
              debugPrint("event");
              if(quantity>1){
                setState(() => quantity =quantity-q_unit);
                textcontroller.value = TextEditingValue(text: quantity.toString());

              }
            }
          }

          if (event.logicalKey == LogicalKeyboardKey.enter) {
            print("enter presed in drawer" );

            if(quantity>0.0) {
              BlocProvider.of<CartItemBloc>(context).add(CartAdd(
                  u_id: checkoutValueController.value.value.apiKey.toString(),
                  data: widget.product,
                  varid: (widget.product.priceVariation?[_index].id ??
                          widget.product.id)
                      .toString(),
                  quantity: quantity,
                  membered_user:
                      checkoutValueController.value.value.is_membered_user ??
                          "0",
                  idtype: IDType.variation));
              Navigator.pop(context);
            }

          }
        } else {
          return;
        }
      },
      child: StatefulBuilder(
        builder: (context,setState) {
          return Container(
            color: Colors.white,
            width:LayoutView(context).isMobile?MediaQuery.of(context).size.width/1.5:MediaQuery.of(context).size.width/4,
            child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Container(
                          padding: const EdgeInsets.all(8),
                          color:Colors.white,
                          width:LayoutView(context).isMobile?MediaQuery.of(context).size.width/1.5:MediaQuery.of(context).size.width/4,
                          child:Center(child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(widget.product.itemName!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.green,fontSize:16)),
                          )),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),

                          width: LayoutView(context).isMobile?MediaQuery.of(context).size.width/1.5:MediaQuery.of(context).size.width/4,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // const Padding(
                              //   padding: EdgeInsets.all(8.0),
                              //   //child: Text("Quantity",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold)),
                              // ),
                              //stepper needs to be added
                              ValueListenableBuilder<CheckoutModel>(
                                  builder: (BuildContext context, CheckoutModel checkoutModel, widget1) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(width:LayoutView(context).isMobile?MediaQuery.of(context).size.width/1.5:MediaQuery.of(context).size.width/4,
                                        child: CustomeStepper(unit:widget.product.priceVariation?[_index].unit?? widget.product.unit??"",steppersize:25 ,fillcolor: Colors.green,textColor: Colors.white,quantity: quantity, steppertype: widget.product.type == "1"? SteppersType.sku:SteppersType.multy,mutaionunit: double.parse(widget.product.increament??"1"),borderColor: Colors.grey,
                                          steper: (int ) {
                                            setState(() {
                                              quantity=int;
                                            });
                                          }, onsubmit: (int ) {
                                            if(quantity>0.0){
                                          BlocProvider.of<CartItemBloc>(context).add(CartAdd(
                                                  u_id: checkoutValueController
                                                      .value.value.apiKey
                                                      .toString(),
                                                  data: widget.product,
                                                  varid: (widget
                                                              .product
                                                              .priceVariation?[_index]
                                                              .id ??
                                                          widget.product.id)
                                                      .toString(),
                                                  quantity: int,
                                                  membered_user: checkoutValueController
                                                      .value.value.is_membered_user??"0",
                                                  idtype: IDType.variation));
                                          // Navigator.pop(context);
                                        }
                                      }, textcontroller: textcontroller, ontextchange: (double ) {  }, price:
                                            ((checkoutModel.is_membered_user==null || checkoutModel.is_membered_user=="0")?(widget
                                                .product.priceVariation?[_index].price??widget.product.price):
                                            ((widget.product.priceVariation?[_index].membershipPrice??widget.product.membershipPrice)! > 0) ?
                                            (widget.product.priceVariation?[_index].membershipPrice??widget
                                                .product
                                                .membershipPrice)
                                                : (widget.product.priceVariation?[_index].price??widget.product.price)).toString()
                                        )),
                                  );
                                }, valueListenable: checkoutValueController.value,
                              ),
                              if(tabs.isNotEmpty)
                                const Padding(
                                  padding: EdgeInsets.only(top:10.0,left: 10.0),
                                  child: Text("Weight",style: TextStyle(color: Colors.grey,fontSize: 14)),
                                ),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(width: LayoutView(context).isMobile?MediaQuery.of(context).size.width/1.5:MediaQuery.of(context).size.width/4,
                                    child:VariationRadioButton(_controler!,currentindex:_index,tabs: tabs),
                                  )
                              ),
                              if(tabs.isEmpty)
                                Row (
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MaterialButton(color: Theme.of(context).primaryColor,height: 60,onPressed:(){
                                      if(quantity>0.0) {
                                      BlocProvider.of<CartItemBloc>(context).add(CartAdd(
                                              u_id: checkoutValueController
                                                  .value.value.apiKey
                                                  .toString(),
                                              data: widget.product,
                                              varid: (widget
                                                          .product
                                                          .priceVariation?[_index]
                                                          .id ??
                                                      widget.product.id)
                                                  .toString(),
                                              quantity: quantity,
                                              membered_user: checkoutValueController
                                                      .value
                                                      .value
                                                      .is_membered_user ??
                                                  "0",
                                              idtype: IDType.variation));
                                      Navigator.pop(context);
                                    }
                                  },child: const Text("Add To Cart",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),),
                                  ],
                                )
                            ],
                          ),
                        )
                      ]),
                ]
            ),

          );
        }
      ),
    );
  }
}