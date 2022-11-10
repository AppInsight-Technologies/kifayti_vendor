import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/get_shop.dart';
import '../../../domain/usecases/get_shop_usecase.dart';

part 'my_shop_event.dart';
part 'my_shop_state.dart';

class MyShopBloc extends Bloc<MyShopEvent, MyShopState> {
  MyShopBloc(GetShopUseCase useCase) : super(MyShopInitial()) {
    on<MyShopEvent>((event, emit) async{
      // TODO: implement event handler
      if(event is GetShopEvent) {
        final val= await useCase(data:
        Param({"branch":sl<SharedPreferences>().getString(Prefrence.BRANCH)}));
        val.fold((l) => MyShopFailed(), (r) => emit(MyShopSucsess(r)));
      }
    });
  }
}
