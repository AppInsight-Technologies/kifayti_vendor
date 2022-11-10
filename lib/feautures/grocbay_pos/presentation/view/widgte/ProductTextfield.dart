import 'package:flutter/material.dart';

class ProductTextField extends StatefulWidget {
  String labelText;
  TextEditingController controller;
  ProductTextField({Key? key,required this.labelText,required this.controller}) : super(key: key);

  @override
  _ProductTextFieldState createState() => _ProductTextFieldState();
}

class _ProductTextFieldState extends State<ProductTextField> {
  final userInput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 50.0,
        child: TextField(
          enabled: false,
          controller: widget.controller,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          onChanged: (value) {
            setState(() {
             widget.controller.text = value.toString();
            });
          },
          decoration: InputDecoration(
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
        ),
      ),
    );
  }
}
