import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/util/presentation/styles/screen_size_rario.dart';

import 'package:velocity_x/velocity_x.dart';

import '../../../../domain/entities/Fetch_category.dart';
import '../../../bloc/homepage/category/category_bloc.dart';
import '../../../bloc/homepage/subcategory/subCategory_bloc.dart';
import '../dailog/dropdown.dart';

class Category extends StatelessWidget {
  const Category({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryBloc, CategoryState>(
      listener: (context, state) {
        // TODO: implement listener
        if(state is CategoryStateSucsess<List<CategoryFetch>>)
        {
          BlocProvider.of<SubcategoryBloc>(context).add( SubcategoryEventInitial(int.parse(state.data.first.id!)));
        }
      },
      builder: (context, state) {
        if(state is CategoryStateInitial){
          return const SizedBox.shrink();
        }
        if(state == CategoryStateLoading){
          return const Center(child: const Text("Categories Loading..."),);
        }
        if(state is CategoryStateSucsess<List<CategoryFetch>>){
          final _data = state.data ;
          print(_data);
          var element;
         if(_data.isNotEmpty) {
            return  Card(
              elevation: 1,
              child: Padding(
              padding:  EdgeInsets.only(left: (LayoutView(context).isMobile)?0: 25.0,right: (LayoutView(context).isMobile)?0:25.0,bottom: 8,top: 8),
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<CategoryFetch>(

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
                        //   hintText: 'categories',
                        //
                        //   //make hint text
                        //   hintStyle: TextStyle(
                        //     color: Colors.black,
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.w400,
                        //   ),
                        //
                        //   //create lable
                        //   labelText: 'categories',
                        //   //lable style
                        //   labelStyle: TextStyle(
                        //     color: Colors.grey,
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.w400,
                        //   ),
                        // ),
                        onChanged: (val) {
                          BlocProvider.of<SubcategoryBloc>(context).add( SubcategoryEventInitial(int.parse(val?.id??"0")));


                        },
                        value: _data[0], // Use a fixed value that won't change
                        items: _data.map((e) => DropdownMenuItem<CategoryFetch>(
                          value: e,
                          child: Row(
                            children: [
                              CachedNetworkImage(imageUrl: e.iconImage!,height: 40,width: 40,placeholder: (context,string){
                                return Image.asset("assets/images/default_category.png");
                              },),

                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal:  Vx.isWeb?8.0:3.0),
                                child: Text(e.categoryName!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(fontSize: Vx.isWeb?14:10),),
                              ),
                            ],
                          ),
                        )).toList(),
                      ),
                    ),


                    // Expanded(
                    //   child: Dropdown<CategoryFetch>(listitem: _data,child: (element){
                    //     return Padding(
                    //       padding:const EdgeInsets.only(left: 8.0, right: 8.0),
                    //       child: Row(children: [
                    //         CachedNetworkImage(imageUrl: element.bannerImage!,height: 20,width: 20,placeholder: (context,string){
                    //           return Image.asset("assets/images/default_category.png");
                    //         },),
                    //         Padding(
                    //           padding:
                    //           const EdgeInsets.only(left: 8.0, right: 8.0),
                    //           child: Container(
                    //               decoration:
                    //               BoxDecoration(
                    //                 color:
                    //                 Colors.grey[200],
                    //                 //border: Border.all(color:Colors.grey)
                    //               ),
                    //               child: Padding(
                    //                 padding:
                    //                 const EdgeInsets
                    //                     .symmetric(
                    //                     horizontal:
                    //                     8.0),
                    //                 child: Text(
                    //                   element.categoryName??"", style: const TextStyle(
                    //                     color: Colors
                    //                         .green,
                    //                     fontSize: 10,
                    //                     fontWeight:
                    //                     FontWeight
                    //                         .bold),
                    //                 ),
                    //               )),
                    //         )
                    //       ],),
                    //     );
                    //   },onChange: (value) {
                    //     BlocProvider.of<SubcategoryBloc>(context).add( SubcategoryEventInitial(int.parse(value?.id??"0")));
                    //   },
                    //   ),
                    // ),
                    //Icon(Icons.keyboard_arrow_down_sharp,color: Colors.black,),
                  ],
                ),
              ),
          ),
            );
          } else {
            return SizedBox.shrink();
          }
          // return CustomeTabView(tabcontroller,mainAxisAlignment: MainAxisAlignment.start,style: TabStyle(bgcolor: Colors.white),tabs: [
          //   ..._data.map((e) => TabData(ic_name: e.categoryName,icon_id: e.id!),)
          // ],onTap: (index){
          //   BlocProvider.of<SubcategoryBloc>(context).add( SubcategoryEventInitial(int.parse(_data[index].id!)));
          // },);
        }else{
          print("inside else in product screen...");
          return const SizedBox.shrink();
        }
      },
    );
  }
}