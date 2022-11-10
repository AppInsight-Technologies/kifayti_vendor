
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class CustomeGridView<T> extends StatelessWidget {

   CustomeGridView(BuildContext context,{
    Key? key,
    required int itemcount,
     required this.scolldirection,
    required this.grid_items, this.width, this.height,
  }) : _itemcount = itemcount,
         _itemWidth = scolldirection ==Axis.horizontal&&width!=null? width.h:MediaQuery.of(context).size.width / itemcount,
         _itemHeight =scolldirection ==Axis.vertical&&height!=null?height.h:MediaQuery.of(context).size.height / itemcount,
         super(key: key);

  final int _itemcount;
  final double _itemWidth;
  final double _itemHeight;
  final List<Widget> grid_items;
  final Axis scolldirection;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:scolldirection ==Axis.horizontal? height?.h:null,
      width: scolldirection ==Axis.vertical?width?.w:null,
      child: GridView.count(
          crossAxisCount:_itemcount,
          shrinkWrap: true,
          scrollDirection: scolldirection,
          childAspectRatio:scolldirection ==Axis.horizontal?(_itemHeight/_itemWidth) : (_itemWidth/_itemHeight),
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 8.0,
          children: grid_items
      ),
    );
  }
}