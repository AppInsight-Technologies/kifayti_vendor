import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/util/calculations/cartcalculations.dart';
import '../../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../../core/util/presentation/controller/onpress_controller.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/cart_item_modle.dart';
import '../../../domain/usecases/check_loyalty_usecase.dart';
import '../../../domain/usecases/check_promo_usecase.dart';
import '../../../domain/usecases/get_coupans_usecase.dart';
import '../../../domain/usecases/get_loyalty_usecase.dart';
part 'loyalty_event.dart';
part 'loyalty_state.dart';

class LoyaltyBloc extends Bloc<LoyaltyEvent, LoyaltyState> {
  GetLoyaltyUsecase getLoyaltyUsecase;
  CheckLoyaltyUsecase checkLoyaltyUsecase;
  CheckPromoUsecase checkPromoUsecase;
  // GetCoupansUsecase getCoupansUsecase;
  CartCalculationsState cal = new CartCalculationsState();


  LoyaltyBloc({required this.getLoyaltyUsecase,required this.checkLoyaltyUsecase, required this.checkPromoUsecase/*, required this.getCoupansUsecase*/}) : super(LoyaltyInitial()) {

    on<OnCheckLoyalty>((event, emit) async {
      final branch = event.props[0] as String;
      final user_point = event.props[1] as String;///loyalty points
      final enable = event.props[2] as bool;/// loyalty check true or false
      final wallet_enable = event.props[3] as bool;/// wallet checked true or false
      final wallet_amount = event.props[4] as String;///Wallet amount if enabels or else 0
      final promocode = event.props[5] as String;///Code
      final promo_enable = event.props[8] as bool;///Promo code true or false
      final cartitems = event.props[7] as  List<CartItemModel> ;///Promo code true or false
      String total_amount =cal.calculateTotalAmount(cartitems,event.props[9] as bool);
      // CheckoutModel checkoutModel = CheckoutModel();

      print("loyaltyenable, walletenable, promoenable"+enable.toString() +"&&"+wallet_enable.toString()+"&&"+promo_enable.toString());

      emit(LoyaltyLoading());

      if(event is OnCheckLoyalty){
        String total_amt =total_amount;
        double coinvalue = 0;
        double promovalue = 0;
        double points = 0;
        String promomsg = "";
        String wallt_amt = wallet_amount;
        // List<getCoupans> coupans = [];

        ///if nothing  is selected
        if(!enable && !wallet_enable && !promo_enable){
          emit(LoyaltySucsess<String>(total_amount.toString(),wallet_enable?wallet_amount:"0","0",promocode,promomsg,promovalue.toString(),points.toString()));
        }
        ///loyalty
        if(enable){
          final  resultgetloyalty =  await getLoyaltyUsecase(data: LoyaltyParams(branch: branch));
          final checkloyalityresult = await checkLoyaltyUsecase(data: CheckLoyaltyParams(total:total_amount,branch: sl<SharedPreferences>().getString(Prefrence.BRANCH)! ));
          resultgetloyalty.forEach((r) {
            final pointunit = double.parse(r.points!);
            points = pointunit;
            if((double.parse(r.minimumOrderAmount!) <= double.parse(total_amount)) ){
              checkloyalityresult.forEach((r) {
                final totalamtpoint = r.points;
                if(double.parse(user_point)>=totalamtpoint!){
                  coinvalue = totalamtpoint / pointunit;
                  coinvalue =((coinvalue.isNaN)?0:coinvalue);
                }else{
                  coinvalue = double.parse(user_point) /pointunit;
                  coinvalue =((coinvalue.isNaN)?0:coinvalue);
                }
              });
            }else{
              emit(LoyaltyError("Minimum order amount should be ${r.minimumOrderAmount}"));
            }
          });
        }else{
          coinvalue = 0;
        }
        ///promo
        // if(promo_enable){
        //   List<String> l = [];
        //   cartitems.forEach((e) {
        //     l.add(json.encode({"itemid":e.varId.toString(),"qty":e.quantity.toString(),"price":e.price}));
        //   });
        //
        //   final checkpromoresult = await checkPromoUsecase(data: PromoParams(promocode:event.promocode, items: l.toString(), user:event.user, total:total_amount, delivery:"0", branch: event.branch ));
        //   checkpromoresult.forEach((r) {
        //     final status = r.status.toString();
        //     final prmocodeType = r.prmocodeType.toString();
        //     promomsg = r.msg.toString();
        //     final amount = r.amount;
        //     if (status.toString() == "done") {
        //       if ((prmocodeType.toString() == "cashback") || prmocodeType.toString() == "Cashback"){
        //         /// Cash back do nothing automatic effect when hits the server after the purchase
        //       }else{
        //         /// Discount case where immediately apply
        //         promovalue = double.parse(amount.toString());
        //       }
        //     }
        //     else{
        //       emit(LoyaltyError(r.msg.toString()));
        //     }
        //   });
        // }

        //trail
        print(promo_enable);
        if(promo_enable){
          List<String> l = [];
          cartitems.forEach((e) {
            l.add(json.encode({"itemid":e.varId.toString(),"qty":e.quantity.toString(),"price":e.price}));
          });
      //     final getcoupansresult = await getCoupansUsecase(data:GetPromoParams(user:event.user,branch: event.branch,items: event.items.toString(),price: total_amount));
      //     getcoupansresult.forEach((r) {
      //       coupans.add(r);
      //     }
      //
      // );
      //     print("coupans"+coupans.toString());
          final checkpromoresult = await checkPromoUsecase(data: PromoParams(promocode:event.promocode, items: l.toString(), user:event.user, total:total_amount, delivery:"0", branch: event.branch ));
          checkpromoresult.forEach((r) {
            final status = r.status.toString();
            final prmocodeType = r.prmocodeType.toString();
            promomsg = r.msg.toString();
            final amount = r.amount;
            if (status.toString() == "done") {
              if ((prmocodeType.toString() == "cashback") || prmocodeType.toString() == "Cashback"){
                /// Cash back do nothing automatic effect when hits the server after the purchase
              }else{
                /// Discount case where immediately apply
                promovalue = double.parse(amount.toString());
              }
            }
            else{
              emit(LoyaltyError(r.msg.toString()));
            }
          });
        }

        ///wallet
        if(wallet_enable) {
          final t_total = double.parse(total_amount) -(coinvalue+promovalue) ;
          if(t_total>double.parse(wallet_amount)){
            total_amt =( t_total - double.parse(wallet_amount)).toString();
            wallt_amt =wallet_amount;
          }else{
            wallt_amt =( double.parse(wallet_amount)-t_total).toString();
            total_amt ="0";
          }
        } else{
          total_amt =( double.parse(total_amount) -(coinvalue+promovalue)).toString();
          wallt_amt = "0";
        }
        emit(LoyaltySucsess<String>(total_amt,wallet_enable?wallt_amt:"0",coinvalue.toString(),promocode,promo_enable?promomsg:"",promovalue.toString(),points.toString()));
      }
    });
  }


}
