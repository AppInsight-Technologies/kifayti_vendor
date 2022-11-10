import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';


class ProductCategoryDropdown extends StatefulWidget {
  //final List<String> items;
  const ProductCategoryDropdown({Key? key,/*required this.items*/}) : super(key: key);

  @override
  _ProductCategoryDropdownState createState() => _ProductCategoryDropdownState();
}

class _ProductCategoryDropdownState extends State<ProductCategoryDropdown> {
  final List<String> _items = [
    'Flutter',
    'Node.js',
    'React Native',
    'Java',
    'Docker',
    'MySQL'
  ];
  // this variable holds the selected items
  final List<String> _selectedItems = [];

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    Navigator.pop(context, _selectedItems);
  }



  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Topics'),
      content: SingleChildScrollView(
        child: ListBody(
          children: _items
              .map((item) => CheckboxListTile(
            value: _selectedItems.contains(item),
            title: Text(item),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (isChecked) => _itemChange(item, isChecked!),
          ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          child:  Text(S.of(context).Cancel),
          onPressed: _cancel,
        ),
        ElevatedButton(
          child:  Text(S.of(context).Submit),
          onPressed: _submit,
        ),
      ],
    );
  }
}
