import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/util/presentation/controller/product_add_controller.dart';


import '../../../../../generated/l10n.dart';
import '../../../domain/usecases/VendorProduct_usecase.dart';
import '../../rought_genrator.dart';

class VariationList extends StatefulWidget {
  List<Variation> variationsdata;
  VariationList({Key? key,required this.variationsdata}) : super(key: key);

  @override
  _VariationListState createState() => _VariationListState();
}

class _VariationListState extends State<VariationList> with Navigations{
  bool _variationctiveswitchValue = false;


  @override
  void initState() {



    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: MediaQuery.of(context).size.width,
        height: 150,
        child:widget.variationsdata.length > 0 ?    ListView.builder(scrollDirection: Axis.vertical,
            itemCount: widget.variationsdata.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width:MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            widget.variationsdata[index].variationName.toString(),
                            style: TextStyle(color: Colors.black,fontSize: 15),

                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.variationsdata[index].mrp.toString(),
                                      style: TextStyle(color: Colors.black,fontSize: 15),

                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.variationsdata[index].price.toString(),
                                      style: TextStyle(color: Colors.black,fontSize: 15),

                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.variationsdata[index].membership.toString(),
                                      style: TextStyle(color: Colors.black,fontSize: 15),

                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.variationsdata[index].priority.toString(),
                                      style: TextStyle(color: Colors.black,fontSize: 15),

                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child:  Transform.scale(
                                      scale: 0.7,
                                      child: CupertinoSwitch(
                                        value: _variationctiveswitchValue,
                                        onChanged: (bool value) {
                                          setState(() {
                                            _variationctiveswitchValue = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  // Expanded(
                                  //   child:  Transform.scale(
                                  //     scale: 0.7,
                                  //     child: CupertinoSwitch(
                                  //       value: _variationctiveswitchValue,
                                  //       onChanged: (bool value) {
                                  //         setState(() {
                                  //           _variationctiveswitchValue = value;
                                  //         });
                                  //       },
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child:  GestureDetector(onTap:(){
                                      Navigation(context, navigatore: NavigatoreTyp.push,name: Routename.VendorProductVariation);
                                    },child: Icon(Icons.edit_rounded,color: Colors.green,size: 20,)),
                                  ),
                                  Expanded(
                                    child:  GestureDetector(onTap:(){

                                    },child: Icon(Icons.delete_outline,color: Colors.grey,size: 20,)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );


            }):Text(S.of(context).no_variations));
  }
}
