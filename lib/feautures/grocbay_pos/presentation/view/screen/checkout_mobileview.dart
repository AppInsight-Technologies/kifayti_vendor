import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/calculations/cartcalculations.dart';
import '../../../../../core/util/presentation/controller/global_focus.dart';
import '../../../../../core/util/presentation/controller/onpress_controller.dart';
import '../../../../../core/util/presentation/styles/screen_size_rario.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/cart_item_modle.dart';
import '../../../domain/entities/fetch_category_product.dart';
import '../../../domain/entities/get_profile_modle.dart';
import '../../../domain/entities/search_user_modle.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../../bloc/customers/userprofile_bloc.dart';
import '../../bloc/homepage/category/category_bloc.dart';
import '../../bloc/search/search_bloc.dart';
import '../component/checkout_orderlist2.dart';
import '../component/checkoutpopup.dart';
import '../widgte/create_profilepopup.dart';
import '../widgte/custom_stepper.dart';
import '../widgte/customer/customer_profile_button.dart';
import '../widgte/dailog/alert _dailog.dart';
import '../widgte/search_bar.dart';


class CheckoutMobileView extends StatefulWidget {
  //final GlobalKey<ScaffoldState>? s_key;
  // ValueListnabelController<CheckoutModel> _checkoutvalcontroller;
  CheckoutMobileView( {Key? Key,}) : super(key: Key);

  @override
  _CheckoutMobileViewState createState() => _CheckoutMobileViewState();
}

class _CheckoutMobileViewState extends State<CheckoutMobileView>  {
  PageController pageViewController = PageController(initialPage: 0);
  PageController _controller = PageController(initialPage: 0);

  List<CartItemModel> list_cart_item = [];
  CartCalculationsState cal = new CartCalculationsState();
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
      print("xxv");
      checkoutValueController.value.value.paymentType = pageViewController.page==0?"COD": pageViewController.page==1?"SOD":"Online";
    });
