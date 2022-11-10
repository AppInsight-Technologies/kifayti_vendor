import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/util/presentation/constants/ic_constants.dart';

import '../../../../../core/util/presentation/styles/box_property.dart';
import '../../../../../core/util/presentation/styles/screen_size_rario.dart';
import '../../bloc/cart/cart_bloc.dart';

class VariationRadioButton extends StatefulWidget {
  final BoxStyle? style;
  final PageController controller;
  int currentindex ;
  VariationRadioButton(this.controller,{Key? key, this.style, required this.tabs, required this.currentindex}) : super(key: key);
  final List<VartationData> tabs ;

  @override
  State<VariationRadioButton> createState() => _VariationRadioButtonState();
}
class VartationData{
  bool? active;
  String var_name;
  String v_id;
  Function onTap;
  VartationData({this.active=false, required this.var_name, this.description, this.balance, required this.v_id,required this.onTap});

  String? description;
  double? balance;
}
class _VariationRadioButtonState extends State<VariationRadioButton> {
  int selectedRadio = 0;
  double fontSize = 16;
  int get currentindex => widget.currentindex;

  set currentindex(index) => widget.currentindex = index;
  List<Widget> get listTab=>widget.tabs.map((tab) => GestureDetector(
    onTap: ()=>tab.onTap(),
    child:  Padding(
      padding: const EdgeInsets.only(top:8.0, bottom:8.0),
      child: Container(
        // width: LayoutView(context).isMobile?MediaQuery.of(context).size.width/2:MediaQuery.of(context).size.width/4,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.green),
            color: currentindex == widget.tabs.indexOf(tab)?Colors.green.shade50:Colors.transparent
          //border: Border.all(color:Colors.grey)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(tab.var_name, overflow: TextOverflow.ellipsis,style: TextStyle(color: currentindex == widget.tabs.indexOf(tab)?Colors.green:Colors.black54,fontSize:fontSize,fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(IConstants.currencyFormat+"${tab.balance}",style: TextStyle(color:currentindex == widget.tabs.indexOf(tab)?Colors.green: Colors.black54,fontSize:fontSize,fontWeight: FontWeight.bold)),
                      const SizedBox(width:5),
                      if(tab.balance.toString().trim()!= tab.description.toString().trim())
                        Text(IConstants.currencyFormat+"${tab.description}",style: TextStyle(color: currentindex == widget.tabs.indexOf(tab)?Colors.green:Colors.black54,fontSize:fontSize-2,fontWeight: FontWeight.bold,decoration: TextDecoration.lineThrough, decorationColor: Colors.grey)),
                    ],
                  )
                ],
              ),
              // Column(
              //    children: [
              //      Radio<int>(
              //        activeColor: Colors.black54,
              //        value: currentindex,
              //        groupValue:selectedRadio,
              //        onChanged: (val) {
              //          setState(() {
              //            selectedRadio = val as int;
              //          });
              //        },
              //      ),
              //    ],
              //  )
            ],
          ),
        ),
      ),
    ),
  )).toList();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.style!=null?widget.style!.width:null,
        height:widget.style!=null?widget.style!.height:null,
        color: Colors.white,child:Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment:CrossAxisAlignment.start,children: listTab,));
  }
}
