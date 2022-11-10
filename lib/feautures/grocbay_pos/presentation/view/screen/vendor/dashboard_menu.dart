import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../../../../../core/util/presentation/controller/global_focus.dart';

import '../../../../../../core/util/presentation/controller/scroll_controller.dart';
import '../../../../../../core/util/presentation/styles/screen_size_rario.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../domain/entities/Fetch_category.dart';
import '../../../../domain/entities/fetch_category_product.dart';
import '../../../bloc/homepage/category/category_bloc.dart';
import '../../../bloc/homepage/product/product_bloc.dart';
import '../../../bloc/homepage/subcategory/subCategory_bloc.dart';
import '../../../bloc/search/search_bloc.dart';
import '../../../bloc/searchBarcode/search_barcode_bloc.dart';
import '../../../rought_genrator.dart';
import '../../widgte/custome_tab_view.dart';
import '../../widgte/dailog/alert _dailog.dart';
import '../../widgte/default_categories.dart';
import '../../widgte/gridview/CatProducts.dart';
import '../../widgte/products/product_category.dart';
import '../../widgte/search_bar.dart';
class DashboardMenu extends StatefulWidget {
  const DashboardMenu({Key? key}) : super(key: key);

  @override
  _DashboardMenuState createState() => _DashboardMenuState();
}

class _DashboardMenuState extends State<DashboardMenu>  with Navigations {
  bool search_status = false;
  PageController tabcontroller = PageController(initialPage: 0);

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<CategoryBloc>(context).add(const CategoryEventInitial());

    super.initState();
  }
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);

      debugPrint("barcodeScanRes..."+barcodeScanRes.toString());
      if(barcodeScanRes == "-1"){

      }else {
        BlocProvider.of<SearchBarcodeBloc>(context).add(
            OnSearchBarcode(barcodeScanRes));
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

  }
  @override
  Widget build(BuildContext context) {
    FocusN.f_product_search.addListener(() {
      print("focus set ${FocusN.f_product_search.hasFocus}");
      // setState(() {});
    });
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize:  Size.fromHeight(LayoutView(context).isMobile?50:60),child:
      Stack(
        children: [
          Padding(
            padding:  EdgeInsets.only(left: 10.0,right: LayoutView(context).isMobile?50:0),
            child: SearchBar<FetchCategoryProduct>(
                  (query,context){
              BlocProvider.of<SearchBloc>(context).add(OnSearch(query, SearchType.product));
            },focus: FocusN.f_product_search,
                onSubmit: (e){

                  },
                listdata: (e,index,active)=>Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8),
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: (){
                      Navigation(context, navigatore: NavigatoreTyp.push,name: Routename.EditVendorProduct,qparms: {
                        "product":json.encode(e),
                        "fromScreen":"editProduct"
                      });
                    },
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
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${e.itemName}",style:  TextStyle(color: (active)?Colors.green: Colors.black)),
                            Text("${e.brand}",style:  TextStyle(color:  (active)?Colors.green: Colors.black)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                searchstatus:(iseSearching){
                  if(!search_status){
                    BlocProvider.of<CategoryBloc>(context).add(const CategoryEventInitial());
                  }
                  search_status = iseSearching;
                },
                listnsearch: (users){
                  BlocProvider.of<ProductBloc>(context).add(OnProductGet(users as List<FetchCategoryProduct>));

                },
                hintText: S.of(context).search_for_prod,
                type:SearchType.product,
                style:
                SearchBarStyle(iconalign: IconAlign.ending,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 11),
                    decoration: BoxDecoration(
                      color:Color(0xffF5F5F5),
                  borderRadius: BorderRadius.circular(8),
                )),
              errorText: S.of(context).no_product,
            ),
          ),
          Positioned(
            right: 0,
              child:  BlocListener<SearchBarcodeBloc,SearchBarcodeState>(
                listener: (context, state) {
                  print("moved inside.....1"+state.toString());
                  if(state is SearchBarcodeLoading){
                    Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,));
                  }
                  else if(state is SearchBarcodeSucsess){
                    print("moved inside....."+state.toString());
                    Navigation(context, navigatore: NavigatoreTyp.push,name: Routename.EditVendorProduct,qparms: {
                      "product":json.encode(state.data),
                      "fromScreen":"searchBarcode"
                    });
                    //  return BlocProvider.of<UpdateOrderBloc>(context).add(OnUpdateOrderEvent(widget.value['oid']));

                  }else{
                    Alert().showallert(
                        context, messege: "Barcode doesn't match");
                  }
                },
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: (){
                    scanBarcodeNormal();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0,right: 25),
                    child: Column(children: [
                      Image.asset("assets/icons/scanbarcode.png",width: 20,height: 20,color: Colors.black),
                      // Text(S.of(context).Print, style: TextStyle(
                      //   color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold,))
                    ]),
                  ),
                ),
              ),)
        ],
      ),

      ),
      body: SingleChildScrollView(
        controller: productscrollcontroller,
        child:Column(
            children: [
                // BlocConsumer<CategoryBloc, CategoryState>(
                //   listener: (context, state) {
                //     // TODO: implement listener
                //     if(state is CategoryStateSucsess<List<CategoryFetch>>)
                //     {
                //       BlocProvider.of<SubcategoryBloc>(context).add( SubcategoryEventInitial(int.parse(state.data.first.id!)));
                //     }
                //   },
                //   builder: (context, state) {
                //     if(state is CategoryStateInitial){
                //       return SizedBox.shrink();
                //     }
                //     if(state == CategoryStateLoading){
                //       return Center(child: Text("Categories Loading..."),);
                //     }
                //     if(state is CategoryStateSucsess<List<CategoryFetch>>){
                //       final _data = state.data ;
                //       print(_data);
                //       return CustomeTabView(tabcontroller,mainAxisAlignment: MainAxisAlignment.start,style: TabStyle(bgcolor: Colors.white),tabs: [
                //         ..._data.map((e) => TabData(ic_name: e.categoryName,icon_id: e.id!),)
                //       ],onTap: (index){
                //         BlocProvider.of<SubcategoryBloc>(context).add( SubcategoryEventInitial(int.parse(_data[index].id!)));
                //       },);
                //     }else{
                //       print("inside else in product screen...");
                //       return SizedBox.shrink();
                //     }
                //
                //   },
                // ),
                // const SubCategories(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    if(!search_status)
                      const Expanded(child: Category(),),
                    if(!search_status)
                      const Expanded(child: SubCategories()),
                  ],
                ),
              ),
              const CatProducts()
            ]
        ),

      ),
      // floatingActionButton: LayoutView(context).isMobile ?
      // Container(
      //   padding: EdgeInsets.only(
      //     left: MediaQuery
      //         .of(context)
      //         .size
      //         .width - 120,
      //     bottom: 140,
      //   ),
      //   //margin: EdgeInsets.all(10),
      //   child: customfloatingbutton(),
      // ):SizedBox.shrink(),
    );
  }

  customfloatingbutton() {
    return  GestureDetector(
      onTap: () {

        Navigation(context, navigatore: NavigatoreTyp.push,name: Routename.EditVendorProduct,qparms: {
          "fromScreen":"AddProduct"
        });
      },
      child: Container(
        margin: EdgeInsets.only(left: 50.0, top: 50.0, bottom: 10.0),
        width: 100,
        height: 70,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Theme
              .of(context)
              .primaryColor,
        ),
        child:   Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.add,color: Colors.white,size: 12),
            Text(S.of(context).add_product,style: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );

  }
}
