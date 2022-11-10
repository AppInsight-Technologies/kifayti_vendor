import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import '../../../../../core/util/presentation/controller/onpress_controller.dart';

import '../../../../../core/util/presentation/constants/ic_constants.dart';

enum StepperAlignment{
  Vertical,Horizontal
}

enum Steper{
  Increment,Decremet
}
class CustomeStepper extends StatefulWidget {

  Color? fillcolor;
  Color? textColor;
  Color? textCyan;
  Color? borderColor;
  double quantity;
  Function(double) steper;
  void Function(double) onsubmit;
  void Function(double) ontextchange;
  double? steppersize;
  double? mutaionunit;
  SteppersType? steppertype;
  String unit;
  TextEditingController textcontroller;
  String? price;

  CustomeStepper({Key? key,this.unit = "",this.steppersize,required this.ontextchange,required this.textcontroller,required this.onsubmit,this.fillcolor =Colors.transparent,this.textColor=Colors.grey, this.textCyan=Colors.grey,this.borderColor=Colors.transparent ,this.quantity = 1,required this.steper, this.mutaionunit = 1, this.steppertype = SteppersType.multy,this.price}) : super(key: key);

  @override
  State<CustomeStepper> createState() => _CustomeStepperState();
}

class _CustomeStepperState extends State<CustomeStepper>{


  incrementQuantity(double q){
    q = q+0.0;
    widget.textcontroller.value = TextEditingValue(text: (q+(widget.mutaionunit as num).toDouble()).toString());
    print("inrement by ${widget.mutaionunit}");
    widget.steper(q+(widget.mutaionunit as num));
  }

  decrementQuantity(double q){
    q = q+0.0;
    if(q <= 1){
      return;
    }else{
      widget.textcontroller.value = TextEditingValue(text: (q-(widget.mutaionunit as num).toDouble()).toString());
      widget.steper(q-(widget.mutaionunit as num));
      print("- clicked, qty: ${q-(widget.mutaionunit as num).toDouble()}");

    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      // height: 60,
      child: widget.steppertype != SteppersType.sku?SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(

              child: GestureDetector(
                onTap: (){
                  decrementQuantity(widget.quantity);
                },
                child: Container(
                    alignment: Alignment.center,
                    decoration:
                    BoxDecoration(
                      color:widget.fillcolor,
                      border: Border.all(color:widget.borderColor!),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5)),
                      //color: Colors.deepPurple,
                    ),
                    child:Text("-",style:TextStyle(color: widget.textColor,fontSize: 15))
                ),
              ),
            ),
            if(widget.steppertype != SteppersType.sku)
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color:Colors.white,
                      border: Border.all(color:Colors.green)
                  ),
                  child: Text((widget.quantity).toString()/*+" ${widget.unit}"*/,style:const TextStyle(color: Colors.green  ,fontSize: 15)),
                ),
              ),
            // if(widget.steppertype == SteppersType.sku)
            //   Expanded(
            //     child: Container(
            //       alignment: Alignment.center,
            //       decoration: BoxDecoration(
            //           color:Colors.white,
            //           border: Border.all(color:widget.borderColor!)
            //       ),
            //       child: TextField(focusNode:FocusNode(),autofocus: true,controller: widget.textcontroller,textAlign: TextAlign.center, keyboardType:TextInputType.numberWithOptions(decimal: true),
            //           onChanged: (value)=> widget.steper(double.parse(value)),
            //           inputFormatters: <TextInputFormatter>[
            //             FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
            //           ],style: TextStyle(color: widget.textCyan,fontSize: widget.steppersize),onSubmitted:(value)=> widget.onsubmit(double.parse(value))),
            //     ),
            //   ),
            Expanded(
              child: GestureDetector(
                onTap: (){
                  incrementQuantity(widget.quantity);
                },
                child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color:widget.fillcolor,
                        border: Border.all(color:widget.borderColor!),
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5))
                    ),
                    child:Text("+",style:TextStyle(color:widget.textColor,fontSize:15))
                ),
              ),
            ),
          ],
        ),
      ):Container(

        decoration: BoxDecoration(
          color: Colors.green,
          border: Border.all(color:Color(0xFFF5F5F5)),
          borderRadius:
          new BorderRadius.only(
            topLeft:
            const Radius.circular(10.0),
            bottomLeft:
            const Radius.circular(10.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if(widget.steppertype == SteppersType.sku)
              // Expanded(
              //   child: Container(
              //     alignment: Alignment.topCenter,
              //     decoration: BoxDecoration(
              //         color:Colors.white,
              //         border: Border.all(color:Colors.grey.shade300),
              //     ),
              //     child: TextFormField(/*cursorHeight: 0,cursorWidth: 0,*/
              //         decoration: const InputDecoration(
              //       labelText: '',
              //       border: InputBorder.none,
              //     ),autofocus: true,controller: widget.textcontroller,
              //         textAlign: TextAlign.center, keyboardType:const TextInputType.numberWithOptions(decimal: true),
              //         onChanged: (value) {
              //           widget.steper(double.parse(value.trim()));
              //         },
              //         inputFormatters: <TextInputFormatter>[
              //           FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,4}'))
              //         ],style: TextStyle(color: Colors.green,fontSize: widget.steppersize),
              //         onFieldSubmitted:(value)=> widget.onsubmit(double.parse(value))),
              //   ),
              // ),
            Expanded(
                child: Container(
                  // color: Colors.white,
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color:Color(0xFFF5F5F5)),
                    borderRadius:
                    new BorderRadius.only(
                      topLeft:
                      const Radius.circular(10.0),
                      bottomLeft:
                      const Radius.circular(10.0),
                    ),
                  ),
                  child: TextFormField(
                    controller: widget.textcontroller,
                    // focusNode: focus,
                    autofocus: true,
                    cursorColor: Colors.green,
                    decoration:  InputDecoration (
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,),

                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      widget.steper(double.parse(value.trim()));
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,4}'))
                    ],style: TextStyle(color: Colors.green,fontSize: widget.steppersize,height: 1,),
                    onFieldSubmitted: (value) => widget.onsubmit(double.parse(value),
                /*
                    decoration:  InputDecoration(
                        hintStyle: const TextStyle(fontSize: 15,color: Colors.green),
                        suffixIcon: style.iconalign == IconAlign.ending ?const Icon(Icons.search,size: 20,):null,
                        prefixIcon:  style.iconalign == IconAlign.leading ?const Icon(Icons.search,size: 20,):null,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: style.contentPadding,
                        hintText: hintText),
                  ),*/
                ),
                  ),
                ),
              ),
            Expanded(
              child: GestureDetector(
                onTap: (){
                  // incrementQuantity(widget.quantity);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      Text(IConstants.currencyFormat + widget.price!,style:const TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize:25)),
                      Text("/"+"${widget.unit.toUpperCase()}",style:const TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize:25)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

}
enum SteppersType{
  sku,multy
}

class StepperController extends ValueListnabelController<StepperControllerValue>{
  StepperController(StepperControllerValue val) : super(val);
  incriment(){

  }
  decriment(){

  }
  clear(){

  }
}

class StepperControllerValue {

}