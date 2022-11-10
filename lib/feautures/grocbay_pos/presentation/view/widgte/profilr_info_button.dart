import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../LanguageChangeProvider.dart';
import '../../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../../core/util/presentation/styles/screen_size_rario.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/getRestaraunt.dart';
import '../../../domain/entities/get_shop.dart';
import '../../../domain/entities/update_order_model.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../../bloc/loginBloc/login_bloc.dart';
import '../../bloc/shop/my_shop_bloc.dart';
import '../../bloc/update_order/update_order_bloc.dart';
import '../../rought_genrator.dart';

class ProfileInfoButton extends StatefulWidget {
  const ProfileInfoButton({Key? key}) : super(key: key);

  @override
  State<ProfileInfoButton> createState() => _ProfileInfoButtonState();
}

class _ProfileInfoButtonState extends State<ProfileInfoButton> with Navigations {
  @override
  void initState() {
    // TODO: implement initState
    sl<SharedPreferences>().setString("Languageid", "en");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        if (state is LoginLoading) {
          return const CircularProgressIndicator();
        } else if(state is LoginSucsess<getUser>){
          return (LayoutView(context).isMobile)?
          Container(
            child: PopupMenuButton(
              offset: const Offset(0, 38),
              onSelected: (selectedValue) {
                  if(selectedValue == "/Logout"){
                    BlocProvider.of<LoginBloc>(context).add(OnCLickLogout());
                    sl<SharedPreferences>().remove(Prefrence.LOGEDIN);
                    sl<SharedPreferences>().remove(Prefrence.BRANCH);
                    sl<SharedPreferences>().remove("Languageid");

                    BlocProvider.of<CartItemBloc>(context).add(const ClearCart());
                    Navigation(context, navigatore: NavigatoreTyp.pushReplacment,name: Routename.Login);
                  }else if(selectedValue == "/Language"){
                    debugPrint("bjokh...");
                     LanguageselectDailog();
                  }
              },
              child: Padding(
                padding:  LayoutView(context).isMobile? EdgeInsets.only(top: 4.0,left: 8.0,right: 8.0):EdgeInsets.all(8.0),
                child: Column(children:
                [
                  Image.asset("assets/icons/profile.png",height:  LayoutView(context).isMobile?40:20,width:LayoutView(context).isMobile?40: 20),
                  Center(child: Text("${state.data.firstName} ",style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 8,),maxLines: 2,))
                ]),
              ),
              itemBuilder: (BuildContext bc) => [

                PopupMenuItem(
                    child:  Row(
                      children: [
                        Icon(Icons.language,color: Colors.black54,size: 20),
                        SizedBox(width: 5,),
                        Text(
                          S.of(context).Language,
                          style: TextStyle(
                              color:Colors.black54
                          ),//"Logout"
                        ),
                      ],
                    ),
                    value: "/Language"
                ),
                PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(Icons.logout,color: Colors.black54,size: 20),
                        SizedBox(width: 5,),
                        Text(
                          S.of(context).logout,
                          style: TextStyle(
                              color:Colors.black54
                          ),//"Logout"
                        ),
                      ],
                    ),
                    value: "/Logout"
                ),

              ],
            ),
          )
              :Column(
                children: [
                  GestureDetector(
            onTap: (){

            },
            child: Padding(
                  padding:  LayoutView(context).isMobile? EdgeInsets.only(top: 7.0,left: 9.0,right: 9.0):EdgeInsets.all(8.0),
                  child: Column(children:
                  [
                    Image.asset("assets/icons/profile.png",height:  LayoutView(context).isMobile?40:30,width:LayoutView(context).isMobile?40: 30),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Text("${state.data.userType}",style: const TextStyle(color : Colors.white,fontSize: 8,fontWeight: FontWeight.bold)),
                        Text("${state.data.firstName?.toUpperCase()} ",style: const TextStyle(color: Colors.white,fontSize: 10)),
                      ],

                    )]),
            ),
          ),
                  (sl<SharedPreferences>().containsKey("userType") && sl<SharedPreferences>().getString("userType") == "Admin")? GestureDetector(
                    onTap: (){
                      LanguageselectDailog();
                    },
                    child: Padding(
                      padding:  LayoutView(context).isMobile? EdgeInsets.only(top: 7.0,left: 8.0,right: 8.0):EdgeInsets.all(8.0),
                      child: Column(children:
                      [
                        Icon(Icons.language,color: Colors.white,size: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Text("${state.data.userType}",style: const TextStyle(color : Colors.white,fontSize: 8,fontWeight: FontWeight.bold)),
                            Text(S.of(context).Language,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 8)),
                          ],

                        )]),
                    ),
                  ):SizedBox.shrink(),
                ],
              );
        }else{
          return const SizedBox.shrink();
        }
      },
    );
  }

  LanguageselectDailog() {
    //BlocProvider.of<MyShopBloc>(context).add( GetShopEvent(branch: sl<SharedPreferences>().getString(Prefrence.BRANCH)!,));

    debugPrint("bjokh...2");
    return showDialog(
        context: context,
        builder: (context) {
          debugPrint("bjokh...3");
          return StatefulBuilder(builder: (context, setState) {
            debugPrint("bjokh...4");
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0)),
              child: BlocBuilder<MyShopBloc, MyShopState>(
                  builder: (context, stateedit) {
                    debugPrint("bjokh...6"+stateedit.toString());
                    if(stateedit is MyShopSucsess)  {
                      debugPrint("bjokh...5");
                      return
                        Container(
                          width: MediaQuery.of(context).size.width/5,
                          height: 150,
                          child: Column(
                            children: [
                              SizedBox(height: 10,),
                              Center(
                                child: Text(S.of(context).Select_Language, style: TextStyle(fontSize: 20)),
                              ),
                              SizedBox(height: 10,),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: stateedit.shopdata.languages!.length,
                                  itemBuilder: (_, i) {
                                    return     GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: (){
                                        Navigator.of(context).pop();
                                        setState(() {
                                          sl<SharedPreferences>().setString("Languageid", stateedit.shopdata.languages![i].languageCode!);
                                        });
                                        if(stateedit.shopdata.languages![i].languageCode == sl<SharedPreferences>().getString("Languageid")) {
                                          context.read<LanguageChangeProvider>().changeLocale(sl<SharedPreferences>().getString("Languageid")!);
                                        }else if(stateedit.shopdata.languages![i].languageCode == sl<SharedPreferences>().getString("Languageid")){
                                          context.read<LanguageChangeProvider>().changeLocale(sl<SharedPreferences>().getString("Languageid")!);
                                        }else if(stateedit.shopdata.languages![i].languageCode == sl<SharedPreferences>().getString("Languageid")){
                                          context.read<LanguageChangeProvider>().changeLocale(sl<SharedPreferences>().getString("Languageid")!);
                                        }
                                        debugPrint("sl<SharedPreferences>().setString....."+sl<SharedPreferences>().getString("Languageid")!);
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: ( sl<SharedPreferences>().getString("Languageid")== stateedit.shopdata.languages![i].languageCode)?Color(0xffebf5ff) :Colors.white,
                                            ),
                                            child: Row(
                                              children: [
                                                SizedBox(width: 15,),
                                                Text(stateedit.shopdata.languages![i].name!),
                                                Spacer(),
                                                ( sl<SharedPreferences>().getString("Languageid") == stateedit.shopdata.languages![i].languageCode)?Icon(Icons.check, color: Colors.black):SizedBox.shrink(),
                                                SizedBox(width: 15,)
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10,)
                                        ],
                                      ),
                                    );
                                  }),
                            ],
                          ),

                        );

                    }
                    else{
                      return SizedBox.shrink();
                    }
                  }),
            );
          });
        });
  }
}
