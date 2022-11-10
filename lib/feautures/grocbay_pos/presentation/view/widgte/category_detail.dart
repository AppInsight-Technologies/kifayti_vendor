import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/util/calculations/cartcalculations.dart';
import '../../../../../core/util/presentation/controller/onpress_controller.dart';
// import '../..//feautures/grocbay_pos/domain/entities/fetch_category_product.dart';
// import '../..//feautures/grocbay_pos/presentation/bloc/cart/cart_bloc.dart';
// import '../..//feautures/grocbay_pos/presentation/bloc/homepage/product/product_bloc.dart';
// import '../..//generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../../core/util/presentation/controller/global_focus.dart';
import '../../../../../core/util/presentation/controller/scroll_controller.dart';
import '../../../../../core/util/presentation/styles/screen_size_rario.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/fetch_category_product.dart';
import '../../../domain/entities/fetch_subcategory.dart';
import '../../bloc/homepage/product/product_bloc.dart';
import '../component/variation_drawer.dart';
import 'dailog/alert _dailog.dart';


class CategoryProducts extends StatefulWidget {
  final GlobalKey<ScaffoldState>? skey;
  // final ValueListnabelController<FetchCategoryProduct> conpressproduct;
  const CategoryProducts({Key? Key,this.skey}) : super(key: Key);

  @override
  _CategoryProductsState createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  var myDynamicAspectRatio = 1000/1;
  bool is_draweropen = false;

  List<FetchCategoryProduct> _data = [];
  bool endlist = false;
  bool isLoading = false;

  FetchSubCategory catId = FetchSubCategory();

  bool all = false;

  @override
  void initState() {
    // TODO: implement initState
    productscrollcontroller.addListener(()=>pagination(_data,navigatorKey.currentContext));
    // checkoutValueController.addListener(() {
    print("product Listen");
    setState(() {
      checkoutValueController.value.value.is_membered_user = checkoutValueController.value.value.is_membered_user;
    });

    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
          padding: const EdgeInsets.only(right: 8.0,bottom: 2),
          child: BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {
              if (state is ProductStateSucsess<List<FetchCategoryProduct>>) {
                catId = state.subcat;
                all = state.all;
              }

              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is ProductStateInitial) {
                return const SizedBox.shrink();
              }
              if (state is ProductStateLoading) {
                if(!state.ispaginated) {
                  return  Center(child: Text(S.of(context).category_product),);
                }
              }
              if (state is ProductStateSucsess<List<FetchCategoryProduct>>) {
                print("product loaded");
                if(state.ispaginated){
                  if(state.data.isEmpty){
                    endlist = true;
                  }
                  _data.addAll(state.data);
                }else{
                  _data = state.data;
                }
              } /*else {
                return const SizedBox.shrink();
              }*/
              // checkoutValueController.value.addListener(() {
              //   _data = _data;
              // });
              if(_data.isEmpty){
                return  Center(child: Text(S.of(context).No_order_found),);
              }else {
                return ValueListenableBuilder<CheckoutModel>(
                  builder: (BuildContext context, CheckoutModel checkoutModel, widget) {
                    print("member:${checkoutModel.is_membered_user}");
                    return Padding(
                      padding: const EdgeInsets.only(left: 25.0,right: 8.0,bottom: 8),
                      child: Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        children: [
                          ..._data.map((e) => Padding(
                            padding: const EdgeInsets.only(left: 0.0,right: 18.0,bottom: 8),
                            child: SizedBox(
                              width: 170,
                              height: 190,
                              child: GestureDetector(
                                  onTap: () {
                                    print("tapped");
                                    if (sl<SharedPreferences>().getBool(Prefrence.showSearchbar)??false ) {
                                    setState(() {
                                      if( LayoutView(context).isWeb || LayoutView(context).isTab){
                                        showDialog(context: context, builder: (context){
                                          return   Dialog(
                                            child: VariationDialog(e,context),
                                          );
                                        });
                                      }else{
                                        showBottomSheet(context: context,
                                            builder: (context) {
                                              return Center(child: VariationDialog(e,context));
                                            });
                                      }

                                      // widget.skey!.currentState!
                                      //     .openEndDrawer();
                                      // productValueController.value.value = e;
                                    });
                                    }else{
                                      print("tapped..");
                                      FocusN.f_usersearch.requestFocus();
                                    }
                                    //Scaffold.of(context).openDrawer();
                                  },
                                  child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        //border: Border.all(color:Colors.grey)
                                      ),
                                      alignment: Alignment.center,
                                      child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child:Center(
                                                child: CachedNetworkImage(
                                                  imageUrl: e.itemFeaturedImage!,
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                      downloadProgress) =>
                                                      Image.asset("assets/images/default_category.png"),
                                                  errorWidget:
                                                      (context, url, error) {
                                                    print("error img :$url");
                                                    return Image.asset("assets/images/default_category.png");
                                                  },
                                                  height: 80,),
                                              ),
                                            ),
                                            // CachedNetworkImage(
                                            //   imageUrl: e.itemFeaturedImage!,
                                            // ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(left: 8,right: 8.0),
                                              child: SizedBox(
                                                height: 40,
                                                child: Text(

                                                  e.itemName.toString(),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.normal),
                                                ),
                                              ),
                                            ),
                                            if(e.type=='0')
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0,
                                                          right: 8.0),
                                                      child: Container(
                                                          decoration:
                                                          const BoxDecoration(
                                                            color:
                                                            Color(0XFFFCFCFC),
                                                            //border: Border.all(color:Colors.grey)
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                10.0),
                                                            child: Text(
                                                              ( e.priceVariation?[0].variationName??e.weight).toString() +
                                                                  " " + (e.priceVariation?[0]
                                                                  .unit??"/ ${e.unit}")
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                color: Colors
                                                                    .green,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          )),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.all(8.0),
                                              child: Row(
                                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Text(
                                                        IConstants.currencyFormat +
                                                            ((checkoutModel.is_membered_user==null || checkoutModel.is_membered_user=="0")?(e.priceVariation?[0].price??e.price):((e.priceVariation?[0].membershipPrice??e.membershipPrice)! > 0) ? (e.priceVariation?[0].membershipPrice??e.membershipPrice) : (e.priceVariation?[0].price??e.price)).toString(),
                                                        textAlign:
                                                        TextAlign.right,
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [

                                                      // const SizedBox(width: 30),
                                                      if((e.priceVariation?[0].mrp??e.mrp)!=((checkoutModel.is_membered_user==null || checkoutModel.is_membered_user=="0")?(e.priceVariation?[0].price??e.price):((e.priceVariation?[0].membershipPrice??e.membershipPrice)! > 0) ? (e.priceVariation?[0].membershipPrice??e.membershipPrice) : (e.priceVariation?[0].price??e.price)))
                                                        Text(
                                                          " ₹" + (e.priceVariation?[0].mrp??e.mrp).toString(),
                                                          style: const TextStyle(
                                                              color: Colors.grey,
                                                              fontSize: 10,
                                                              decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                              decorationColor:
                                                              Colors.grey,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                        ),
                                                      Text( ' ${e.type=='1'?'/${e.unit}':''}',
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ]))),
                            ),
                          )),
                        ],
                      ),
                    );
                  }, valueListenable: checkoutValueController.value,
                );
              }
            },
          )),
    );
  }

  void pagination(List<FetchCategoryProduct> data,context) {
    if ((productscrollcontroller.position.pixels == productscrollcontroller.position.maxScrollExtent) && (!endlist)) {
      BlocProvider.of<ProductBloc>(context).add( ProductPagination(catId,all?1:0,start: _data.length));
    }
  }
}