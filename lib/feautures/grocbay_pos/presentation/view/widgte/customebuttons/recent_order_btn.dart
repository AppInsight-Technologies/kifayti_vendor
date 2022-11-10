import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
// import '../..//generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../injection_container.dart';
class RecentOrderButton extends StatelessWidget {
  final Function(int) onTap;
  const RecentOrderButton({Key? key,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: StatefulBuilder(
          builder: (context,setState) {
            return GestureDetector(
              onTap: (){
                onTap(5);
              },
              child: Container(
                height: 40,
                padding: EdgeInsets.only(left: 10,right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.green),
                    color: Color(0xffF5F5F5)
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text("Recent Orders", style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),),
                      SizedBox(width: 10,),
                      Image.asset("assets/icons/recent.png",height: 15,width: 15,color: Colors.green,)
                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
