
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../../core/util/presentation/controller/global_focus.dart';
import '../../../../../core/util/presentation/styles/screen_size_rario.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/get_shop.dart';
import '../../bloc/loginBloc/login_bloc.dart';
import '../../bloc/search/search_bloc.dart';
import '../../bloc/shop/my_shop_bloc.dart';
import '../../bloc/shop_status/shopstatus.dart';
import '../../bloc/themeControllBloc/theme_bloc.dart';
import '../screen/create_order_screen.dart';
import '../widgte/customebuttons/create_order_btn.dart';
import '../widgte/customebuttons/recent_order_btn.dart';
import '../widgte/profilr_info_button.dart';
import '../widgte/search_bar.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'checkout.dart';
class Header extends StatefulWidget {
  Function(int) onTapCreateOrder;
  String? title;
  PageController pagec;
  String? fromScreen;

  Header({Key? key,required this.onTapCreateOrder, this.title, required this.pagec, this.fromScreen}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();

}

class _HeaderState extends State<Header> {
  bool _onlinetogle = true;

  bool _themetogle = false;
  final GlobalKey<ScaffoldState> _sc_key1 = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState

    BlocProvider.of<MyShopBloc>(context).add( GetShopEvent(branch: sl<SharedPreferences>().getString(Prefrence.BRANCH)!,));
    Future.delayed(const Duration(microseconds: 200),(){
      print("calling FetchUserData");
      BlocProvider.of<LoginBloc>(context).add( FetchUserData());

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
//     widget.pagec.addListener(() {
// print("pages:  ${widget.pagec.page?.toInt()}");
//     });

    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: /*(LayoutView(context).isMobile)? Color(0xff503C8C):*/Colors.white,
      actions:  [
      Expanded(
        child: Row(mainAxisSize: MainAxisSize.max,mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
          widget.title!=null?Padding(
            padding: const EdgeInsets.all(8.0),
            child: (LayoutView(context).isMobile)? Image.asset("assets/icons/logo2.png",):
            Text(widget.title!,style: const TextStyle(fontSize: 25,color: Colors.green,fontWeight: FontWeight.bold),),
          ):const SizedBox.shrink(),
          ( LayoutView(context).isWeb || LayoutView(context).isTab) ? Expanded(
            flex: 2,
            child: SearchBar((query,context){

            },hintText: S.of(context).Search_For_Order_Id,type:SearchType.order,style: SearchBarStyle(iconalign: IconAlign.ending,contentPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),decoration: BoxDecoration(
              color:Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(8),
            )), listdata: (e, int , bool ) {
              return const SizedBox(height: 10,);
            }, onSubmit: (e ) {

            }, focus:  FocusN.f_order_search,),
          ):const SizedBox.shrink(),

          // Expanded(flex: 1,child: CreateOrderButton(controller: widget.pagecontroler)),

            Padding(
                padding:(LayoutView(context).isMobile)?const EdgeInsets.only(left: 50.0,) :const EdgeInsets.symmetric(horizontal: 10.0),
                child: BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, state) {
                    debugPrint("dfghjk...."+sl<SharedPreferences>().getString("userType")! +"..."+sl<SharedPreferences>().getString("title")!);
                    return (sl<SharedPreferences>().containsKey("userType") && sl<SharedPreferences>().getString("userType") == "Admin" /*&& (sl<SharedPreferences>().getString("title") != "DASHBOARD")*/) ?BlocConsumer<ShopstatusBloc, ShopstatusState>(
                      listener: (context, state) {
                        if(state is ShopstatusStateSucsess){
                          print("togle status :${state.data}");
                          setState(() => _onlinetogle = state.data);
                        }else if(state is ShopstatusStateError){
                          print(" ogle state error ${state.e}");
                        }
                        // TODO: implement listener
                      },
                      builder: (context,state){
                        return FlutterSwitch(
                          width: (LayoutView(context).isWeb || LayoutView(context).isTab)?180: MediaQuery.of(context).size.width*0.3,//100,
                          height: (LayoutView(context).isWeb || LayoutView(context).isTab)?7.h:35,
                          activeTextColor: Colors.white,
                          inactiveTextColor: Colors.grey,
                          borderRadius: 20.0,
                          switchBorder:Border.all(width: 1,color:  Color(0xff503C8C)),
                          inactiveText: S.of(context).OFFLINE,
                          inactiveColor: Colors.white,
                          activeIcon: state is ShopstatusStateLoading?const CircularProgressIndicator(color: Color(0xff503C8C),): Icon(Icons.power_settings_new_sharp,color:  Color(0xff503C8C),),
                          inactiveIcon: state is ShopstatusStateLoading?const CircularProgressIndicator(color: Colors.white,): Icon(Icons.power_settings_new_sharp),
                          activeToggleColor: Colors.white,
                          activeText: S.of(context).ONLINE,
                          activeTextFontWeight: FontWeight.normal,
                          inactiveToggleColor: Colors.grey,
                          activeColor:  Color(0xff503C8C),
                          valueFontSize: (LayoutView(context).isWeb || LayoutView(context).isTab)?16.0.sp:14,
                          showOnOff: true,
                          toggleSize: 30.dp,value: _onlinetogle ,
                          onToggle: (bool value) => BlocProvider.of<ShopstatusBloc>(context).add(const ShopstatusUpdate()),
                        );
                      },
                    ):
                    /*widget.pagec.page?.toInt()!=5?Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CreateOrderButton(onTap: (int )=>widget.onTapCreateOrder(int),),
                        ],
                      ),
                    )*/
                    // Row(
                    //   children: [
                    //   //  RecentOrderButton(onTap: (int )=>widget.onTapCreateOrder(int),),
                    //  //   SizedBox(width: 5,),
                    //     CreateOrderButton(onTap: (int )=>widget.onTapCreateOrder(int),),
                    //     /*Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    //       child: Column(
                    //         mainAxisSize: MainAxisSize.min,
                    //         crossAxisAlignment: CrossAxisAlignment.end,
                    //         children: [
                    //           CreateOrderButton(onTap: (int )=>widget.onTapCreateOrder(int),),
                    //         ],
                    //       ),
                    //     ),*/
                    //   ],
                    // );
                    //:const SizedBox.shrink();
                    (sl<SharedPreferences>().containsKey("title"))?
                    (sl<SharedPreferences>().getString("title") == "DASHBOARD" )? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CreateOrderButton(onTap: (int )
                        {
                          setState((){
                            debugPrint("nav to create...");
                            sl<SharedPreferences>().setString("title","Point of Sales");
                            debugPrint("nav to create...2.."+sl<SharedPreferences>().getString("title")!+"...."+int.toString());
                            widget.onTapCreateOrder(int);
                          });

                        }),
                      ],
                    ):(sl<SharedPreferences>().getString("title") == "Point of Sales" && sl<SharedPreferences>().getString("userType") != "Admin")?
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             GestureDetector(
                               onTap: (){
                                 setState(() {
                                   debugPrint("vbn...");
                                   sl<SharedPreferences>().setBool("opendrawer", true);
                                   debugPrint("nbv.."+sl<SharedPreferences>().getBool("opendrawer").toString());
                                   widget.onTapCreateOrder(5);
                                 });

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
                             ),

                             Container(
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
                                     Text("Hold Orders", style: TextStyle(
                                         color: Colors.green,
                                         fontSize: 16,
                                         fontWeight: FontWeight.bold
                                     ),),
                                     SizedBox(width: 10,),
                                     Icon(Icons.pause,color: Colors.green,size:17),
                                   ],
                                 ),
                               ),
                             ),
                           ],
                         )
                        : SizedBox.shrink():Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CreateOrderButton(onTap: (int )
                        {

                          setState((){
                            debugPrint("nav to create...");
                            sl<SharedPreferences>().setString("title","Point of Sales");
                            debugPrint("nav to create...2.."+sl<SharedPreferences>().getString("title")!+"...."+int.toString());
                            widget.onTapCreateOrder(int);
                          });
                        }),
                      ],
                    );
                  /*  (sl<SharedPreferences>().getString("title") == "DASHBOARD")? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CreateOrderButton(onTap: (int )
                        {
                          sl<SharedPreferences>().setString("title","Point of Sales");
                                        widget.onTapCreateOrder(int);
                                      }),
                      ],
                    ):SizedBox.shrink();*/
                  },
                ),
              ),

          (LayoutView(context).isMobile)?const ProfileInfoButton():SizedBox.shrink()

          // Expanded(flex: 1,child: BlocBuilder<ThemeBloc, ThemeState>(
          //   builder: (context, state) {
          //     return (state  is ThemeStateLoading)?const CircularProgressIndicator():FlutterSwitch(
          //         width: 100,
          //         activeTextColor: Colors.green,
          //         inactiveTextColor: Colors.grey,
          //         padding: 4,
          //         inactiveText: "POS",
          //         inactiveColor: Colors.white,
          //         activeIcon: const Icon(Icons.power_settings_new_sharp),
          //         inactiveIcon: const Icon(Icons.power_settings_new_sharp),
          //         activeToggleColor: Colors.green,
          //         activeText: "Vendor",
          //         inactiveToggleColor: Colors.grey,
          //         activeColor: Colors.white,
          //         valueFontSize: 12.0,
          //         showOnOff: true,
          //         toggleSize: 30,value: (state.props.first as ThemesData?)?.name == ThemeName.vendor ,
          //         onToggle: (bool value) => BlocProvider.of<ThemeBloc>(context).add( SetTheme(value?ThemeName.vendor:ThemeName.pos))
          //     );
          //   },
          // )),
        ],),
      )
    ],
    );
  }
}

