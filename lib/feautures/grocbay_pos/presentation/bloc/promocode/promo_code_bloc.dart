
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/get_coupans.dart';
import '../../../domain/usecases/get_coupans_usecase.dart';

part 'promo_code_event.dart';
part 'promo_code_state.dart';

class PromoCodeBloc extends Bloc<PromoCodeEvent, PromoCodeState> {
  GetCoupansUsecase usecase;
  PromoCodeBloc(this.usecase) : super(PromoCodeInitial()) {
    on<PromoCodeEvent>((events, emit) async{
      List<getCoupans> coupans = [];
      // TODO: implement event handler
     final event = events.props[0] as GetPromoParams;
      emit(PromoCodeLoading());
      final getcoupansresult = await usecase(data:GetPromoParams(user:event.user,items: event.items.toString(),price: event.price));
          getcoupansresult.forEach((r) {
            coupans.add(r);
          }
      );
      emit(PromoCodeSucsses(coupans));
    });
  }
}
