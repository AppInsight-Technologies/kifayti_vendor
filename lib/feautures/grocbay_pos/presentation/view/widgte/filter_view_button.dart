import 'package:flutter/material.dart';
// import '../..//generated/l10n.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(width: 100,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        // color: widget.tabs[currentindex].ic_name == tab.ic_name?Colors.green.shade50:Colors.white,
          border: Border.all(color:Colors.green)
      ),
      child: Row(children: [
        Text("All Sale",style: TextStyle(color:Colors.green,fontSize: 12),),
        Spacer(),
        Divider(
          thickness: 2,
          height: 10,
          color: Colors.green,
        ),
        Icon(Icons.keyboard_arrow_down,color: Colors.green,size: 12,)
      ],),
    );
  }
}
