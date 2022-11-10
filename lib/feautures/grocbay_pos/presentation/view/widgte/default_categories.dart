import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:velocity_x/velocity_x.dart';

import '../../../domain/entities/fetch_subcategory.dart';
import '../../bloc/homepage/product/product_bloc.dart';
import '../../bloc/homepage/subcategory/subCategory_bloc.dart';
import 'dailog/dropdown.dart';

class SubCategories extends StatefulWidget {
  const SubCategories({Key? key}) : super(key: key);

  @override
  _SubCategoriesState createState() => _SubCategoriesState();
}

class _SubCategoriesState extends State<SubCategories> {
  // String sub_category_id="";
  void initState() {
    // TODO: implement initState
    // BlocProvider.of<ProductCubit>(context).getSubCategory("email", "password");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Container(padding: EdgeInsets.all(8.0),
      child: BlocConsumer<SubcategoryBloc, SubcategoryState>(
        listener: (context, state) {
          if(state is SubcategoryStateSucsess<List<FetchSubCategory>>){
            // sub_category_id=state.data.first.id.toString();
            BlocProvider.of<ProductBloc>(context).add( ProductEventInitial(state.data.first,state.data.first.type!));
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          if(state is SubcategoryEventInitial){
            return SizedBox.shrink();
          }
          if(state is SubcategoryStateLoading){
            return Center(child: Text("Loading..."),);
          }
          if(state is SubcategoryStateSucsess<List<FetchSubCategory>>){
            final _data = state.data;
           return Card(
             elevation: 1,
             child: Padding(
               padding: const EdgeInsets.only(left: 3.0,right: 3.0,bottom: 8,top: 8),
               child: Container(
                 color: Colors.white,
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                    // if(_data.isNotEmpty)
                       Expanded(
                         child: DropdownButtonFormField<FetchSubCategory>(
                           decoration: InputDecoration(
                             enabledBorder: InputBorder.none,
                           ),
                           // decoration:  InputDecoration(
                           //   focusColor: Colors.white,
                           //   border: OutlineInputBorder(
                           //     borderRadius: BorderRadius.circular(10.0),
                           //   ),
                           //
                           //   focusedBorder: OutlineInputBorder(
                           //     borderSide:
                           //     const BorderSide(color: Colors.grey, width: 1.0),
                           //     borderRadius: BorderRadius.circular(10.0),
                           //   ),
                           //   fillColor: Colors.black,
                           //
                           //   hintText: 'Sub Categories',
                           //
                           //   //make hint text
                           //   hintStyle: TextStyle(
                           //     color: Colors.black,
                           //     fontSize: 16,
                           //     fontWeight: FontWeight.w400,
                           //   ),
                           //
                           //   //create lable
                           //   labelText: 'Sub Categories',
                           //   //lable style
                           //   labelStyle: TextStyle(
                           //     color: Colors.grey,
                           //     fontSize: 16,
                           //     fontWeight: FontWeight.w400,
                           //   ),
                           // ),
                           onChanged: (val) {
                             BlocProvider.of<ProductBloc>(context).add( ProductEventInitial(val!,val.type!));


                           },
                           value: _data[0], // Use a fixed value that won't change
                           items: _data.map((e) => DropdownMenuItem<FetchSubCategory>(
                             value: e,
                             child: Row(
                               children: [
                    CachedNetworkImage(imageUrl: e.iconImage!,height: 40,width: 40,placeholder: (context,string){
                 return Image.asset("assets/images/default_category.png");
               },),
                                 Padding(
                                   padding:  EdgeInsets.symmetric(horizontal: Vx.isWeb?10.0:8),
                                   child: Text(e.categoryName!, style: TextStyle(fontSize: Vx.isWeb?14:10),),
                                 ),

                               ],
                             ),
                           )).toList(),
                         ),
                       ),
                     // Dropdown<FetchSubCategory>(listitem: _data,child: (element){
                     //    return Padding(
                     //      padding:const EdgeInsets.only(left: 8.0, right: 8.0),
                     //      child: Row(children: [
                     //        CachedNetworkImage(imageUrl: element.iconImage!,height: 20,width: 20,placeholder: (context,string){
                     //          return Image.asset("assets/images/default_category.png");
                     //        },),
                     //        Padding(
                     //          padding:
                     //          const EdgeInsets.only(left: 8.0, right: 8.0),
                     //          child: Container(
                     //              decoration:
                     //              BoxDecoration(
                     //                color:
                     //                Colors.grey[200],
                     //                //border: Border.all(color:Colors.grey)
                     //              ),
                     //              child: Padding(
                     //                padding:
                     //                const EdgeInsets
                     //                    .symmetric(
                     //                    horizontal:
                     //                    8.0),
                     //                child: Text(
                     //                  element.categoryName??"", style: const TextStyle(
                     //                    color: Colors
                     //                        .green,
                     //                    fontSize: 10,
                     //                    fontWeight:
                     //                    FontWeight
                     //                        .bold),
                     //                ),
                     //              )),
                     //        )
                     //
                     //      ],),
                     //    );
                     //  },onChange: (value) {
                     //    BlocProvider.of<ProductBloc>(context).add( ProductEventInitial(value!,value.type!));
                     //  },),
                     //Icon(Icons.keyboard_arrow_down_sharp,color: Colors.black,),
                   ],
                 ),
               ),
             ),
           );

          }else{
            return SizedBox.shrink();
          }
        },
      ),
    );

  }
}
