import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import '../..//feautures/grocbay_pos/presentation/view/component/checkout.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/util/presentation/controller/onpress_controller.dart';
import '../../../../../core/util/presentation/styles/box_property.dart';
import '../../../../../core/util/presentation/styles/screen_size_rario.dart';
import '../../../../../injection_container.dart';

class TabData{
  bool active;
  Object? icon;
  String? ic_name;
  double? fontSize;
  Function()? index;
  TabData({this.icon, this.ic_name, this.active = true, this.fontSize, this.index});
}
class NavigatorTab extends StatefulWidget {
  final List<TabData> tabs ;
  final Function()? onTap;
  final Axis align;
  final PageController controller;
  BoxStyle? style;
  final bool islist;
  final Function(int) onTabTap;

  NavigatorTab(this.controller,{Key? key,required this.tabs,this.align = Axis.vertical,this.onTap, this.style,this.islist = false, required this.onTabTap}) : super(key: key);

  @override
  State<NavigatorTab> createState() => _NavigatorTabState();
}

class _NavigatorTabState extends State<NavigatorTab> {
  late  int _currentindex;

  int get currentindex => _currentindex;

  set currentindex(index) => _currentindex = index;

  List<Widget> get listTab=>widget.tabs.map((tab) =>  tab.ic_name == ""?SizedBox.shrink():Center(
    child: GestureDetector(
      onTap: (){
        if(tab.active){
          setState(() {
            currentindex =widget.tabs.indexWhere((element) => element.ic_name == tab.ic_name);
            if(tab.index!=null) {
              tab.index!();
            }
          });
         // widget.controller.jumpToPage(currentindex,);
          widget.onTabTap(currentindex);
          sl<SharedPreferences>().setString("title", tab.ic_name!);
        }
        // widget.controller.animateToPage(currentindex,curve: Curves.fastOutSlowIn,duration: const Duration(seconds: 1));
        // widget.controller.notifyListeners();
      },
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: LayoutView(context).isMobile?8:10.0,horizontal: LayoutView(context).isMobile?0:10.0),
        child: Container(
          width:  LayoutView(context).isMobile||widget.align==Axis.horizontal?68:200,
          height:  LayoutView(context).isMobile||widget.align==Axis.horizontal?210:null,
          decoration: BoxDecoration(
              color: tab.ic_name==""?Colors.transparent:currentindex>=0&&widget.tabs[currentindex].ic_name == tab.ic_name?Theme.of(context).bottomNavigationBarTheme.selectedItemColor:/*Colors.grey[100]*/Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
              border:  widget.style!.borderenabel?Border.all(color: tab.ic_name==""?Colors.transparent:currentindex>=0&&widget.tabs[currentindex].ic_name == tab.ic_name?Colors.green:Colors.white):null
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Column(
              children: [
              if(tab.icon is IconData)
                Icon(tab.icon as IconData,color: !tab.active?Colors.white:(currentindex>=0&&widget.tabs[currentindex].ic_name == tab.ic_name)?Colors.green:Colors.white),
              if(tab.icon is Image)
                (tab.icon as Image),
               LayoutView(context).isMobile?SizedBox(height: 5,):SizedBox.shrink(),
              if(tab.ic_name!=null)
                Text(tab.ic_name!,style: TextStyle(color:Colors.white /*!tab.active?(LayoutView(context).isMobile)?Colors.white:Colors.grey:currentindex>=0&&widget.tabs[currentindex].ic_name == tab.ic_name? Colors.green: (LayoutView(context).isMobile)?Colors.white:Colors.grey*/,fontSize: (tab.fontSize != null)? tab.fontSize:10),)
            ],),
          ),
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
    return Container(
        width:widget.style!.width,
        // height:LayoutView(context).mobile()||widget.align==Axis.horizontal?120:double.infinity,
        height:widget.style!.height,
        padding:  widget.style!.padding, child:/* (widget.align==Axis.vertical||widget.tabs.length>5||widget.islist)?
    ListView(scrollDirection: widget.align,
      children:  listTab,):*/Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: listTab,));
  }
}