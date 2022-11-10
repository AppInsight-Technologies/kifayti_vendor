
import 'package:flutter/material.dart';

import '../../../../../core/util/presentation/controller/product_add_controller.dart';
import '../../../domain/usecases/VendorProduct_usecase.dart';

class ProductTextForm extends StatefulWidget {
  String labelText;
  TextEditingController controller;

  ProductTextForm({Key? key, required this.labelText, required this.controller }) : super(key: key);

  @override
  _ProductTextFormState createState() => _ProductTextFormState();
}

class _ProductTextFormState extends State<ProductTextForm> {
  final TextEditingController userInput = TextEditingController();
  Variation variationsobj = Variation();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 60.0,
        child: TextFormField(
          enabled: false,

          controller: widget.controller,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          onChanged: (value) {
            setState(() {
              widget.controller.text = value.toString();
              //I am  updating the model's value based on the passed id
              // if(widget.id == "iname"){
              //   AddProductController.item_name= userInput.text;
              //   debugPrint("product name"+AddProductController.item_name.toString());
              // }
              // if(widget.id == "iname"){
              //   AddProductController.item_name= userInput.text;
              //   debugPrint("product name"+AddProductController.item_name.toString());
              // }
              // if(widget.id == "s_notify"){
              //   AddProductController.stock_notify = userInput.text;
              //   debugPrint("stocktype"+AddProductController.stock_notify.toString());
              // }
              // if(widget.id == "tax"){
              //   AddProductController.tax = userInput.text;
              //   debugPrint("stocktype"+AddProductController.tax.toString());
              // }
              // if(widget.id == "i_desc"){
              //   AddProductController.item_description = userInput.text;
              //   debugPrint("stocktype"+AddProductController.item_description.toString());
              // }
              // if(widget.id == "m_desc"){
              //   AddProductController.manufacturer_description = userInput.text;
              //   debugPrint("stocktype"+AddProductController.manufacturer_description.toString());
              // }
              // if(widget.id == "i_priority"){
              //   AddProductController.item_priority = userInput.text;
              //   debugPrint("stocktype"+AddProductController.item_priority.toString());
              // }
              // if(widget.id == "country"){
              //   AddProductController.country_of_origin = userInput.text;
              //   debugPrint("stocktype"+AddProductController.country_of_origin.toString());
              // }
              // if(widget.id == "vname"){
              //   variationsobj.set_var_name = userInput.text;
              //   debugPrint("variationname"+VariationsList.variationname.toString());
              // }
              // if(widget.id == "unit"){
              //  // Variation.unit = userInput.text;
              //  // debugPrint("unit"+Variation.unit.toString());
              // }
              // if(widget.id == "priority"){
              //   //Variation.priority = userInput.text;
              //  // debugPrint("priority"+Variation.priority.toString());
              // }
              // if(widget.id == "SKU"){
              //  // Variation.sku = userInput.text;
              //  // debugPrint("SKU"+Variation.sku.toString());
              // }
              // if(widget.id == "hsn"){
              //   //Variation.hsn = userInput.text;
              //   //debugPrint("hsn"+Variation.hsn.toString());
              // }
              // if(widget.id == "barcode"){
              //  // Variation.barcode = userInput.text;
              //   //debugPrint("barcode"+Variation.barcode.toString());
              // }
              // if(widget.id == "loyalty"){
              //  // Variation.loyalty_points = userInput.text;
              // //  debugPrint("loyalty"+Variation.loyalty_points.toString());
              // }
              // if(widget.id == "gweight"){
              // //  Variation.gross_weight = userInput.text;
              //  // debugPrint("gweight"+Variation.gross_weight.toString());
              // }
              // if(widget.id == "min_qty"){
              //  // Variation.min_order_qty = userInput.text;
              //  // debugPrint("minqty"+Variation.min_order_qty.toString());
              // }
              // if(widget.id == "max_qty"){
              // //  Variation.max_order_qty = userInput.text;
              //  // debugPrint("maxqty"+Variation.max_order_qty.toString());
              // }
              // if(widget.id == "price_per_unit"){
              //  // Variation.price_per_unit = userInput.text;
              //  // debugPrint("price_per_unit"+Variation.price_per_unit.toString());
              // }
              // if(widget.id == "act_price"){
              //  // Variation.actual_price = userInput.text;
              //  // debugPrint("act_price"+Variation.actual_price.toString());
              // }
              // if(widget.id == "dis_price"){
              //  // Variation.discounted_price = userInput.text;
              //  // debugPrint("disprice"+Variation.discounted_price.toString());
              // }
              // if(widget.id == "mem_price"){
              //  // Variation.membership_price = userInput.text;
              //  // debugPrint("memprice"+Variation.membership_price.toString());
              // }
              // if(widget.id == "stock"){
              //  // Variation.stock = userInput.text;
              //  // debugPrint("stock"+Variation.stock.toString());
              // }
            });
          },
          decoration: InputDecoration(
            focusColor: Colors.white,

            suffixIcon: userInput.text.isEmpty
                ? null // Show nothing if the text field is empty
                : const Icon(Icons.info_outline),



            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),

            focusedBorder: OutlineInputBorder(
              borderSide:
              const BorderSide(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            fillColor: Colors.grey,

            hintText: widget.labelText.toString(),

            //make hint text
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),

            //create lable
            labelText: widget.labelText.toString(),
            //lable style
            labelStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
