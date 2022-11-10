import 'package:flutter/material.dart';

class ApplyPromocodeText extends StatelessWidget {
  TextEditingController _textcontroller = TextEditingController(text: "");
  Function(String) onCodeSumit;
  Function() onCancelPromocode;
  String ispromocodeenable;
   ApplyPromocodeText(this.ispromocodeenable, {Key? key,required this.onCodeSumit,required this.onCancelPromocode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("ispromocodeenable..."+ispromocodeenable.toString());
    return SizedBox(
      height: 60,
      // width: 200,
      child: Card(
        //  elevation: 3,
          child: Padding(
            padding: const EdgeInsets.only(left:10.0,bottom: 10.0,top:10.0,),
            child: Row(
            mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/icons/promo.png"),
                Expanded(
                  child: SizedBox(
                    height: 60,
                     width: 150,
                    child: ispromocodeenable==""?TextField(controller: _textcontroller,
                        onSubmitted: (text)=>onCodeSumit(text),decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Apply Promo Code",

                        )):Text(ispromocodeenable),
                  ),
                ),
                ispromocodeenable==""?
                GestureDetector(onTap: ()=>onCodeSumit(_textcontroller.value.text),child: const Icon(Icons.keyboard_arrow_right,color: Colors.green,size: 20,)):
                GestureDetector(onTap: ()=>onCancelPromocode(),child: const Icon(Icons.close,color: Colors.green,size: 20,))
              ],
            ),
          )
      ),
    );
  }
}
