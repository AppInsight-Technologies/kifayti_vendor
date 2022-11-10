import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../../core/util/presentation/controller/global_focus.dart';
import '../../../../../core/util/presentation/styles/screen_size_rario.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/pos_ordersearch_model.dart';
import '../../../domain/entities/themedata/dash_page_info.dart';
import '../../bloc/order/order_managment_bloc.dart';
import '../../bloc/search/search_bloc.dart';
import '../../bloc/shop/my_shop_bloc.dart';
import '../../rought_genrator.dart';
import '../widgte/search_bar.dart';
import 'dash_board.dart';

class SearchOrderScreen extends StatefulWidget{
  const SearchOrderScreen({Key? key}) : super(key: key);

  @override
  State<SearchOrderScreen> createState() => _SearchOrderScreenState();
}

class _SearchOrderScreenState extends State<SearchOrderScreen> with Navigations {
  bool search_status = false;
  bool _isShowItem = false;
  bool _isSearchShow = false;
  List<PosOrderSearch> possearch = [];
  FocusNode _focus = new FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<OrderManagmentBloc>(context).add(const FetchOrder(query: '',start: 0));
    _focus.addListener(_onFocusChange);
    super.initState();
  }

  void _onFocusChange() {
    setState(() {
      if (_focus.hasFocus.toString() == "true") {
        _isShowItem = false;
      } else {
        //_isShowItem = false;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _focus.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: (LayoutView(context).isMobile)? AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
           /*IconButton(
               icon: Icon(Icons.arrow_back, color: Colors.black),
               onPressed: () {
                 Navigator.of(context).pop();
             }),*/
            GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
                child: Icon(Icons.arrow_back, color: Colors.black,size: 25,)),
            SizedBox(width: 10,),
            Text(S.of(context).Search_Orders,   style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold),)
          ],
        ),
      ):null,
      body:
      Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _searchContainermobile(),
              _isShowItem? SizedBox(height: 10,):Padding(
                padding: const EdgeInsets.only(top: 20.0,bottom: 10),
                child: Text(S.of(context).Recent_Orders,style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),),
              ),
              BlocListener<SearchBloc,SearchState>(
                listener: (context, state) {
                  print("moved inside.....1"+state.toString());
                  possearch.clear();
                  if(state is SearchLoading){
                    _isShowItem = false;
                     Center(child: CircularProgressIndicator(),);
                  }
                else if(state is SearchSucsess){
                  print("possearch...."+state.data.toString());
                     possearch = state.data;
                     setState(() {
                       _isShowItem = true;
                     });

                     print("possearch....1"+possearch.toString());
                  }
                },
                child: BlocBuilder<OrderManagmentBloc, OrderManagmentState>(
                    builder: (context, state) {

                      if(state is OrderManagmentStateLoading){
                        return Center(child: CircularProgressIndicator());
                      }
                      if(state is OrderManagmentStateSucsess<List<PosOrderSearch>>){

                        return  _isShowItem?viewOrder1(possearch) :viewOrder(state.data);
                      }else{
                        return Container(
                            color: Colors.white,
                            child: Center(child: Image.asset("assets/icons/noorder.png",width: 200,height: 200,))
                        );
                      }

                    }
                ),
              )
            ],
          ),
        ),
      ),


    );
  }

  onSubmit(String value) async {
    BlocProvider.of<SearchBloc>(context).add(OnSearch(value, SearchType.order));
    _isShowItem = true;

  }
  _searchContainermobile() {
    return
      Container(
          padding: EdgeInsets.only(left: 10.0,),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color:Color(0xffF5F5F5),
          ),
          width: MediaQuery.of(context).size.width - 25,
          height: 50.0,
          child: Column(children: <Widget>[

            Container(
              width: MediaQuery.of(context).size.width -25,
              height: 50.0,

              padding: EdgeInsets.only(left: 10.0,),
              child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color:Color(0xffF5F5F5),
                  ),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _isSearchShow? SizedBox.shrink(): Icon(Icons.search,size: 22,
                            color:(LayoutView(context).isWeb || LayoutView(context).isTab)?Color(0xff32B847):Theme.of(context).primaryColor),
                        _isSearchShow? SizedBox.shrink(): SizedBox(width: 15,),
                    Container(
                        width: (MediaQuery.of(context).size.width * 80 / 100) -10,
                        child: TextField(
                            autofocus: true,
                            maxLines: 1,
                            textInputAction: TextInputAction.search,
                            focusNode: _focus,
                            onTap: (){
                              _isShowItem = false;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding:
                              EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 14.0),
                              hintText: S.current.search_by_order,
                              hintStyle:  TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: (LayoutView(context).isWeb || LayoutView(context).isTab)?Color(0xff32B847):Colors.black),
                           //   prefixIcon:   Icon(Icons.search,size: 22,color:(LayoutView(context).isWeb || LayoutView(context).isTab)?Color(0xff32B847):Colors.black),

                            ),
                            onSubmitted: (value) {
                             /*   if(!_issearchloading)
                                  onSubmit(value);
                                else{
                                  FocusScope.of(context).requestFocus(_focus);
                                }*/
                            },
                            onChanged: (String newVal) {
                              setState(() {
                             //   searchValue = newVal;

                                if (newVal.length == 0) {
                                  //_isSearchShow = false;
                                  _isShowItem = false;

                                } else if (newVal.length == 2) {
                                  _isShowItem = false;
                                } else if (newVal.length >= 3) {
                                //  _isLoading = true;
                                  onSubmit(newVal);
                                }

                                if(newVal.length > 0){
                                  _isSearchShow = true;
                                }else{
                                  _isSearchShow = false;
                                }
                              });
                            })),
                  ])),
            ),
          ]));
  }

  Widget viewOrder(List<PosOrderSearch> data) {
   return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: data.length > 5 ? 5 : data.length,
          itemBuilder: (BuildContext context, int i) {

            return  GestureDetector(
              onTap: (){
                sl<SharedPreferences>().setString("title", "viewOrder");
                Navigation(context,
                    navigatore: NavigatoreTyp.push,
                    name: Routename.Home,
                    parms: {
                      'index':
                      (DashBoardPageInfo({'oid': data[i].oId})
                          .pagedatabvendore[6]
                          .pageKey)
                          .toLowerCase()
                    },
                    qparms: {
                      'oid': data[i].oId
                    });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Card(
                  elevation: 1,
                  child:
                  Padding(padding: const EdgeInsets.all(4.0), child:
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center,children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(S.of(context).order+" #${data[i].oId}",style: const TextStyle(fontFamily: 'Segoe',fontSize: 14,fontWeight: FontWeight.w600)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(data[i].oDate!,style: const TextStyle(fontFamily: 'Segoe',fontSize: 12)),
                                ),
                              ],),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(padding: const EdgeInsets.all(8.0), child: SizedBox(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: SizedBox(width: 12,child: Image.asset('assets/icons/icon_user.png')),
                                        ),
                                        Expanded(child: Text(data[i].uName!,maxLines:2,overflow: TextOverflow.ellipsis,style: const TextStyle(fontSize: 14,fontFamily: 'Segoe',fontWeight: FontWeight.w600,overflow: TextOverflow.fade,))),
                                      ],
                                    ),
                                  ),),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: SizedBox(width: 12,child: Image.asset('assets/icons/card.png')),
                                        ),
                                        Expanded(child: Text(IConstants.currencyFormat+data[i].payAmount!.toStringAsFixed(2),maxLines:2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12,))),
                                      ],
                                    ),
                                  ),
                                ],),
                            ),
                          ),
                        ],
                      ),
                      BlocBuilder<MyShopBloc, MyShopState>(
                          builder: (context, state1) {
                            if(state1 is MyShopSucsess) {

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(children: [ Icon(Icons.circle, size: 12, color:
                                  (data[i].oStatus == "completed")
                                      ? Color(0xff37BD6A)
                                      : (data[i].oStatus == "received")
                                      ? Color(0xffF3853B)
                                      :
                                  (data[i].oStatus == "pick") ? Color(
                                      0xff006395) : (data[i].oStatus ==
                                      "ready") ? Color(0xff37BD6A) :
                                  (data[i].oStatus == "dispatched")
                                      ? Color(0xffF3853B)
                                      : (data[i].oStatus == "delivered")
                                      ? Color(0xffFFD600)
                                      :
                                  (data[i].oStatus == "cancelled")
                                      ? Color(0xffFF3434)
                                      : Colors.red
                                  ), Padding(
                                    padding: const EdgeInsets.all(8.0),

                                    child: Text(
                                      (data[i].oStatus == "received")
                                          ? ReCase(S
                                          .of(context)
                                          .Received).titleCase
                                          : ReCase(data[i].oStatus!)
                                          .titleCase, style: TextStyle(
                                        fontSize: 12, fontWeight: FontWeight.bold,
                                        color: (data[i].oStatus ==
                                            "completed") ? Color(0xff37BD6A) : (data[i].oStatus! == "received")
                                            ? Color(0xffF3853B)
                                            :
                                        (data[i].oStatus == "pick")
                                            ? Color(0xff006395)
                                            : (data[i].oStatus ==
                                            "ready") ? Color(0xff37BD6A) :
                                        (data[i].oStatus == "dispatched")
                                            ? Color(0xffF3853B)
                                            : (data[i].oStatus ==
                                            "delivered") ? Color(0xffFFD600) :
                                        (data[i].oStatus == "cancelled")
                                            ? Color(0xffFF3434)
                                            : Colors.red),),
                                  )
                                  ],),
                                  (data[i].oStatus == "completed" ||data[i].oStatus == "onway" ||
                                      data[i].oStatus == "cancelled" || data[i].oStatus == "reached"||
                                      data[i].oStatus == "failed" ||((data[i].oStatus == "ready")
                                      && (state1.shopdata.deliveryLocationType == "0")) || data[i].oStatus == "pick")
                                      ||(data[i].oStatus == "dispatched" /*&& (state.shopdata.deliveryLocationType == "0")*/
                                  ) || (data[i].oStatus == "delivered" /*&& (state.shopdata.deliveryLocationType == "0")*/) ?
                                  SizedBox.shrink()
                                      : Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4,),
                                    child: MaterialButton(
                                      height: 30,
                                      minWidth: 90,
                                      color: (data[i].oStatus ==
                                          "completed") ? Color(0xff37BD6A) : (data[i].oStatus == "received")
                                          ? Color(0xffFF3434)
                                          :
                                      (data[i].oStatus == "pick")
                                          ? Color(0xff006395)
                                          : (data[i].oStatus == "ready")
                                          ? Color(0xff0890E7)
                                          :
                                      (data[i].oStatus == "dispatched")
                                          ? Color(0xffF3853B)
                                          : (data[i].oStatus ==
                                          "delivered") ? Color(0xffFFD600) :
                                      (data[i].oStatus == "cancelled")
                                          ? Color(0xffFF3434)
                                          : Colors.red,
                                      onPressed: () {
                                        sl<SharedPreferences>().setString("title", "viewOrder");
                                        Navigation(
                                            context, navigatore: NavigatoreTyp.push,
                                            name: Routename.Home,
                                            parms: {
                                              'index': (DashBoardPageInfo({
                                                'oid': data[i].oId
                                              }).pagedatabvendore[6].pageKey)
                                                  .toLowerCase()
                                            },
                                            qparms: {
                                              'oid': data[i].oId
                                            });
                                      },
                                      child: Text(
                                          (data[i].oStatus == "received")
                                              ? S.of(context).mark_as_preparing
                                              : (data[i].oStatus ==
                                              "ready")
                                              ?  S.of(context).assign_to_deliver
                                              : (data[i].oStatus ==
                                              "dispatched")
                                              ? S.of(context).mark_as_delivered
                                              : (data[i].oStatus ==
                                              "delivered") ? S.of(context).mark_as_completed : "",
                                          style: const TextStyle(color: Colors.white,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold)),),
                                  )
                                ],
                              );
                            }else{
                              return SizedBox.shrink();
                            }
                          }
                      )
                    ],),
                  ),
                ),
              ),
            );
          }),
    );
  }
  Widget viewOrder1(List<PosOrderSearch> data) {
    return data.length > 0 ?
    SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (BuildContext context, int i) {

            return  GestureDetector(
              onTap: (){
                sl<SharedPreferences>().setString("title", "viewOrder");
                Navigation(context,
                    navigatore: NavigatoreTyp.push,
                    name: Routename.Home,
                    parms: {
                      'index':
                      (DashBoardPageInfo({'oid': data[i].oId})
                          .pagedatabvendore[6]
                          .pageKey)
                          .toLowerCase()
                    },
                    qparms: {
                      'oid': data[i].oId
                    });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Card(
                  elevation: 1,
                  child:
                  Padding(padding: const EdgeInsets.all(4.0), child:
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center,children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(S.of(context).order+"${data[i].oId}",style: const TextStyle(fontFamily: 'Segoe',fontSize: 14,fontWeight: FontWeight.w600)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(data[i].oDate!,style: const TextStyle(fontFamily: 'Segoe',fontSize: 12)),
                                ),
                              ],),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(padding: const EdgeInsets.all(8.0), child: SizedBox(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: SizedBox(width: 12,child: Image.asset('assets/icons/icon_user.png')),
                                        ),
                                        Expanded(child: Text(data[i].uName!,maxLines:2,overflow: TextOverflow.ellipsis,style: const TextStyle(fontSize: 14,fontFamily: 'Segoe',fontWeight: FontWeight.w600,overflow: TextOverflow.fade,))),
                                      ],
                                    ),
                                  ),),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: SizedBox(width: 12,child: Image.asset('assets/icons/card.png')),
                                        ),
                                        Expanded(child: Text(IConstants.currencyFormat+data[i].payAmount!.toStringAsFixed(2),maxLines:2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12,))),
                                      ],
                                    ),
                                  ),
                                ],),
                            ),
                          ),
                        ],
                      ),
                      BlocBuilder<MyShopBloc, MyShopState>(
                          builder: (context, state1) {
                            if(state1 is MyShopSucsess) {

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(children: [ Icon(Icons.circle, size: 12, color:
                                  (data[i].oStatus == "completed")
                                      ? Color(0xff37BD6A)
                                      : (data[i].oStatus == "received")
                                      ? Color(0xffF3853B)
                                      :
                                  (data[i].oStatus == "pick") ? Color(
                                      0xff006395) : (data[i].oStatus ==
                                      "ready") ? Color(0xff37BD6A) :
                                  (data[i].oStatus == "dispatched")
                                      ? Color(0xffF3853B)
                                      : (data[i].oStatus == "delivered")
                                      ? Color(0xffFFD600)
                                      :
                                  (data[i].oStatus == "cancelled")
                                      ? Color(0xffFF3434)
                                      : Colors.red
                                  ), Padding(
                                    padding: const EdgeInsets.all(8.0),

                                    child: Text(
                                      (data[i].oStatus == "received")
                                          ? ReCase(S
                                          .of(context)
                                          .Received).titleCase
                                          : ReCase(data[i].oStatus!)
                                          .titleCase, style: TextStyle(
                                        fontSize: 12, fontWeight: FontWeight.bold,
                                        color: (data[i].oStatus ==
                                            "completed") ? Color(0xff37BD6A) : (data[i].oStatus! == "received")
                                            ? Color(0xffF3853B)
                                            :
                                        (data[i].oStatus == "pick")
                                            ? Color(0xff006395)
                                            : (data[i].oStatus ==
                                            "ready") ? Color(0xff37BD6A) :
                                        (data[i].oStatus == "dispatched")
                                            ? Color(0xffF3853B)
                                            : (data[i].oStatus ==
                                            "delivered") ? Color(0xffFFD600) :
                                        (data[i].oStatus == "cancelled")
                                            ? Color(0xffFF3434)
                                            : Colors.red),),
                                  )
                                  ],),
                                  (data[i].oStatus == "completed" ||data[i].oStatus == "onway" ||
                                      data[i].oStatus == "cancelled" || data[i].oStatus == "reached"||
                                      data[i].oStatus == "failed" ||((data[i].oStatus == "ready")
                                      && (state1.shopdata.deliveryLocationType == "0")) || data[i].oStatus == "pick")
                                      ||(data[i].oStatus == "dispatched" /*&& (state.shopdata.deliveryLocationType == "0")*/
                                  ) || (data[i].oStatus == "delivered" /*&& (state.shopdata.deliveryLocationType == "0")*/) ?
                                  SizedBox.shrink()
                                      : Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4,),
                                    child: MaterialButton(
                                      height: 30,
                                      minWidth: 90,
                                      color: (data[i].oStatus ==
                                          "completed") ? Color(0xff37BD6A) : (data[i].oStatus == "received")
                                          ? Color(0xffFF3434)
                                          :
                                      (data[i].oStatus == "pick")
                                          ? Color(0xff006395)
                                          : (data[i].oStatus == "ready")
                                          ? Color(0xff0890E7)
                                          :
                                      (data[i].oStatus == "dispatched")
                                          ? Color(0xffF3853B)
                                          : (data[i].oStatus ==
                                          "delivered") ? Color(0xffFFD600) :
                                      (data[i].oStatus == "cancelled")
                                          ? Color(0xffFF3434)
                                          : Colors.red,
                                      onPressed: () {
                                        sl<SharedPreferences>().setString("title", "viewOrder");
                                        Navigation(
                                            context, navigatore: NavigatoreTyp.push,
                                            name: Routename.Home,
                                            parms: {
                                              'index': (DashBoardPageInfo({
                                                'oid': data[i].oId
                                              }).pagedatabvendore[6].pageKey)
                                                  .toLowerCase()
                                            },
                                            qparms: {
                                              'oid': data[i].oId
                                            });
                                      },
                                      child: Text(
                                          (data[i].oStatus == "received")
                                              ? S.of(context).mark_as_preparing
                                              : (data[i].oStatus ==
                                              "ready")
                                              ? S.of(context).assign_to_deliver
                                              : (data[i].oStatus ==
                                              "dispatched")
                                              ? S.of(context).mark_as_delivered
                                              : (data[i].oStatus ==
                                              "delivered") ? S.of(context).mark_as_completed : "",
                                          style: const TextStyle(color: Colors.white,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold)),),
                                  )
                                ],
                              );
                            }else{
                              return SizedBox.shrink();
                            }
                          }
                      )
                    ],),
                  ),
                ),
              ),
            );
          }),
    ):
        Text(S.of(context).No_order_found);
    ;
  }

}