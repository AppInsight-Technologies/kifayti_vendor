import 'package:flutter/material.dart';

class Dropdown<T> extends StatefulWidget {
  final List<T> listitem;
  final Widget Function(T) child;
  final Function(T?) onChange;
  const Dropdown({Key? key, required this.listitem, required this.child,required this.onChange}) : super(key: key);

  @override
  State<Dropdown<T>> createState() => _DropdownState<T>();
}

class _DropdownState<T> extends State<Dropdown<T>> {
  late T currentval;

  @override
  void initState() {
    // TODO: implement initState
    currentval = widget.listitem.first;
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return DropdownButton<T>(
      elevation: 0,
      focusColor: Colors.transparent,
      value: currentval,
      focusNode: FocusNode(),
      icon:  Icon(Icons.keyboard_arrow_down_sharp,color: Colors.white,),
      borderRadius: const BorderRadius.all(const Radius.circular(20)),

      items: widget.listitem.map((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: widget.child(value),
        );
      }).toList(),
      onChanged: (value) {
        setState(() => currentval=value!);
        widget.onChange(value);
      },
    );
  }
}
