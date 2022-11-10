import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import '../..//generated/l10n.dart';

import '../../../../../core/util/presentation/styles/screen_size_rario.dart';
import '../../../../../generated/l10n.dart';
import '../../../domain/entities/fetch_category_product.dart';
import '../../../domain/entities/search_user_modle.dart';
import '../../bloc/customers/userprofile_bloc.dart';
import '../../bloc/search/search_bloc.dart';
import 'search/transform_follower.dart';

class SearchBar<T> extends StatelessWidget {
  final String? hintText;
  final SearchBarStyle style;
  final SearchType type;
  Function(String,BuildContext) onQuerySearch;
  Function(bool)? searchstatus;
  Function(List)? listnsearch;
  Widget Function(T,int,bool) listdata;
  Function(T?) onSubmit;
  Function? onSubmitEmpty;
  final FocusNode focus;
  final Widget? empty;
  final String? errorText;
  SearchBar(this.onQuerySearch, {Key? key,this.hintText,required this.style,required this.type,this.searchstatus,this.listnsearch,  required this.listdata,required this.onSubmit,required this.focus, this.empty,this.onSubmitEmpty,this.errorText}) : super(key: key);

  OverlayEntry? overlayEntry;
  int index = 0;
  final LayerLink layerLink = LayerLink();
  // final SearchCommand searchCommand = SearchCommand();
  TextEditingController controller  = TextEditingController(text: "");

