/*
import 'package:flutter/material.dart';
import '../..//feautures/grocbay_pos/presentation/view/widgte/custom_stepper.dart';

class CheckoutList extends StatefulWidget {
  final List? oder_array;
  final Object? list_icon;
  final bool is_orderlist;
  final GlobalKey<ScaffoldState>? skey;
  const CheckoutList({Key? Key,this.oder_array,this.list_icon,required this.is_orderlist,this.skey}) : super(key: Key);

  @override
  _CheckoutListState createState() => _CheckoutListState();
}

class _CheckoutListState extends State<CheckoutList> {

  List<String> array1 = ["Orange-Impored","Apple-Washington","Mango-Alphonso"];
  int selectedRadio=0;
  @override
  void initState() {
    super.initState();
    textcontroller.text = widget.product.quantity.toString()+"${widget.product.unit}";
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  deleteItem(int index){
    setState(() {
      print("inside delete item"+ index.toString());
      array1 = List.from(array1)
        ..removeAt(index);
    });
    print("array after deleting"+ array1.toList().toString());
  }
  openDrawer(){
    print("inside opendrawer");
    widget.skey!.currentState!.openEndDrawer();
  }
  @override
  Widget build(BuildContext context) {

//print("is_orderlist"+widget.is_orderlist.toString());
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){
        openDrawer();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        array1.map((i) =>  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(

            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: (array1.indexOf(i) % 2 == 0) ? Colors.grey[200] : Colors.white,
                border: Border.all(color: widget.is_orderlist?Colors.transparent:Colors.grey)
              //border: Border.all(color:Colors.grey)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((array1.indexOf(i)+1).toString()+"."+i.toString(),style: TextStyle(color: Colors.black,fontSize:10,fontWeight: FontWeight.bold)),
                      Text("1 Kg",style: TextStyle(color: widget.is_orderlist?Colors.grey:Colors.grey,fontSize:10,fontWeight: FontWeight.bold)),
                    ],
                  ),
                   Column(
                    children: [
                      CustomeStepper(fillcolor: Colors.green,textColor: Colors.white,textCyan: Colors.green, steper: (int ) {

                      }, onsubmit: (int ) {  }, textcontroller: null,)
                    ],
                  ),
                  // Column(
                  //   children: [
                  //     Text("1 Kg",style: TextStyle(color: widget.is_orderlist?Colors.black:Colors.grey,fontSize:10,fontWeight: FontWeight.bold)),
                  //   ],
                  // ),
                  Column(
                    children: [
                      Text("₹120",style: TextStyle(color: Colors.black,fontSize:10,fontWeight: FontWeight.bold)),
                    ],
                  ),
                  GestureDetector(onTap:()
                  {
                    deleteItem(array1.indexOf(i));
                  },
                    child: Column(
                      children: [


                        if(widget.list_icon is Image)
                          widget.list_icon as Image,


                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )).toList(),

      ),
    );
  }


}
*/
