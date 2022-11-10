import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../../../../core/util/presentation/styles/screen_size_rario.dart';

import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../../../../../../core/util/presentation/controller/onpress_controller.dart';
import '../../../../../../../core/util/presentation/controller/scroll_controller.dart';
import '../../../../../../core/util/presentation/controller/onpress_controller.dart';
import '../../../../../../core/util/presentation/controller/scroll_controller.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../domain/entities/fetch_category_product.dart';
import '../../../../domain/entities/fetch_subcategory.dart';
import '../../../bloc/homepage/product/product_bloc.dart';
import '../../../rought_genrator.dart';
import '../dailog/alert _dailog.dart';

class CatProducts extends StatefulWidget {
  const CatProducts({Key? key}) : super(key: key);

  @override
  _CatProductsState createState() => _CatProductsState();
}

class _CatProductsState extends State<CatProducts> with Navigations{
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
   return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          // Padding(
          //   padding:  EdgeInsets.only(right: 10.0),
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.end,
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //
          //       SizedBox(width: 10,),
          //       GestureDetector(
          //         behavior: HitTestBehavior.translucent,
          //         onTap: (){
          //           Navigation(context, navigatore: NavigatoreTyp.push,name: Routename.EditVendorProduct,qparms: {
          //             "fromScreen":"AddProduct"
          //           });
          //         },
          //         child: Container(
          //           height: 45,
          //           width: 200,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular((25.0)),
          //             border: Border.all(color:Theme.of(context).primaryColor,),
          //           ),
          //           child: Center(child: Text("Add Product", style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w700,fontSize: 16),)),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(height: 10,),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            //height:150,
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
                   // return const Center(child: Text("Category Product Loading..."),);
                    return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor),);
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
                  return const Center(child: Text("No Product"),);
                }else {
                  return ValueListenableBuilder(
                    builder: (BuildContext context, CheckoutModel checkoutModel, Widget) {
                      print("member:${checkoutModel.is_membered_user}");
                      return Wrap(
                        direction: Axis.vertical,
                        alignment: WrapAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               /* Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children:[
                                        Expanded(flex:4,  child: Row(
                                      mainAxisAlignment:MainAxisAlignment.start,
                                          children: const [
                                            Text('Item',style:TextStyle(color: Colors.grey)),
                                          ],
                                        ),),
                                        Expanded(flex: 4, child:Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,children: [
                                          const Text('Amount',style:TextStyle(color: Colors.grey)),
                                          const Text('Item Available',style:TextStyle(color: Colors.grey)),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: const [
                                              Text('Edit',style:TextStyle(color: Colors.grey)),
                                            ],
                                          ),
                                        ],))

                                      ]

                                  ),
                                ),*/
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text('${catId.categoryName}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.black),),
                                      Center(child: Text('('+_data.length.toString() +' Items)', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black12),))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ..._data.map((e) => SizedBox(
                            height:120,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                decoration: const BoxDecoration( //                    <-- BoxDecoration
                                 border: Border(bottom: BorderSide(color: Colors.grey,width:0.5)),

                                ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Expanded(flex:4, child:
                                        GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          onTap: (){
                                            Navigation(context, navigatore: NavigatoreTyp.push,name: Routename.EditVendorProduct,qparms: {
                                              "product":json.encode(e),
                                              "fromScreen":"editProduct"
                                            });
                                          },
                                          child: Row(children: [
                                            CachedNetworkImage(
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
                                              height: 80,
                                              width: 80,
                                            ),
                                            SizedBox(width: 15,),
                                            Vx.isWeb?
                                            Padding(
                                              padding:
                                              const EdgeInsets.all(8.0),
                                              child: Text(
                                                e.itemName.toString(),

                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ):
                                                Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        e.itemName.toString(),
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                            FontWeight.bold),
                                                      ),
                                                      SizedBox(height: 5,),
                                                      Text(
                                                        IConstants.currencyFormat+
                                                            ((checkoutModel.is_membered_user==null || checkoutModel.is_membered_user=="0")?(e.priceVariation?[0].price??e.price):((e.priceVariation?[0].membershipPrice??e.membershipPrice)! > 0) ? (e.priceVariation![0].membershipPrice??e.membershipPrice) : (e.priceVariation![0].price??e.price)).toString(),
                                                        textAlign:
                                                        TextAlign.right,
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.bold),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                          ],),
                                        )),
                                        (LayoutView(context).isMobile )?
                                        Column(
                                          children: [
                                            Transform.scale(
                                              scale: 0.6,
                                              child: CupertinoSwitch(
                                                activeColor: Theme.of(context).primaryColor,
                                                value: e.isActive??false,
                                                onChanged: (bool value) {
                                                  setState(() {
                                                    e.isActive = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          /*  SizedBox(height: 8,),
                                            GestureDetector(
                                              behavior: HitTestBehavior.translucent,
                                              onTap: () {
                                                print("edit product tapped");
                                                Navigation(context, navigatore: NavigatoreTyp.push,name: Routename.EditVendorProduct,qparms: {
                                                  "product":json.encode(e),
                                                  "fromScreen":"editProduct"
                                                });
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children:  [
                                                  Icon(Icons.edit_outlined,color: Theme.of(context).primaryColor,size: 14,),
                                                  Text('Edit',style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 14,fontWeight: FontWeight.bold),),
                                                ],
                                              ),
                                            )*/
                                          ],
                                        )
                                            :
                                        Expanded(flex:4,child:Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,children:[
                                         Text(
                                            IConstants.currencyFormat +
                                                ((checkoutModel.is_membered_user==null || checkoutModel.is_membered_user=="0")?(e.priceVariation?[0].price??e.price):((e.priceVariation?[0].membershipPrice??e.membershipPrice)! > 0) ? (e.priceVariation![0].membershipPrice??e.membershipPrice) : (e.priceVariation![0].price??e.price)).toString(),
                                            textAlign:
                                            TextAlign.right,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Transform.scale(
                                            scale: 0.6,
                                            child: CupertinoSwitch(
                                              value: e.isActive??false,
                                              onChanged: (bool value) {
                                                setState(() {
                                                  e.isActive = value;
                                                });
                                              },
                                            ),
                                          ),
                                          (LayoutView(context).isWeb || LayoutView(context).isTab)?   GestureDetector(

                                              onTap: () {
                                              print("edit product tapped");
                                              Navigation(context, navigatore: NavigatoreTyp.push,name: Routename.EditVendorProduct,qparms: {
                                                "product":e.toString(),
                                                "fromScreen":"editProduct"
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: const [
                                                Icon(Icons.edit_outlined,color: Colors.green,size: 12,),
                                                Text('Edit',style: TextStyle(color: Colors.green,fontSize: 12,fontWeight: FontWeight.bold),),
                                              ],
                                            ),
                                          ):SizedBox.shrink()
                                        ],)),
                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          )),
                        ],
                      );
                    }, valueListenable: checkoutValueController.value,
                  );
                }
              },
            ),
          ),
          SizedBox(height: 70,)
        ]


      );

  }

  void pagination(List<FetchCategoryProduct> data,context) {
    if ((productscrollcontroller.position.pixels == productscrollcontroller.position.maxScrollExtent) && (!endlist)) {
      BlocProvider.of<ProductBloc>(context).add( ProductPagination(catId,all?1:0,start: _data.length));
    }
  }
}
