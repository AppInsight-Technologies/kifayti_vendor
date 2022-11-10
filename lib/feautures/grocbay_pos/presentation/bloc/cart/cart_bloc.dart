import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
//import '../..//core/util/presentation/controller/onpress_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../../core/util/presentation/controller/onpress_controller.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/cart_item_modle.dart';
import '../../../domain/entities/fetch_category_product.dart';
import '../../../domain/repositorie/repository_provider.dart';
import '../../../domain/usecases/cart_item_usecase.dart';
import '../../../domain/usecases/get_product_data_barcode.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartItemBloc extends Bloc<CartEvent, CartState> {
  CartItemBloc(CartItemUseCase usecase,GetProductBarCode product) : super(CartStateInitial()) {
    on<CartEvent>((event, emit) async{
      final value = await usecase(data: CartParms(DB.GET));
      final holdvalue = await usecase.holdCart(data: CartParms(DB.GET));
      emit(CartStateLoading());
      if(event is CartAdd) {
        // final value = await usecase(data: CartParms(DB.GET));
        Map<String,dynamic> _data = <String, dynamic>{} ;
        FetchCategoryProduct productdata =  event.data;
        String id = event.varid;
        if(event.idtype==IDType.barcode){
         final values = await product(data: ProductBarCodePArms(code: id,user: "0"));
         values.fold((l) => emit(CartStateError("Cache exception")), (r) =>
         {
           productdata = r,
           id = r.priceVariation?.first.id??r.id!,
         });
        }
        debugPrint("productdata:${productdata.toJson().toString()} id : $id");

        value.forEach((r) {
          // if(r.any((element) => false))
          if(r.any((element) => element.varId == id)){
            debugPrint("cartload"+r.firstWhere((element) => element.varId == id).price.toString());
            r.firstWhere((element) => element.varId == id).quantity = event.idtype==IDType.barcode?r.firstWhere((element) => element.varId == id).quantity!+event.quantity:event.quantity;
          }else {
            debugPrint("fromproduct");
            r.add(CartItemModel.fromProduct(product:productdata, quantity: event.quantity , varid: id, u_id: event.u_id, branch: sl<SharedPreferences>().getString(Prefrence.BRANCH)!,ismembereduser: checkoutValueController.value.value.is_membered_user));
          }
          _data["data"] = r.map((e) => e.toJson()).toList();
        });
        debugPrint("cart data:${_data.toString()}");
        await usecase(data: CartParms(DB.SET,_data));
        value.fold((l) => emit(CartStateError("Cache exception")), (r) => emit(CartStateSucsess<List<CartItemModel>>(r)));
      }
      if(event is CartRemove){
        Map<String,dynamic> _data = <String, dynamic>{} ;
        value.map((r) async{
          r.removeWhere((element) => element.varId == event.varid);
          _data["data"] = r.map((e) => e.toJson()).toList();
        });
        await usecase(data: CartParms(DB.SET,_data));
        value.fold((l) => emit(CartStateError("Cache exception")), (r) => emit(CartStateSucsess<List<CartItemModel>>(r)));
      }
      if(event is ClearCart){
        await usecase(data: CartParms(DB.REMOVE));
        value.fold((l) => emit(CartStateError("Cache exception")), (r) => emit(CartStateSucsess<List<CartItemModel>>([])));
      }
      if(event is FetchUserCart){
        Map<String,dynamic> _data = <String, dynamic>{} ;

        // value.map((r) async{
        //   if(r.any((element) => element.user == event.u_id)){
        //
        //     // debugPrint("id passed for fetching cart"+event.u_id);
        //     // debugPrint("elelment found while fetching the cart"+element.user.toString());
        //
        //   }
        //   else{
        //     debugPrint("no records found");
        //     //_data["data"] = [];
        //   }
        //   //_data["data"] = r.map((e) => e.toJson()).toList();
        //
        // });
        final List<CartItemModel> list =[];
       value.map((r) {
       // list.addAll(r.where((element) => element.user == event.u_id));
        list.addAll(r/*.where((element) => element.user == "0")*/.map((e) => CartItemModel.fromJson(e.toJson(user: event.u_id))));
        // list.addAll(r.where((element) => element.user != "0").map((e) => CartItemModel.fromJson(e.toJson(user: event.u_id))));
         _data["data"]= r.map((e) => e.toJson()).toList();
         if (kDebugMode) {
           debugPrint("data fetched"+_data.toString());
         }
        emit(CartStateSucsess<List<CartItemModel>>(list));
       });
      }
      if(event is RecycleCart){
        // final value = await usecase(data: CartParms(DB.GET));
        Map<String,dynamic> _data = <String, dynamic>{} ;
        // final value = await usecase.holdCart(data: CartParms(DB.GET));
        holdvalue.forEach((r) {
          _data["data"] = r.where((element) => element.user == event.uid).map((e) => e.toJson()).toList();
          // debugPrint("fromproduct");
           r.removeWhere((element)=> element.user == event.uid);
           print("removed and store ${r.map((e) => e.toJson()).toList()}");
          usecase.holdCart(data: CartParms(DB.UPDATE,{'data': r.map((e) => e.toJson()).toList()}));
        });
        // _data["data"] = event.cartItemModels.map((e) => e.toJson()).toList();
        debugPrint("cart data:${_data.toString()}");
        final cart_value = await usecase(data: CartParms(DB.UPDATE,_data));
        cart_value.fold((l) => emit(CartStateError("Cache exception")), (r) => emit(CartStateSucsess<List<CartItemModel>>(r)));
      }
      if(event is HoldCart){
        Map<String,dynamic> _data = <String, dynamic>{};
        value.forEach((r) async{
          _data["data"] = r.where((element) => element.user == event.uid).map((e) => e.toJson()).toList();
          await usecase.holdCart(data: CartParms(DB.UPDATE,_data));
        });
        await usecase(data: CartParms(DB.REMOVE));
        value.fold((l) => emit(CartStateError("Cache exception")), (r) => emit(CartStateSucsess<List<CartItemModel>>([])));
      }
      else{
        value.fold((l) => emit(CartStateError("Cache exception")), (r) => emit(CartStateSucsess<List<CartItemModel>>(r)));
      }
    });
  }
}
