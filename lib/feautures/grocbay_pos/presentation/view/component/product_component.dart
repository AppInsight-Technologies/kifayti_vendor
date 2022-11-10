import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../../core/util/presentation/controller/global_focus.dart';
import '../../../../../core/util/presentation/controller/onpress_controller.dart';
import '../../../../../core/util/presentation/controller/scroll_controller.dart';
import '../../../../../core/util/presentation/styles/screen_size_rario.dart';
import '../../../../../core/util/scanner/barcode_listner.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/Fetch_category.dart';
import '../../../domain/entities/cart_item_modle.dart';
import '../../../domain/entities/fetch_category_product.dart';
import '../../../domain/entities/fetch_subcategory.dart';
import '../../../domain/entities/search_user_modle.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../../bloc/homepage/category/category_bloc.dart';
import '../../bloc/search/search_bloc.dart';
import '../../rought_genrator.dart';
import '../screen/checkout_mobileview.dart';
import '../widgte/category_detail.dart';
import '../widgte/custome_tab_view.dart';
import '../widgte/dailog/alert _dailog.dart';
import '../widgte/default_categories.dart';
import '../widgte/products/product_category.dart';
import '../widgte/search_bar.dart';
import 'checkout.dart';
import 'variation_drawer.dart';
import 'package:badges/badges.dart';

class Product extends StatefulWidget {
  final GlobalKey<ScaffoldState>? s_key;

