import 'package:flutter/material.dart';
import '../../../../../core/util/presentation/controller/product_add_controller.dart';

import '../screen/vendor/editproduct.dart';

class DropDownformfield extends StatefulWidget {
  String labelText;
  String controller;
  List<String> DropdownItems;
  Function parentfunction;
  DropDownformfield({Key? key, required this.labelText,required this.DropdownItems, required this.controller,required this.parentfunction}) : super(key: key);

  @override
  _DropDownformfieldState createState() => _DropDownformfieldState();
}

class _DropDownformfieldState extends State<DropDownformfield> {

  var _currentSelectedValue ;
  bool issinglestock = true;
  @override
  void initState() {
    _currentSelectedValue = widget.DropdownItems[0];
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 70,
          child: DropdownButtonFormField<String>(
            decoration:  InputDecoration(
              focusColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),

              focusedBorder: OutlineInputBorder(
                borderSide:
                const BorderSide(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              fillColor: Colors.grey,

              hintText: this.widget.labelText.toString(),

              //make hint text
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),

              //create lable
              labelText: this.widget.labelText.toString(),
              //lable style
              labelStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            onChanged: (val) {
              FocusScope.of(context).requestFocus(FocusNode());
              setState(() {
                _currentSelectedValue = val!;
                widget.controller = val;
                if(widget.controller == "Single SKU" && val == "Single SKU"){
                  debugPrint("inside if");
                  issinglestock = true;
                }
                else if((widget.controller != "Single SKU" && widget.controller != "Multi SKU") &&  issinglestock == true){
                  debugPrint("inside else if");
                  issinglestock = true;
                }
                else if(widget.controller == "Multi SKU" &&  issinglestock == true){
                  debugPrint("inside else if2");
                  issinglestock = false;
                }
                else {
                  debugPrint("inside else"+issinglestock.toString());
                  issinglestock = false;
                }

                debugPrint("widget.controller.text"+widget.controller.toString());
                widget.parentfunction(_currentSelectedValue,widget.controller,issinglestock);

                //debugPrint("selected value: "+widget.controller.toString() +'&& '+val.toString());

              });

              // if(widget.id == "s_type"){
              //   AddProductController.stock_type = (val == "Multi SKU")? "0" :"1";
              //   debugPrint("stocktype"+AddProductController.stock_type.toString());
              // }
              // if(widget.id == "del_dur"){
              //   AddProductController.delivery_duration = "slot";
              //   debugPrint("stocktype"+AddProductController.delivery_duration.toString());
              // }
              // if(widget.id == "p_type"){
              //   AddProductController.product_type = (val == "Standard")? "none" :(val == "Fish")?"fish":(val == "Meat")?"meat":(val == "Offer")?"offer":(val == "Liqour")?"liquour":"addon";
              //   debugPrint("ptype"+AddProductController.product_type.toString());
              // }
              // if(widget.id == "ret_dur"){
              //   AddProductController.return_duration = (val == "3 Hours")? "3" :(val == "6 Hours")?"6":(val == "12 Hours")?"12":(val == "1 Day")?"24":(val == "2 Day")?"48":(val == "3 Day")?"144":(val == "4 Day")?"192":(val == "5 Day")?"240":(val == "6 Day")?"288":"336";
              //   debugPrint("ret_dur"+AddProductController.return_duration.toString());
              // }
              // if(widget.id == "exp_del"){
              //   AddProductController.express_eligible = (val == "Yes")? "1" :"0";
              //   debugPrint("exp_del"+AddProductController.express_eligible.toString());
              // }
              // if(widget.id == "s_product"){
              //   AddProductController.subscription_product = (val == "Yes")? "1" :"0";
              //   debugPrint("s_product"+AddProductController.express_eligible.toString());
              // }
              // if(widget.id == "vendor"){
              //   AddProductController.vendor = "0";
              //   debugPrint("vendor"+AddProductController.vendor.toString());
              // }
              // if(widget.id == "brand"){
              //   AddProductController.brand = "925";
              //   debugPrint("brand"+AddProductController.brand.toString());
              // }
              // if(widget.id == "min_max_expiry"){
              //  // Variation.min_max_expiry = (val == "3 Hours")? "3":(val == "6 Hours")?"6":(val == "12 Hours")?"12":"24";
              // //  debugPrint("min_max_expiry"+Variation.min_max_expiry.toString());
              // }

            },
            value: _currentSelectedValue, // Use a fixed value that won't change
            items: widget.DropdownItems.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );


  }
}
