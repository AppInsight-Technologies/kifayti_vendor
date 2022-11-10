import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import '../..//core/util/calculations/cartcalculations.dart';

import '../../../../../core/util/calculations/cartcalculations.dart';
import '../../../../../core/util/presentation/styles/box_property.dart';
import '../../../../../core/util/presentation/styles/screen_size_rario.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../widgte/custom_stepper.dart';

class CartItemList extends StatefulWidget {
  final BoxStyle? style;
  final PageController controller;
  CartItemList(this.controller,{Key? key, this.style, required this.tabs}) : super(key: key);
  final List<CartItemData> tabs ;
  int selectedRadio=0;
  @override
  State<CartItemList> createState() => _VariationRadioButtonState();

}
class CartItemData{
  bool? active;
  String p_name;
  String p_id;
  String? v_name;
  double? balance;
  SteppersType steppr;
  double? quantity;
  String? u_id;
  Function(double) cartstepper;
  String? unit;
  CartItemData({this.active=false,this.steppr = SteppersType.multy,this.unit, required this.p_name, this.v_name, this.balance, required this.p_id,this.quantity =1,required this.cartstepper,this.u_id});

}
class _VariationRadioButtonState extends State<CartItemList> {
  final cal = new CartCalculationsState();
  int _currentindex = 0;
  late TextEditingController textcontroller = TextEditingController(text: '0');

  int get currentindex => _currentindex;

  set currentindex(index) => _currentindex = index;

  List<Widget> get listTab=>widget.tabs.map((tab)
  {
    textcontroller.text =tab.quantity.toString()+"${tab.unit}";
    final index =widget.tabs.indexWhere((element) => element.p_id == tab.p_id );
    return GestureDetector(
      onTap: () {
        setState(() {
          currentindex = widget.tabs
              .indexWhere((element) => element.p_id == tab.p_id);
        });
        widget.controller.jumpToPage(
          currentindex,
        );
      },
      child: Container(
        decoration: BoxDecoration(
            color: (index %2 ==0)
                ?   Color(0XFFFCFCFC)
                : Colors.white,
            border: Border.all(color: Colors.transparent)
          //border: Border.all(color:Colors.grey)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        (index + 1).toString() +
                            "." +
                            tab.p_name.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                    Text(tab.v_name.toString(),

                        style: const TextStyle(
                            color:  Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width/12,
                          child: CustomeStepper(
                            quantity: tab.quantity??0.0,
                            steppertype: tab.steppr,
                            fillcolor: Colors.green,
                            textColor: Colors.white,
                            unit: tab.unit!,
                            textCyan: Colors.green,
                            steper: (int ) =>tab.cartstepper(int), onsubmit: (int ) {  }, textcontroller: textcontroller, ontextchange: (double ) {  },

                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 5,),
                    Column(
                      children: [
                        Text("₹${cal.calculateTotalBalance(tab.quantity!,tab.balance!)}",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),

                    GestureDetector(
                      onTap: () {
                        // deleteItem(currentindex);
                        BlocProvider.of<CartItemBloc>(context).add(CartRemove(u_id: tab.u_id!,varid: tab.p_id));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Image.asset("assets/icons/deletecircle.png",height: 17,width: 17)
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }).toList();
  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.style!=null?widget.style!.width:null,
        height:widget.style!=null?widget.style!.height:null,
        color: Colors.white,child:Column(mainAxisAlignment: MainAxisAlignment.start,children: listTab,));
  }
}