  // ValueListnabelController<FetchCategoryProduct> _conpressproduct;
  Product( {Key? Key,this.s_key}) : super(key: Key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> with Navigations{
  PageController tabcontroller = PageController(initialPage: 0);
  bool search_status = false;
  final GlobalKey<ScaffoldState> _sc_key = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<CategoryBloc>(context).add(const CategoryEventInitial());

    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    FocusN.f_product_search.addListener(() {
      debugPrint("inside product focus"+sl<SharedPreferences>().getBool(Prefrence.showSearchbar).toString());
      if(sl<SharedPreferences>().getBool(Prefrence.showSearchbar)??false ){

      }else{
        FocusN.f_usersearch.requestFocus();
      }

      print("focus set product${FocusN.f_product_search.hasFocus}");
      print("focus set user${FocusN.f_usersearch.hasFocus}");
      print("focus set order${FocusN.f_order_search.hasFocus}");
      print("focus set quantity${FocusN.f_quantity_variation.hasFocus}");

    });
    return Scaffold(
      key: navigatorKey,
      backgroundColor: const Color(0xFFF3F3F3),
      floatingActionButton: customfloatingbutton(), // This trailing comma makes auto-formatting nicer for build methods.

      appBar: PreferredSize(preferredSize:  Size.fromHeight(LayoutView(context).isMobile?100:60),child:SearchBar<FetchCategoryProduct>((query,context){
        BlocProvider.of<SearchBloc>(context).add(OnSearch(query, SearchType.product));
      },empty: const Text("No Matches found....",style: TextStyle(
          color: Colors.black
      )),
          focus: FocusN.f_product_search,
          onSubmit: (e){
            // widget.s_key!.currentState!.openEndDrawer();
            // productValueController.value.value = e;
            print("search submit..."+sl<SharedPreferences>().getBool(Prefrence.showSearchbar).toString());

             if (e != null) {
               if (LayoutView(context).isWeb || LayoutView(context).isTab) {
                 showDialog(context: context, builder: (context) {
                   return Dialog(
                     child: VariationDialog(e, context),
                   );
                 });
               } else {
                 showBottomSheet(context: context,
                     builder: (context) {
                       return Center(child: VariationDialog(e, context));
                     });
               }
             }

          },
          listdata: (e,index,active) {
            debugPrint("hgj..."+e.toString()+" .."+index.toString()+"...."+active.toString());
            return ValueListenableBuilder(
              builder: (BuildContext context, CheckoutModel checkoutModel, Widget) {
                debugPrint("member:${checkoutModel.is_membered_user}");
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8),
                  child: Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: e.itemFeaturedImage!,
                        progressIndicatorBuilder:
                            (context, url,
                            downloadProgress) =>  Image.asset("assets/images/default_category.png"),
                        errorWidget:
                            (context, url, error) {
                          print("error img :$url");
                          return Image.asset("assets/images/default_category.png");
                        },
                        height: 40,
                        width: 50,
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("${e.itemName}",style:  TextStyle(color: (active)?Colors.green: Colors.black)),
                              Text("${e.type=='1'?'': "-"+( e.priceVariation?[0].variationName??e.weight).toString() +
                                  " " + (e.priceVariation?[0]
                                  .unit??"/ ${e.unit}")
                                  .toString()}  ",style:  TextStyle(color: (active)?Colors.green: Colors.black)),

                            ],
                          ),
                        //  Text("${e.brand}",style:  TextStyle(color:  (active)?Colors.green: Colors.black)),
                        ],
                      ),
                      Text(e.type=='0'?'': "-" +e.weight! + e.unit!,style:  TextStyle(color: (active)?Colors.green: Colors.black)),

                      Spacer(),
                      Text(IConstants.currencyFormat +
                          ((checkoutModel.is_membered_user==null || checkoutModel.is_membered_user=="0")?(e.priceVariation?[0].price??e.price)
                              :((e.priceVariation?[0].membershipPrice??e.membershipPrice)! > 0) ? (e.priceVariation?[0].membershipPrice??e.membershipPrice) : (e.priceVariation?[0].price??e.price)).toString()
                          /* + e.type! == "1"?"/ ${e.unit}" :""*/,
                          style:  TextStyle(color:  (active)?Colors.green: Colors.black)),
                      SizedBox(width: 15,)
                    ],
                  ),
                );
              }, valueListenable: checkoutValueController.value,
            );
            },
          searchstatus:(iseSearching){
            debugPrint("iseSearching..."+iseSearching.toString());
              if (sl<SharedPreferences>().getBool(Prefrence.showSearchbar)??false ) {
                        // if(!search_status){
                        //   // BlocProvider.of<CategoryBloc>(context).add(const CategoryEventInitial());
                        // }
                        search_status = iseSearching;
              }else{
                search_status = iseSearching;
              }
          },
          listnsearch: (users){
            debugPrint("iseSearching1..."+users.toString());
            // BlocProvider.of<ProductBloc>(context).add(OnProductGet(users as List<FetchCategoryProduct>));

          },
          hintText: S.current.search_for_prod,//"Search For Products",
          type:SearchType.product,
          style: SearchBarStyle(iconalign: IconAlign.ending,
              contentPadding:  EdgeInsets.symmetric(horizontal: LayoutView(context).isMobile? 15:10,
                  vertical:  LayoutView(context).isMobile?11:8),
              decoration: BoxDecoration(
            color:Colors.white,
            borderRadius: BorderRadius.circular(8),
          ))),
      ),
      body: BarCodeListner(
        listen: (code ) {
          if(code!="") {
            print("Barcode number:$code}");
            BlocProvider.of<CartItemBloc>(context).add(CartAdd(u_id: checkoutValueController.value.value.apiKey.toString(),
                data: FetchCategoryProduct(),varid: code,quantity: 1, membered_user:checkoutValueController.value.value.is_membered_user??"0",
                idtype: IDType.barcode));
          }

        },
        child: SingleChildScrollView(
          controller: productscrollcontroller,
          child:Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: Row(
                    children: [
                      if(!search_status)
                        const Expanded(child: Category(),),
                      if(!search_status)
                        const Expanded(child: SubCategories()),
                    ],
                  ),
                ),
                CategoryProducts(skey:widget.s_key)
              ]
          ),

        ),
      )
    );
  }

  customfloatingbutton() {
    String cartCount = '0';
    debugPrint("cartcount initially "+cartCount.toString());

    return  (LayoutView(context).isMobile) ? BlocBuilder<CartItemBloc, CartState>(

      builder: (context, state) {

        if(state is CartStateSucsess<List<CartItemModel>>){
          cartCount = state.data.length.toString();
          debugPrint("cartcount"+cartCount.toString());
        }
        else{
          debugPrint("inside else cartcount");
        }
        return Badge(
          badgeColor:  Colors.green,
          borderRadius: BorderRadius.circular(40),
          badgeContent:  Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              cartCount,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: (){
              print("clicked");
              Navigation(context, navigatore: NavigatoreTyp.push,name: Routename.CheckoutMobile);

            },
            tooltip: 'show cart',
            child: const Icon(Icons.shopping_cart_outlined),
          ),
        );

      },
    ):const SizedBox.shrink();


  }
}
