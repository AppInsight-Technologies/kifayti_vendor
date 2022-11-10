import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
//import '../..//core/util/presentation/constants/ic_constants.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/failuers.dart';
import '../../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../../core/util/presentation/controller/onpress_controller.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/cart_item_modle.dart';
import '../../../domain/usecases/check_out_usecase.dart';

part 'check_out_event.dart';
part 'check_out_state.dart';

class CheckOutBloc extends Bloc<CheckOutEvent, CheckOutState> {
  CheckOutBloc(CheckOutUsecase checkoutUseCase) : super(CheckOutInitial()) {
    on<CheckOutEvent>((event, emit) async{
      CheckoutModel modle = event.props[1] as CheckoutModel;
      emit(CheckOutLoading());
      final items = event.props.first as List<CartItemModel>;
      List<Items> itemlist = [];
      items.forEach((element) {
        debugPrint("element.skutype...."+element.skutype.toString());
        itemlist.add(Items(quantity: (element.skutype == "1")?"1":element.quantity.toString(),mrp: element.varMrp,price: element.price,priceVariation: element.varId,productId: element.id,type: element.type,weight: element.skutype=="1"?element.quantity.toString():"1"));
      });
      if(itemlist.isNotEmpty&&modle.apiKey!=null) {
        debugPrint("user_id :${modle.apiKey}");
        //TODO: implement 'version' from dependency package_info:
        /// 'membership' for product purchased is membership or not
        /// wallet type 4 for not using and 0 for using it
        /// only 0 false 1 true use for if we purchasing only membership not with any product
        /// payment type COD

        final result = await checkoutUseCase(
            data: CheckoutParms(
                branch: sl<SharedPreferences>().getString(Prefrence.BRANCH),
                addressId: "0",
                apiKey: modle.apiKey,
                channel: "POS",
                fixdate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
                fixTime: '9:00 AM - 9:00 PM',
                loyalty: modle.loyalty?"1":"0",
                loyaltyPoints: modle.loyaltyPoints,
                membership: modle.membership,
                membershipActive: modle.membershipActive,
                note: "",
                only: "0",
                walletType: modle.walletType?"0":"4",
                orderType: "instore",
                paymentType: modle.paymentType,
                point: modle.point,
                promo: modle.promo,
                promocode: modle.promocode,
                restId: "0",
                userId: "${modle.apiKey}",
                version: "",
                walletBalance: modle.walletBalance,
                device: "POS",
                items: itemlist,
                posId:sl<SharedPreferences>().getString(Prefrence.posId),
                posPoint:sl<SharedPreferences>().getString(Prefrence.posPoint),
            ));
        result.fold((l) => emit(CheckOutError(mapFailureToMessage(l))),
            (r) => emit(CheckOutSucsess<OrderItem>(r)));
      }
      else{
        print("abc...4");
        emit(CheckOutError(itemlist.isEmpty?"Please Select Any Item for Checkout":"Please Select User"));
      }
    });
  }
}
