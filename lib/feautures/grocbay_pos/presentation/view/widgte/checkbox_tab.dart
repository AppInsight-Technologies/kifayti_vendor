import 'package:flutter/material.dart';
import '../../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../../core/util/presentation/controller/onpress_controller.dart';

import '../../../../../core/util/presentation/styles/box_property.dart';
import '../../../../../core/util/presentation/styles/screen_size_rario.dart';
import '../component/checkout.dart';

class WalletTabData{
  bool active;
  bool enable;
  Object? icon;
  String? w_type;
  String? ic_name;
  String? description;
  double? balance;
  Function(bool,double) onchanged;

  WalletTabData({this.icon, this.ic_name, this.active = false, this.w_type,this.description,this.balance,required this.enable,required this.onchanged});
}
class CheckboxTab extends StatefulWidget {
  final List<WalletTabData> tabs ;
  final Function()? onTap;
  final Axis align;
  final PageController controller;
  final BoxStyle? style;
  final CheckoutValueController _checkoutvalcontroller;
  CheckboxTab(this._checkoutvalcontroller,this.controller,{Key? key,required this.tabs,this.align = Axis.vertical,this.onTap,this.style}) : super(key: key);

  @override
  State<CheckboxTab> createState() => _NavigatorTabState();
}

class _NavigatorTabState extends State<CheckboxTab> {
  late  int _currentindex;

  int get currentindex => _currentindex;

  set currentindex(index) => _currentindex = index;
  ValueChanged<bool?>? onChanged;

  List<Widget> get listTab=>widget.tabs.map((tab) => tab.enable?GestureDetector(
    onTap: (){
      setState(() {
        currentindex =widget.tabs.indexWhere((element) => element.w_type == tab.w_type);
      });
      widget.controller.jumpToPage(currentindex,);
    },
    child:  Card(
        //elevation: 1,
        child:  Padding(
          padding: const EdgeInsets.only(left:10.0,bottom: 10.0,top:10.0,),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  tab.icon as Widget,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(tab.ic_name!,style: TextStyle(color: (tab.balance == 0)?Colors.black: Colors.black,fontSize:15,fontWeight: FontWeight.bold)),
                    if(tab.description!=null)Text(tab.description.toString(),style: TextStyle(color: (tab.balance == 0)?Colors.black:Colors.grey,fontSize:12,fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  if(tab.w_type=="wallet"|| tab.w_type=="loyalty") Text(tab.w_type=="wallet"?IConstants.currencyFormat+tab.balance.toString():tab.balance.toString(),style: TextStyle(color: (tab.balance == 0)?Colors.black:Colors.green,fontSize:15,fontWeight: FontWeight.bold)),
                  if(tab.w_type=="wallet"|| tab.w_type=="loyalty") Checkbox(value: (tab.balance == 0)? false:tab.active, onChanged:(bool? value) {
                    setState(() {
                      tab.active = value!;
                      tab.onchanged(value,tab.balance??0);
                      // tab.w_type == "wallet"? checkoutValueController.value.value.is_wallet = tab.active: checkoutValueController.value.value.is_loyalty = tab.active;
                    });

                  },checkColor: (tab.balance == 0)?Colors.grey.shade700:Colors.green,activeColor: Colors.grey[200],),
                  if(tab.w_type=="promo") GestureDetector(onTap:(){
                    tab.onchanged(true,tab.balance??0);
                    //print("promo clicked");
                  },child: Icon(Icons.keyboard_arrow_right,color: (tab.balance == 0)?Colors.grey.shade700:Colors.green,size: 20,)),
                ],
              )
            ],
          ),
        )
    ),
  ):SizedBox.shrink()).toList();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentindex = widget.controller.initialPage;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.style!=null?widget.style!.width:250,
        // height:LayoutView(context).mobile()||widget.align==Axis.horizontal?120:double.infinity,
        // height:(LayoutView(context).isMobile && widget.align==Axis.horizontal) ? 80 :((LayoutView(context).isTab|| LayoutView(context).isWeb) && widget.align==Axis.horizontal) ? 120 : double.infinity,
        height:widget.style!=null?widget.style!.height:250,
        padding:  EdgeInsets.symmetric(vertical:LayoutView(context).isMobile?0: 20),
        color: Colors.white,child: (widget.align==Axis.vertical)?Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children:  listTab,):Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: listTab,));
  }
}