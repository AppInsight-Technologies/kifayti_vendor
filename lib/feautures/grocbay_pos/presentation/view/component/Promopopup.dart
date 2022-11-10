
// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import '../..//feautures/grocbay_pos/domain/entities/get_coupans.dart';
// import '../..//feautures/grocbay_pos/presentation/bloc/Loyalty/loyalty_bloc.dart';

import '../../../../../core/util/presentation/controller/onpress_controller.dart';
import '../../bloc/promocode/promo_code_bloc.dart';
// ignore: camel_case_types
class Promo_Popup extends StatefulWidget {
  final Function(String) onTap;

  const Promo_Popup({Key? key,required this.onTap}) : super(key: key);

  @override
  _Promo_PopupState createState() => _Promo_PopupState();
}

class _Promo_PopupState extends State<Promo_Popup> {
  CheckoutModel checkoutModel = CheckoutModel();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Available Coupons",style: TextStyle(color: Colors.black,fontSize:10,fontWeight: FontWeight.bold)),
          ),
        ),

        BlocBuilder<PromoCodeBloc, PromoCodeState>(
          builder: (context, state) {
            if(state is PromoCodeLoading){
              return const Center(child: SizedBox(height: 60,child: CircularProgressIndicator(),));
            }
            if(state is PromoCodeSucsses) {
              ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.promolist.length, itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration:  BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular((5.0)),
                          border: Border.all(color:(Colors.green),),),
                        child:
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset("assets/icons/promo.png"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(state.promolist[index].promocode.toString(),style: TextStyle(color: Colors.black,fontSize:10,fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(height: 40,onPressed: (){
                        Navigator.pop(context);
                        widget.onTap(state.promolist[index].promocode.toString());
                        // checkoutModel.promocode = state.promolist[index].promocode.toString();
                      },
                        child: const Text("APPLY",style: TextStyle(color: Colors.green),),)
                    ],
                  ),
                );
              });
            }

            return const SizedBox.shrink();

          },
        ),



      ],
    );
  }
}
