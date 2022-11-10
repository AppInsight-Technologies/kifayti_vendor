import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:recase/recase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../../core/util/presentation/controller/global_focus.dart';
import '../../../../../core/util/presentation/controller/onpress_controller.dart';
import '../../../../../core/util/presentation/styles/box_property.dart';
import '../../../../../core/util/presentation/styles/screen_size_rario.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/fetch_category_product.dart';
import '../../../domain/entities/get_profile_modle.dart';
import '../../../domain/entities/themedata/dash_page_info.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../../bloc/customers/userprofile_bloc.dart';
import '../../bloc/loginBloc/login_bloc.dart';
import '../../bloc/search/search_bloc.dart';
import '../../bloc/shop/my_shop_bloc.dart';
import '../../bloc/themeControllBloc/theme_bloc.dart';
import '../../rought_genrator.dart';
import '../component/header.dart';
import '../component/variation_drawer.dart';
import '../widgte/navigatore_tab.dart';
import '../component/web_body.dart';
import '../widgte/profilr_info_button.dart';
import '../widgte/search_bar.dart';

class DashBoard extends StatefulWidget {
 // final Map<String, String>? params;
 final Map<String, String>? qparams;
  late int index;
   DashBoard({required Map<String, String> params,this.qparams,Key? key}) : index = /*(state.props.first as ThemesData?)?.name == ThemeName.vendor ?*/DashBoardPageInfo(qparams).pagedatabpos.indexWhere((element) {
     debugPrint('index: ${element.pageKey} == ${params['index']}');
     return element.pageKey.toLowerCase() ==(params['index'] as String).toLowerCase() ;
   })/*:DashBoardPageInfo(params).pagedatabpos.indexWhere((element) => element.pageKey == (params?['index']??"dashboard")) */,super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>  with SingleTickerProviderStateMixin ,Navigations {
 late PageController pageViewController;
 bool search_status = false;
  @override
  void initState() {
    // Future.delayed(const Duration(seconds: 1),() async{
    //   UserDatabase _user = UserDatabase(context)
    //   _user(sucsess:(getUser data){
    //
    //   },failes:(messege){
    //     Navigation(context, navigatore: NavigatoreTyp.pushReplacment,name: Routename.Login);
    //   });
    // });
    // TODO: implement initState
    debugPrint("calling header INDEX:${widget.index}");
    pageViewController = PageController(initialPage: widget.index);
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageViewController.dispose();
  }

  @override
  void didUpdateWidget(covariant DashBoard oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    pageViewController.animateToPage(widget.index, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      // appBar: PreferredSize(preferredSize: const Size.fromHeight(60.0),
      //     child: Header(onTapCreateOrder:(int){
      //       pageViewController.jumpToPage(5,);
      //     },)),
      body:   WebBody(
          body: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              ReCase title;
              if(sl<SharedPreferences>().containsKey("title")) {
                title = new ReCase(
                    sl<SharedPreferences>().getString("title")!);
              }else{
               title = new ReCase("Dashboard");
              }
              return Scaffold(
                backgroundColor: Colors.white,
                appBar:PreferredSize(preferredSize: const Size.fromHeight(60.0),
                    child: Header (title: title.titleCase,pagec: pageViewController,onTapCreateOrder:(int){
                      pageViewController.jumpToPage(int);
                    },fromScreen:"dashboard")) ,
                body: PageView(controller: pageViewController,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: LayoutView(context).isMobile?Axis.horizontal:Axis.vertical,
                  onPageChanged: (index){
                    debugPrint("page changes to : $index");
                    // pageViewController.notifyListeners();
                  },
                  children:  ((state.props.first as ThemesData?)?.name == ThemeName.vendor ?DashBoardPageInfo(widget.qparams).pagedatabvendore:DashBoardPageInfo(widget.qparams).pagedatabpos).map((e) => e.widget!).toList(),
                ),
              );
            },
          ),
          sidedrawer:  LayoutView(context).isWeb||LayoutView(context).isTab?Container(
            color: Colors.black/*Theme.of(context).bottomNavigationBarTheme.backgroundColor*/,
            child: Column(
              children: [
                SizedBox(width: 80,height: 80 ,child: BlocBuilder<MyShopBloc, MyShopState>(
                  builder: (context, state) {
                    if(state is MyShopSucsess) {
                      return Padding(
                        padding: const EdgeInsets.only(top:25.0),
                        child: CachedNetworkImage(imageUrl: state.shopdata.iconImage!,placeholder: (context,string){
                          return Image.asset("assets/images/logo.png");
                        },),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(top:25.0),
                        child: Image.asset("assets/images/logo.png")
                        );
                    }
                  },
                )),
                Expanded(child: Container(color: Colors.black/*Theme.of(context).bottomNavigationBarTheme.backgroundColor*/,child: tabwidget)),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ProfileInfoButton(),
                    BlocBuilder<UserProfileBloc, UserProfileState>(
                      builder: (context, state) {
                        return GestureDetector(
                            onTap:(){
                              BlocProvider.of<LoginBloc>(context).add(OnCLickLogout());
                              sl<SharedPreferences>().remove(Prefrence.LOGEDIN);
                              sl<SharedPreferences>().remove(Prefrence.BRANCH);
                              sl<SharedPreferences>().remove(Prefrence.showSearchbar);
                              sl<SharedPreferences>().remove(Prefrence.posPoint);
                              sl<SharedPreferences>().remove(Prefrence.posId);
                              sl<SharedPreferences>().remove("title");
                              sl<SharedPreferences>().remove("opendrawer");
                             /* state as UserProfileSucsess<GetCustomerProfile>;
                              if(state.data.data?.first.apiKey!=null){
                                BlocProvider.of<UserProfileBloc>(context).add(ClearCustomerData(state.data.data!.first.apiKey!));
                              }*/
                              BlocProvider.of<CartItemBloc>(context).add(const ClearCart());
                              Navigation(context, navigatore: NavigatoreTyp.pushReplacment,name: Routename.Login);
                            }, child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: const [
                              Icon(Icons.logout,color: Colors.white,size: 20),
                              Text("Logout",style: TextStyle(color:Colors.white,fontSize: 10),)
                            ],
                          ),
                        ));
                      },
                    ),
                  ],
                )
              ],
            ),
          ):null),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: (!LayoutView(context).isMobile || sl<SharedPreferences>().getString("title") == "viewOrder")?null:
      Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(10.0),
        height: 73,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          color: Theme.of(context).primaryColor,
        ),
        // color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        child: tabwidget,
      ),
    );
  }

  Widget get tabwidget=>BlocBuilder<ThemeBloc, ThemeState>(
    builder: (context, state) {
      List<TabData> tabdatas =((state.props.first as ThemesData?)?.name == ThemeName.vendor ?DashBoardPageInfo(widget.qparams).pagedatabvendore:DashBoardPageInfo(widget.qparams).pagedatabpos).map((e) => TabData(active: e.vstatus,ic_name: e.title,icon: e.icon)).toList();

      return NavigatorTab(pageViewController,style: BoxStyle(
        width: LayoutView(context).isMobile||!(LayoutView(context).isWeb||LayoutView(context).isTab)?null:70,
        padding: EdgeInsets.symmetric(vertical:LayoutView(context).isMobile?0: 20),
        height:(LayoutView(context).isMobile && !(LayoutView(context).isWeb||LayoutView(context).isTab)) ? 80 :((LayoutView(context).isMobile|| LayoutView(context).isMobile) && !(LayoutView(context).isWeb||LayoutView(context).isTab)) ? 120 : double.infinity,
      ),align: LayoutView(context).isWeb||LayoutView(context).isTab?Axis.vertical:Axis.horizontal,
          tabs: tabdatas,
        onTabTap: (index ) {
          Navigation(context, navigatore: NavigatoreTyp.push,name: Routename.Home,parms: {'index':(DashBoardPageInfo(widget.qparams).pagedatabpos[index].pageKey).toLowerCase()},/*qparms: widget.qparams*/qparms: {
            "index value":"0",
          "clickvalue":  "",
          });
          // pageViewController.notifyListeners();
          // pageViewController.jumpToPage(index);
        },
      );

    },
  );
}

