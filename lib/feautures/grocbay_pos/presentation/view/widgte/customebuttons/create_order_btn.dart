import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
// import '../..//generated/l10n.dart';
class CreateOrderButton extends StatelessWidget {
  final Function(int) onTap;
  const CreateOrderButton({Key? key,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(height: 5.h,onPressed: ()=>onTap(5),elevation: 5,padding: EdgeInsets.all(2.dp),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: BorderSide(color: Theme.of(context).primaryColor,width: 2)),child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,mainAxisSize: MainAxisSize.min,children:  [Icon(Icons.add,color: Theme.of(context).primaryColor,size: 20.sp),Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Create Order",style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w700,fontSize: 16.sp),),
          )],),
        ],
      ),
    ));
  }
}
