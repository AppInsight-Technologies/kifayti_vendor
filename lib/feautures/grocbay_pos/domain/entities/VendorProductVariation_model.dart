import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/util/presentation/controller/product_add_controller.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/util/presentation/styles/screen_size_rario.dart';
import '../../../../../injection_container.dart';
import '../../../../generated/l10n.dart';
import '../../presentation/bloc/VendorProductVariation/VendorProductVariation.dart';
import '../../presentation/rought_genrator.dart';
import '../../presentation/view/widgte/ProductDropdownTextform.dart';
import '../../presentation/view/widgte/ProductTextForm.dart';
import '../usecases/VendorProduct_usecase.dart';


class VendorProductVariation extends StatefulWidget {
  VendorProductVariation({
    Key? key,
  }) : super(key: key);

  @override
  _VendorProductVariationState createState() => _VendorProductVariationState();
}

class _VendorProductVariationState extends State<VendorProductVariation>
    with Navigations {
  bool _wholesaleswitchValue = false;
  List<Variation> variationsarray = [];
  AddProductController obj = AddProductController();
  Variation variationdata = Variation();
  var VariationName = TextEditingController();
  var Unit = TextEditingController();
  var Priority = TextEditingController();
  var SKU = TextEditingController();
  var HSN = TextEditingController();
  var Barcode = TextEditingController();
  var LoyaltyPoints = TextEditingController();
  var GWeight = TextEditingController();
  var MinOrderQty = TextEditingController();
  var MaxOrderQty = TextEditingController();
  var MinMaxExpiry = '';
  var PricePerUnit = TextEditingController();
  var ActualPrice = TextEditingController();
  var DiscountPrice = TextEditingController();
  var MembershipPrice = TextEditingController();
  var Stock = TextEditingController();




  List<String> min_max_expiry = [];

  @override
  void initState() {
    variationdata = Variation();
    min_max_expiry = ["3 Hours", "6 Hours", "12 Hours", "24 Hours"];
    //MinMaxExpiry = min_max_expiry[0];
    // TODO: implement initState
    super.initState();
  }

  setdropdownValue(){
    setState(() {
      debugPrint("setstate called");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:(LayoutView(context).isMobile)? AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor),
            onPressed: () {
              Navigator.of(context).pop();

            }),
        titleSpacing: 0,
        title: Row(
          children: [
            Text(
              S.of(context).Variations,
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24),
            ),
          ],
        ),
      ):null,
      body: (LayoutView(context).isMobile)?
      SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:  Text(
                          S.of(context).add_vartiation,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     const Text(
                      //       'Wholesale',
                      //       style: TextStyle(
                      //         color: Colors.green,
                      //         fontSize: 20,
                      //       ),
                      //     ),
                      //     Transform.scale(
                      //       scale: 0.7,
                      //       child: CupertinoSwitch(
                      //         value: _wholesaleswitchValue,
                      //         onChanged: (bool value) {
                      //           setState(() {
                      //             _wholesaleswitchValue = value;
                      //           });
                      //         },
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProductTextForm(
                              labelText: S.current.variation_name,
                              controller: VariationName),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                          ProductTextForm(labelText: S.current.Unit, controller: Unit),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProductTextForm(
                              labelText: S.current.priority, controller: Priority),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProductTextForm(labelText: S.current.SKU, controller: SKU),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    //  mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProductTextForm(labelText: S.current.HSN, controller: HSN),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProductTextForm(
                              labelText: S.current.Barcode, controller: Barcode),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProductTextForm(
                              labelText: S.current.loyalty_points,
                              controller: LoyaltyPoints),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProductTextForm(
                              labelText: S.current.gross_weight,
                              controller: GWeight),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProductTextForm(
                              labelText: S.current.minimum_order_qty,
                              controller: MinOrderQty),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProductTextForm(
                              labelText: S.current.maximum_order_qty,
                              controller: MaxOrderQty),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropDownformfield(
                              labelText: S.current.min_max_expiry,
                              DropdownItems: min_max_expiry,
                              controller: MinMaxExpiry,parentfunction: setdropdownValue),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProductTextForm(
                              labelText: S.current.price_per_unit,
                              controller: PricePerUnit),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      // Expanded(
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: DropDownformfield(labelText: 'Select Customizables',),
                      //   ),
                      // ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProductTextForm(
                              labelText:S.current.actual_price, controller: ActualPrice),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProductTextForm(
                              labelText: S.current.discounted_price,
                              controller: DiscountPrice),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProductTextForm(
                              labelText: S.current.membership_price,
                              controller: MembershipPrice),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProductTextForm(
                              labelText: S.current.Stock, controller: Stock),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 60,)
                ],
              )),
        ),
      )
          : SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).add_vartiation,
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Wholesale",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                        ),
                      ),
                      Transform.scale(
                        scale: 0.7,
                        child: CupertinoSwitch(
                          value: _wholesaleswitchValue,
                          onChanged: (bool value) {
                            setState(() {
                              _wholesaleswitchValue = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProductTextForm(
                          labelText: S.current.variation_name,
                          controller: VariationName),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                      ProductTextForm(labelText: S.current.Unit, controller: Unit),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProductTextForm(
                          labelText: S.current.priority, controller: Priority),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProductTextForm(labelText: S.current.SKU, controller: SKU),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProductTextForm(labelText: S.current.HSN, controller: HSN),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProductTextForm(
                          labelText: S.current.Barcode, controller: Barcode),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProductTextForm(
                          labelText: S.current.loyalty_points,
                          controller: LoyaltyPoints),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProductTextForm(
                          labelText: S.current.gross_weight,
                          controller: GWeight),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProductTextForm(
                          labelText: S.current.minimum_order_qty,
                          controller: MinOrderQty),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProductTextForm(
                          labelText: S.current.minimum_order_qty,
                          controller: MaxOrderQty),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropDownformfield(
                          labelText: S.current.min_max_expiry,
                          DropdownItems: min_max_expiry,
                          controller: MinMaxExpiry,parentfunction: setdropdownValue),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProductTextForm(
                          labelText: S.current.price_per_unit,
                          controller: PricePerUnit),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  // Expanded(
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: DropDownformfield(labelText: 'Select Customizables',),
                  //   ),
                  // ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProductTextForm(
                          labelText: S.current.actual_price, controller: ActualPrice),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProductTextForm(
                          labelText: S.current.discounted_price,
                          controller: DiscountPrice),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProductTextForm(
                          labelText: S.current.membership_price,
                          controller: MembershipPrice),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProductTextForm(
                          labelText: S.current.Stock, controller: Stock),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: MaterialButton(
                      child: Text(
                        S.of(context).SAVE,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      onPressed: () {
                        debugPrint("Save tapped");

                        //  debugPrint("variation name while saving"+VariationsList.variationname.toString());

                        List<Variation> list = [];
                        variationdata.variationName = VariationName.text;
                        variationdata.unit = Unit.text;
                        variationdata.priority = int.parse(Priority.text);
                        variationdata.sku = 0; //hardcoding for now
                        variationdata.hsn = int.parse(HSN.text);
                        variationdata.barcode = int.parse(Barcode.text);
                        variationdata.loyalty = int.parse(LoyaltyPoints.text);
                        variationdata.weight = int.parse(GWeight.text);
                        variationdata.min = int.parse(MinOrderQty.text);
                        variationdata.max = int.parse(MaxOrderQty.text);
                        variationdata.cartexpiry =
                            int.parse((MinMaxExpiry == "3 Hours")
                                ? "3"
                                : (MinMaxExpiry == "6 Hours")
                                ? "6"
                                : (MinMaxExpiry == "12 Hours")
                                ? "12"
                                : "24");
                        variationdata.priceperunit =
                            int.parse(PricePerUnit.text);
                        variationdata.mrp = int.parse(ActualPrice.text);
                        variationdata.price = int.parse(DiscountPrice.text);
                        variationdata.membership =
                            int.parse(MembershipPrice.text);
                        variationdata.quantity = int.parse(Stock.text);
                        variationdata.brand = 920;
                        variationdata.category = "1398,22";
                        variationdata.wholesale = _wholesaleswitchValue? 1:0;
                        //need to check
                        //list.add(variationdata);
                        Navigation(
                          context,
                          navigatore: NavigatoreTyp.pop,
                          name: Routename.EditVendorProduct,
                        );
                        BlocProvider.of<VendorProductVariationBloc>(context)
                            .add(VariationEventInitial(variationdata));
                        variationdata = Variation();
                        sl<SharedPreferences>().setString("load", "1");
                        //debugPrint("variationslist" + list.toString());
                        debugPrint("List Length" + list.length.toString());
                      },
                      color: Colors.green,
                    ),
                  )
                ],
              )
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: !LayoutView(context).isMobile?SizedBox.shrink():   Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(10.0),
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: Theme.of(context).primaryColor,
          ),
          // color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          child:
          GestureDetector(
            onTap: () {
              debugPrint("Save tapped");

              //  debugPrint("variation name while saving"+VariationsList.variationname.toString());

              List<Variation> list = [];
              variationdata.variationName = VariationName.text;
              variationdata.unit = Unit.text;
              variationdata.priority = int.parse(Priority.text);
              variationdata.sku = 0; //hardcoding for now
              variationdata.hsn = int.parse(HSN.text);
              variationdata.barcode = int.parse(Barcode.text);
              variationdata.loyalty = int.parse(LoyaltyPoints.text);
              variationdata.weight = int.parse(GWeight.text);
              variationdata.min = int.parse(MinOrderQty.text);
              variationdata.max = int.parse(MaxOrderQty.text);
              variationdata.cartexpiry =
                  int.parse((MinMaxExpiry == "3 Hours")
                      ? "3"
                      : (MinMaxExpiry == "6 Hours")
                      ? "6"
                      : (MinMaxExpiry == "12 Hours")
                      ? "12"
                      : "24");
              variationdata.priceperunit =
                  int.parse(PricePerUnit.text);
              variationdata.mrp = int.parse(ActualPrice.text);
              variationdata.price = int.parse(DiscountPrice.text);
              variationdata.membership =
                  int.parse(MembershipPrice.text);
              variationdata.quantity = int.parse(Stock.text);
              variationdata.brand = 920;
              variationdata.category = "1398,22";
              variationdata.wholesale = _wholesaleswitchValue? 1:0;
              //need to check
              //list.add(variationdata);
              Navigation(
                context,
                navigatore: NavigatoreTyp.pop,
                name: Routename.EditVendorProduct,
              );
              BlocProvider.of<VendorProductVariationBloc>(context)
                  .add(VariationEventInitial(variationdata));
              variationdata = Variation();
              sl<SharedPreferences>().setString("load", "1");
              //debugPrint("variationslist" + list.toString());
              debugPrint("List Length" + list.length.toString());
            },
            child: Center(
              child: Text(
                'ADD',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          )
      ),
    );
  }
}