  Future<OverlayEntry> _showOverlay(BuildContext context, SearchState state, int index,) async {
    // FocusScope.of(context).requestFocus(focus);
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size size = renderBox.size;
    // debugPrint("searchtype in searchbar widget:"+widget.searchtype.toString());
    return OverlayEntry(builder: (context1) {
      return Positioned(
          width: (LayoutView(context).isMobile)?renderBox.size.width -23 :renderBox.size.width,
         // width: renderBox.size.width-30,
          child: TransformFollower(
            link: layerLink,
            offset: Offset((LayoutView(context).isMobile)?3.5:8, size.height - 10),
            child: Material(
              color: Colors.transparent,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: (state is SearchLoading)? Container(
                      height:50,
                      color: Colors.white
                      ,child: Center(child: CircularProgressIndicator(),
                      )):
                  (state is SearchSucsess<List<T>>)?
                  state.data.isNotEmpty?
                  Container(
                      height: (LayoutView(context).isMobile)?MediaQuery.of(context).size.height /2 :MediaQuery.of(context).size.height /1.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Scrollbar(
                          isAlwaysShown: true,
                          showTrackOnHover: true,
                          thickness: 10,
                          radius: Radius.circular(20),
                          interactive: true,
                          child: ListView(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if(state is SearchLoading)
                                 Text(S.of(context).Loading,style: TextStyle(color: Colors.white)),
                              if(state is SearchSucsess<List<T>>)
                                // if(state.data.toList() == [])
                                ...state.data.map((e) =>  GestureDetector (
                                  onTap: () {
                                    clearOverlay();
                                    onSubmit(e);
                                  },
                                  child: listdata(e as T,index,index == state.data.indexOf(e)),
                                )
                                ).toList()

                            ],
                          ),
                        ),
                      )):
                  Container(
                        height: 80,
                      decoration: BoxDecoration(
                    color:Color(0xffffffff),
                    borderRadius: BorderRadius.circular(8),
                     ),
                      child: Center(child: Text(errorText!))):
                  Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color:Color(0xffffffff),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(child: Text(errorText!))),
                ),
              ),
            ),
          ));
    });
  }
  // @override
  // void initState() {
  //   controller.addListener(() async{
  //     debugPrint("listning to text");
  //     if (!_focus.hasFocus) {
  //       controller.text = '';
  //       clearOverlay();
  //     }
  //   });
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    focus.addListener(() {
      if (!focus.hasFocus ) {
        controller.text = '';
        clearOverlay();
      }
    });

    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) async{
        if (focus.hasFocus) {
          clearOverlay();
          index = 0;
          addOverlay(context,state,index);
        }
        if(state is SearchSucsess<List<T>>) {
          if( listnsearch!=null) {
            // listnsearch!(state.data);
          }
        }

        // TODO: implement listener
      },
      builder: (context, state){
        return  CompositedTransformTarget(
          link: layerLink,
          child: KeyboardListener(
            onKeyEvent: (event){
              if(state is SearchSucsess<List<T>>) {
                debugPrint(event.logicalKey.toString());
                if (event is KeyDownEvent) {
                  if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
                    debugPrint("event");
                    if (focus.hasFocus) {
                      if (index < state.data.length-1) {
                        clearOverlay();
                        addOverlay(context, state, ++index);
                      }
                    }
                    // setState(()=>index++);
                  } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
                    if (kDebugMode) {
                      debugPrint("event");
                    }
                    if (focus.hasFocus) {
                      if (index > 0) {
                        clearOverlay();
                        addOverlay(context, state, --index);
                      }
                    }
                  }
                  else if (!kIsWeb&& event.logicalKey == LogicalKeyboardKey.enter) {

                    if (kDebugMode) {
                      debugPrint("ontap inside the search $index");
                    }
                    onSubmit(state.data.elementAt(index));
                    clearOverlay();

                  }
                  else{
                    if (kDebugMode) {
                      debugPrint('enterd:'+event.logicalKey.toString());
                    }
                  }
                } else {
                  return;
                }
              }
              else if(state is SearchError){
                if (!kIsWeb&& event.logicalKey == LogicalKeyboardKey.enter) {

                  if (kDebugMode) {
                    debugPrint("ontap inside the search $index");
                  }
                  if(onSubmitEmpty!=null) {
                    onSubmitEmpty!(controller.text);
                  }
                  clearOverlay();

                }
              }
            },
            autofocus: false,
            focusNode: FocusNode(),
            child: Padding(
              padding:  EdgeInsets.only(left: LayoutView(context).isMobile? 0.0:10,right: 15.0,
                  bottom: LayoutView(context).isMobile? 0.0:8,
                  top: LayoutView(context).isMobile? 0.0:8),
              child: Container(

                height: style.height,
                child:  Center(
                  child: TextFormField(

                    controller: controller,
                    focusNode: focus,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (val) {
                   if(kIsWeb)
                     {
                       if(state is SearchSucsess<List<T>>) {
                         onSubmit(state.data.elementAt(index));
                       }else{
                         onSubmit(null);
                       }
                     }
                      },
                    onChanged: (query) {
                      if(query.length>2) {
                        onQuerySearch(query,context);
                        searchstatus!(true);

                      }else{
                        overlayEntry?.remove();
                        overlayEntry = null;
                        if(query.isEmpty) {
                          searchstatus!(false);
                        }
                      }
                    },
                    decoration:  InputDecoration(
                        hintStyle:  TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: (LayoutView(context).isWeb || LayoutView(context).isTab)?Color(0xff32B847):Colors.black),
                        suffixIcon: style.iconalign == IconAlign.ending ? Icon(Icons.search,size: 22,color:(LayoutView(context).isWeb || LayoutView(context).isTab)?Color(0xff32B847):Colors.black):null,
                        prefixIcon:  style.iconalign == IconAlign.leading ? Icon(Icons.search,size: 22,color:(LayoutView(context).isWeb || LayoutView(context).isTab)?Color(0xff32B847):Colors.black):null,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: style.contentPadding,

                        hintText: hintText),
                  ),
                ), decoration: style.decoration,
              ),
            ),
          ),
        );
      },
    );
  }
  void clearOverlay() {

    overlayEntry?.remove();
    overlayEntry = null;
  }
  void addOverlay(BuildContext context,SearchState state, int index) async{
    overlayEntry = await _showOverlay(context,state,index);
    Overlay.of(context)!.insert(overlayEntry!);
  }
}

class SearchBarStyle{
  IconAlign? iconalign;
  EdgeInsetsGeometry? contentPadding;
  double? height;
  Decoration? decoration;
  SearchBarStyle({this.iconalign,this.contentPadding,this.height,this.decoration});

}
enum IconAlign{
  leading,ending
}

