import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/util/calculations/cartcalculations.dart';
import '../../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../../core/util/presentation/controller/global_focus.dart';
import '../../../../../core/util/presentation/controller/onpress_controller.dart';
import '../../../../../core/util/presentation/styles/screen_size_rario.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/cart_item_modle.dart';
import '../../../domain/entities/fetch_category_product.dart';
import '../../../domain/entities/get_profile_modle.dart';
import '../../../domain/entities/search_user_modle.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../../bloc/customers/userprofile_bloc.dart';
import '../../bloc/homepage/category/category_bloc.dart';
import '../../bloc/search/search_bloc.dart';
import '../widgte/create_profilepopup.dart';
import '../widgte/custom_stepper.dart';
import '../widgte/customer/customer_profile_button.dart';
import '../widgte/dailog/alert _dailog.dart';
import '../widgte/search_bar.dart';
import 'checkout_orderlist2.dart';
import 'checkoutpopup.dart';

class Checkout extends StatefulWidget {
  final GlobalKey<ScaffoldState>? s_key;
  // ValueListnabelController<CheckoutModel> _checkoutvalcontroller;
  const Checkout( {Key? Key,this.s_key,}) : super(key: Key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout>  {
  PageController pageViewController = PageController(initialPage: 0);
  final PageController _controller = PageController(initialPage: 0);

  List<CartItemModel> list_cart_item = [];
  CartCalculationsState cal = CartCalculationsState();
  double x=0.0;


  @override
  void initState(){
    // Future.delayed(const Duration(seconds: 1),() async{
    //   GetLoyaltyDatabase _getloyalty = GetLoyaltyDatabase(context,sl<SharedPreferences>().getString(Prefrence.BRANCH)!);
    //   CheckLoyaltyDatabase _checkloyalty = CheckLoyaltyDatabase(context, "500", sl<SharedPreferences>().getString(Prefrence.BRANCH)! );
    //   _getloyalty(sucsess:(getLoyalty data){
    //
    //   },failes:(messege){
    //     //Navigation(context, navigatore: NavigatoreTyp.pushReplacment,name: Routename.Login);
    //   });
    //
    //   _checkloyalty(sucsess:(checkLoyalty data){
    //
    //   },failes:(messege){
    //     //Navigation(context, navigatore: NavigatoreTyp.pushReplacment,name: Routename.Login);
    //   });
    // });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    // FocusN.f_usersearch.dispose();
    // FocusN.f_product_search.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    String totalamount ="";
    pageViewController.addListener(() {
      // print("xxv");
      checkoutValueController.value.value.paymentType = pageViewController.page==0?"cod": pageViewController.page==1?"sod":"online";
    });
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BlocConsumer<CartItemBloc, CartState>(
              listener: (contextx, state) {
                print("f_product_search request");
                FocusN.f_product_search.requestFocus();
                // TODO: implement listener
              },
              builder: (context, states) {
                if(states is CartStateSucsess<List<CartItemModel>>){
                  print("cart data: ${states.data}");
                  list_cart_item = states.data;
                  // BlocProvider.of<LoyaltyBloc>(context).add( OnCheckLoyalty(branch: '4', user_point: checkoutValueController.value.value.loyaltyamount??"0", total: cal.calculateTotalAmount(state.data),lenable:checkoutValueController.value.value.is_loyalty));
                }
                return BlocBuilder<UserProfileBloc, UserProfileState>(
                    builder: (context, state) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(height: 60,onPressed: (){
                            if(state is UserProfileSucsess<GetCustomerProfile>) {
                              print("GetCustomerProfile.."+sl<SharedPreferences>().getBool(Prefrence.showSearchbar).toString());
                              checkoutValueController.value.value.is_membered_user = state.data.data!.first.membership;
                              if(list_cart_item.isNotEmpty) {
                                checkoutValueController.value.value.apiKey = state.data.data!.first.apiKey;
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      // if (LayoutView(context).isWeb || LayoutView(context).isTab) {
                                      return Dialog(child: CHeckOutPopup(list_cart_item, state.data));
                                      // }
                                      //
                                      //
                                      // else {
                                      //   showBottomSheet(context: context,
                                      //       builder: (context) {
                                      //         return CHeckOutPopup(
                                      //             list_cart_item, state.data);
                                      //       });
                                      // }
                                    }
                                );
                              }else{
                                print("abc...");
                                Alert().showallert(context,messege: "Please Select Product");
                              }
                            }
                            else{
                              //print(state.e);
                              print("abc...1");
                              Alert().showallert(context,messege: "Please Select User");

                            }
                          },color: Colors.green, child:  Center(child: Text("Invoice : ${cal.calculateTotalAmount(list_cart_item,checkoutValueController.value.value.is_membered_user !="0")}",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),))
                          )
                      );
                    }
                );
              },
            ),
            // TODO: Navigator Tab Has Been Changed need to fix this
          ],
        ),
        appBar: PreferredSize(preferredSize: const Size.fromHeight(100),
          child: Column(
            children: [
              BlocBuilder<UserProfileBloc, UserProfileState>(
                builder: (context, state) {
                  if(state is UserProfileLoading){
                    return const SizedBox(height: 40,child: CircularProgressIndicator(),);
                  }
                  if(state is UserProfileSucsess<GetCustomerProfile>) {
                    checkoutValueController.value.value.apiKey = state.data.data!.first.apiKey;
                    checkoutValueController.value.value.userId = state.data.data!.first.id.toString();
                    checkoutValueController.value.value.is_membered_user = state.data.data!.first.membership.toString();
                    BlocProvider.of<CategoryBloc>(context).add(const CategoryEventInitial());
                    print("member_user: "+checkoutValueController.value.value.is_membered_user!);
                    print("apikey: "+checkoutValueController.value.value.apiKey!);
                    print("checkoutValueController.value.value.apiKey"+checkoutValueController.value.value.userId!);
                    if(checkoutValueController.value.value.apiKey != null){
                      print("user loaded");
                      BlocProvider.of<CartItemBloc>(context).add(FetchUserCart(u_id:checkoutValueController.value.value.userId!));
                    }
                    return CustomerProfileButton(userdata: state.data.data!.first,);
                  }
                  String searched = '';
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: BlocProvider<SearchBloc>(
                              create: (context) => sl<SearchBloc>(),
                              child: Container(

                                child: SearchBar<SearchUser>((query,context){
                                  print("query: $query");
                                  if(!query.contains(RegExp('"[a-zA-Z]+"'))) {
                                    searched = query;
                                  }
                                  BlocProvider.of<SearchBloc>(context).add(OnSearch(query, SearchType.user));
                                },onSubmitEmpty:(val){
                                  print("inide on submitempty");
                                  sl<SharedPreferences>().setBool(Prefrence.showSearchbar, true);
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return  Dialog(
                                          child: SizedBox(width:MediaQuery.of(context).size.width/2,child: CreateProfile(initnum: searched,)));
                                    },
                                  );
                                },
                                    empty: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children:
                                        const [Icon(Icons.add,color: Colors.black,size:12),
                                          Text("Add Customer",style: TextStyle(color: Colors.black,fontSize:12,fontWeight: FontWeight.bold),)],
                                      ),
                                    ),
                                    focus: FocusN.f_usersearch,
                                    onSubmit: (e) {
                                      sl<SharedPreferences>().setBool(Prefrence.showSearchbar, true);
                                      print("ontapped "+sl<SharedPreferences>().getBool(Prefrence.showSearchbar).toString());

                                      if(e==null){
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return  Dialog(
                                                child: SizedBox(width:MediaQuery.of(context).size.width/2,child: CreateProfile(initnum: searched,)));
                                          },
                                        );
                                      }else{
                                        BlocProvider.of<UserProfileBloc>(context).add(OnUserProfile(e.uId!));
                                        if(!FocusN.f_product_search.hasFocus) {
                                          FocusN.f_product_search.requestFocus();
                                        }
                                      }
                                    },
                                    listdata: (e,index,active)=>Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${e.uName}",style:  TextStyle(color: (active)?Colors.green: Colors.black)),
                                          Text("${e.uNumber}",style:  TextStyle(color:  (active)?Colors.green: Colors.black)),
                                        ],
                                      ),
                                    ),hintText: "Find customer by Name, Phone",
                                    type:SearchType.user,
                                    style: SearchBarStyle(iconalign: IconAlign.ending,
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 11),
                                        decoration: BoxDecoration(
                                          color:Color(0xffF1FDF3),
                                          borderRadius: BorderRadius.circular(8),
                                        ))),
                              ),
                            ),
                          ),
                          GestureDetector(onTap: ()=>  {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return  Dialog(
                                    child: SizedBox(width:MediaQuery.of(context).size.width/2,child: CreateProfile(initnum: searched,)));
                              },
                            )
                          },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                              /*  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular((5)),
                                  color: Colors.grey.shade200,
                                ),*/
                               // padding: const EdgeInsets.all(10),
                                child: Column(
                                  children:
                                   [ Image.asset("assets/icons/Grocbay_logo.png",height: 20,width: 20,color:Color(0xff32B847) ,),
                                    Text("Add Customer",style: TextStyle(color: Color(0xff32B847),fontSize:10,fontWeight: FontWeight.bold),)],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      (sl<SharedPreferences>().getBool(Prefrence.showSearchbar)??false )?
                      const SizedBox.shrink():
                      const SizedBox(height: 3,),
                      (sl<SharedPreferences>().getBool(Prefrence.showSearchbar)??false )?
                      SizedBox.shrink(): Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: [
                            Icon(Icons.error_outline,color: Colors.red,size: 12),
                            SizedBox(width: 3,),
                            Text("Please select customer to proceed", style: TextStyle(
                                color: Colors.red, fontSize: 10
                            ),),
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),

            ],
          ),),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                    children: [

                      BlocConsumer<CartItemBloc, CartState>(
                        listener: (context, state) {
                          if(!FocusN.f_product_search.hasFocus) {
                            FocusN.f_product_search.requestFocus();
                          }
                        },
                        builder: (context, state) {

                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CartItemList(_controller,tabs: list_cart_item.map((e) => CartItemData(u_id: list_cart_item.first.user!,unit: e.type,steppr:/* e.skutype=="1"?SteppersType.sku:*/SteppersType.multy,p_id: e.varId!,quantity: e.quantity,p_name: e.itemName??"",balance: double.parse(((checkoutValueController.value.value.is_membered_user==null||checkoutValueController.value.value.is_membered_user=="0")?e.price??"0":(double.parse(e.membershipPrice??"0") > 0) ? e.membershipPrice??"0" : e.price??"0").toString()), v_name: "${e.varName} ${e.type}", cartstepper: (int ) {
                                  if(int == 0){
                                    BlocProvider.of<CartItemBloc>(context).add(CartRemove(u_id:  list_cart_item.first.user!,varid: e.varId!));
                                  }else {
                                    BlocProvider.of<CartItemBloc>(context).add( CartAdd(data: FetchCategoryProduct(id: e.id), u_id: list_cart_item.first.user??"0", varid: e.varId!,quantity: int, membered_user: checkoutValueController.value.value.is_membered_user??"0", idtype: IDType.variation));
                                  }
                                })).toList(),),
                              ),
                            ],
                          );
                        },
                      ),
                    ]
                )
            ),
          ),
        )
      //Text("abc"),
    );
  }
}