/*    checkoutValueController.value.addListener(() {
      print("listning");
      checkoutValueController.value.value.total_discount = cal.calculateTotalDiscount(list_cart_item);
      checkoutValueController.value.value.total_tax = cal.calculateTotalTax(list_cart_item);
      checkoutValueController.value.value.total_paybleamount = cal.calculateTotalAmount(list_cart_item);
      checkoutValueController.value.value.totalMRP = cal.calculateTotalMRP(list_cart_item);
      // BlocProvider.of<LoyaltyBloc>(context).add( OnCheckLoyalty(branch: '4', user_point: checkoutValueController.value.value.loyaltyamount??"0", total: cal.calculateTotalAmount(list_cart_item),lenable:checkoutValueController.value.value.is_loyalty));
    });*/
    return Scaffold(
        backgroundColor: Colors.white,
        // bottomNavigationBar:

        // ),
        appBar: PreferredSize(preferredSize: const Size.fromHeight(100),child: Column(
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
                return Padding(
                  padding: const EdgeInsets.only(top:15.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: BlocProvider<SearchBloc>(
                          create: (context) => sl<SearchBloc>(),
                          child: SearchBar<SearchUser>((query,context){
                            print("query: $query");
                            BlocProvider.of<SearchBloc>(context).add(OnSearch(query, SearchType.user));
                          },focus: FocusN.f_usersearch,
                              onSubmit: (e) {
                                print("ontapped ");
                                BlocProvider.of<UserProfileBloc>(context).add(OnUserProfile(e?.uId??''));
                                if(!FocusN.f_product_search.hasFocus) {
                                  FocusN.f_product_search.requestFocus();
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
                              ),hintText: S.of(context).find_customer,type:SearchType.user,style: SearchBarStyle(iconalign: IconAlign.ending,contentPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 11),decoration: BoxDecoration(
                                color:Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ))),
                        ),
                      ),
                      GestureDetector(onTap: ()=>  {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular((5)),
                              color: Colors.grey.shade200,
                            ),
                            padding: const EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () {
                                showBottomSheet(context: context,
                                    builder: (context) {
                                      return CreateProfile();
                                    });
                              },
                              child: Row(
                                children:
                                 [Icon(Icons.add,color: Colors.black,size:12),
                                  Text(S.of(context).add_customer,style: TextStyle(color: Colors.black,fontSize:10,fontWeight: FontWeight.bold),)],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [

                    Expanded(
                      flex: 4,
                      child: BlocConsumer<CartItemBloc, CartState>(
                        listener: (context, state) {
                        },
                        builder: (context, state) {
                          return ListView(
                            scrollDirection: Axis.vertical,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CartItemList(_controller,tabs: list_cart_item.map((e) => CartItemData(u_id: list_cart_item.first.user!,p_id: e.varId!,steppr: e.type =="1"?SteppersType.sku:SteppersType.multy,quantity: e.quantity,p_name: e.itemName!,balance: double.parse(((checkoutValueController.value.value.is_membered_user==null||checkoutValueController.value.value.is_membered_user=="0")?e.price:(double.parse(e.membershipPrice!) > 0) ? e.membershipPrice : e.price).toString()), v_name: "${e.varName} ${e.type}", cartstepper: (int ) {
                                  if(int == 0){
                                    BlocProvider.of<CartItemBloc>(context).add(CartRemove(u_id:  list_cart_item.first.user!,varid: e.varId!));
                                  }else {
                                    BlocProvider.of<CartItemBloc>(context).add( CartAdd(data: FetchCategoryProduct(id: e.id), u_id: list_cart_item.first.user??"0", varid: e.varId!,quantity: int, membered_user: checkoutValueController.value.value.is_membered_user!, idtype: IDType.variation));
                                  }
                                })).toList(),),
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BlocConsumer<CartItemBloc, CartState>(
                            listener: (contextx, state) {
                              if(state is CartStateSucsess<List<CartItemModel>>){
                                list_cart_item = state.data;
                                // BlocProvider.of<LoyaltyBloc>(context).add( OnCheckLoyalty(branch: '4', user_point: checkoutValueController.value.value.loyaltyamount??"0", total: cal.calculateTotalAmount(state.data),lenable:checkoutValueController.value.value.is_loyalty));
                              }
                              // TODO: implement listener
                            },
                            builder: (context, states) {

                              // return Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(5),
                              //       color: Colors.grey[200],
                              //     ),
                              //     child: list_cart_item.length>0 ? Column(
                              //       children: [
                              //         Padding(
                              //           padding: const EdgeInsets.all(8.0),
                              //           child: Row(
                              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //               children:[
                              //                 const Text("Discount",style: TextStyle(color: Colors.grey,fontSize:10,fontWeight: FontWeight.bold)),
                              //
                              //                 Text("₹${ widget._checkoutvalcontroller.value.value.total_discount??0 }",style: const TextStyle(color: Colors.grey,fontSize:10,fontWeight: FontWeight.bold)),
                              //               ]),
                              //         ),
                              //         Padding(
                              //           padding: const EdgeInsets.all(8.0),
                              //           child: Row(
                              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //               children:[
                              //                 const Text("Tax",style: TextStyle(color: Colors.grey,fontSize:10,fontWeight: FontWeight.bold)),
                              //                 Text("₹${widget._checkoutvalcontroller.value.value.total_tax??0 }",style: const TextStyle(color: Colors.grey,fontSize:10,fontWeight: FontWeight.bold)),
                              //               ]),
                              //         ),
                              //         BlocConsumer<LoyaltyBloc, LoyaltyState>(
                              //           listener: (context, state) {
                              //             // TODO: implement listener
                              //           },
                              //           builder: (context, state) {
                              //
                              //             if(state is LoyaltySucsess<String>){
                              //               totalamount = state.data;
                              //
                              //             }
                              //             if(widget._checkoutvalcontroller.value.value.is_wallet == true){
                              //               print("hereqq");
                              //               totalamount = (double.parse(totalamount) - double.parse(widget._checkoutvalcontroller.value.value.walletamount!)).toString();
                              //             }
                              //             widget._checkoutvalcontroller.value.value.total_discount = cal.calculateTotalDiscount(list_cart_item);
                              //             widget._checkoutvalcontroller.value.value.total_tax = cal.calculateTotalTax(list_cart_item);
                              //             widget._checkoutvalcontroller.value.value.total_paybleamount = cal.calculateTotalAmount(list_cart_item);
                              //
                              //
                              //             return Padding(
                              //               padding: const EdgeInsets.all(8.0),
                              //               child: Row(
                              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //                   children:[
                              //                     const Text("Payable Amount",style: TextStyle(color: Colors.black,fontSize:12,fontWeight: FontWeight.bold)),
                              //
                              //                     Text("₹${totalamount}",style: const TextStyle(color: Colors.black,fontSize:12,fontWeight: FontWeight.bold)),
                              //                   ]),
                              //             );
                              //           },
                              //         ),
                              //
                              //       ],
                              //     ):const SizedBox.shrink(),
                              //   ),
                              // );
                              return BlocBuilder<UserProfileBloc, UserProfileState>(
                                builder: (context, state) {
                                  return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: MaterialButton(height: 60,onPressed: (){
                                        if(state is UserProfileSucsess<GetCustomerProfile>) {
                                          checkoutValueController.value.value.is_membered_user = state.data.data!.first.membership;
                                          if(list_cart_item.isNotEmpty) {
                                            checkoutValueController.value.value.apiKey = state.data.data!.first.apiKey;

                                            // if (LayoutView(context).isWeb || LayoutView(context).isTab) {
                                            // return Dialog(
                                            //     child: CHeckOutPopup(
                                            //         list_cart_item, state.data));
                                            // return Dialog(
                                            //     child: CHeckOutPopup(
                                            //         list_cart_item, state.data));
                                            showBottomSheet(context: context,
                                                builder: (context) {
                                                  return Center(
                                                    child: CHeckOutPopup(
                                                        list_cart_item, state.data),
                                                  );
                                                });




                                          }else{
                                            Alert().showallert(context,messege: S.of(context).please_select_user);
                                          }
                                        }
                                        else{
                                          //print(state.e);
                                          Alert().showallert(context,messege: S.of(context).please_select_user);

                                        }
                                      },color: Colors.green,
                                          child:  Center(
                                              child: Text(S.of(context).proceed,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),))
                                      )
                                  );
                                },
                              );
                            },
                          ),
                          // TODO: Navigator Tab Has Been Changed need to fix this
                        ],
                      ),
                    ),
                  ]
              )
          ),
        )
      //Text("abc"),
    );
  }
}