import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/util/presentation/styles/screen_size_rario.dart';

import '../../bloc/homepage/subcategory/subCategory_bloc.dart';

class TabData{
  bool active;
  IconData? icon;
  String? ic_name;
  String icon_id;
  int? count;
  TabData({this.icon, this.ic_name, this.active = false,required this.icon_id,this.count});
}
class TabStyle{
  Color bgcolor;
  TabStyle({this.bgcolor=Colors.transparent,});

}
class CustomeTabView extends StatefulWidget {
  final List<TabData> tabs ;
  final Function(int)? onTap;
  final Axis align;
  final MainAxisAlignment mainAxisAlignment;
  final PageController controller;
  TabStyle style;
  CustomeTabView(this.controller,{Key? key,required this.tabs,this.align = Axis.vertical,this.onTap,required this.style,this.mainAxisAlignment=MainAxisAlignment.spaceBetween}) : super(key: key);

  @override
  State<CustomeTabView> createState() => _CustomeTabViewState();
}

class _CustomeTabViewState extends State<CustomeTabView> {
  late  int _currentindex;

  int get currentindex => _currentindex;

  set currentindex(index) => _currentindex = index;

  List<Widget> get listTab=>widget.tabs.map((tab) => Center(
    child: Padding(
      padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
            color: widget.tabs[currentindex].icon_id == tab.icon_id?Colors.green.shade50:widget.style.bgcolor,
            border: Border.all(color: widget.tabs[currentindex].icon_id == tab.icon_id?Colors.green:widget.style.bgcolor)
        ),
        child: MaterialButton(onPressed: (){
          setState(() {
            currentindex =widget.tabs.indexWhere((element) => element.icon_id == tab.icon_id);
            widget.onTap!=null?widget.onTap!(currentindex):null;
          });
          widget.controller.jumpToPage(currentindex,);
        },child: Row(mainAxisSize: MainAxisSize.min,
          children: [

            Text(tab.ic_name!+"("+tab.count.toString()+")" ,style: TextStyle(color: widget.tabs[currentindex].icon_id == tab.icon_id?Colors.green.shade300:Colors.black45,fontWeight: FontWeight.bold,fontSize: 11),),
          ],
        )
        ),
      ),

    ),
  )).toList();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentindex = widget.controller.initialPage;

  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 10.0,top: 2,bottom: 2),
      child: LayoutView(context).isMobile?Wrap(
        children: widget.tabs.map((tab) =>
            InkWell(
         // behavior: HitTestBehavior.translucent,
          onTap: (){
            setState(() {
              currentindex =widget.tabs.indexWhere((element) => element.icon_id == tab.icon_id);
              widget.onTap!=null?widget.onTap!(currentindex):null;
            });
            widget.controller.jumpToPage(currentindex,);
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0,bottom: 5.0,left: 5,right: 5),
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                color: widget.tabs[currentindex].icon_id == tab.icon_id?widget.style.bgcolor:widget.style.bgcolor,
                  border: Border.all(color: widget.tabs[currentindex].icon_id == tab.icon_id?Theme.of(context).primaryColor:widget.style.bgcolor),
                borderRadius: BorderRadius.circular(3),
              ),
              child: TextButton(onPressed: (){
                print("index value clicked....."+currentindex.toString());
                setState(() {
                  currentindex =widget.tabs.indexWhere((element) => element.icon_id == tab.icon_id);
                  widget.onTap!=null?widget.onTap!(currentindex):null;
                });
                widget.controller.jumpToPage(currentindex,);
              },child: Row(mainAxisSize: MainAxisSize.min,
                children: [

                  Text(tab.ic_name! +"("+tab.count.toString()+")" ,style: TextStyle(color: widget.tabs[currentindex].icon_id == tab.icon_id?Theme.of(context).primaryColor:Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 11),),
                ],
              )
              ),
            ),

          ),
        )
        )
            .toList(),
      ):
      Container(
        height: 40,
        decoration: BoxDecoration( borderRadius: BorderRadius.circular(5),
          color: widget.style.bgcolor,),
        child:

        ListView(
            scrollDirection: Axis.horizontal,
            children: listTab),


      ),
    );
  }
}
