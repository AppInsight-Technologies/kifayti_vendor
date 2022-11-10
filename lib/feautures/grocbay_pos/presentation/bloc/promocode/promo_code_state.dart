part of 'promo_code_bloc.dart';

abstract class PromoCodeState extends Equatable {
  const PromoCodeState();
}

class PromoCodeInitial extends PromoCodeState {
  @override
  List<Object> get props => [];
}
class PromoCodeLoading extends PromoCodeState {
  @override
  List<Object> get props => [];
}
class PromoCodeSucsses extends PromoCodeState {
  List <getCoupans> promolist =[];
  PromoCodeSucsses(this.promolist);
  @override
  List<Object> get props => [];
}
class PromoCodeFailed extends PromoCodeState {
  @override
  List<Object> get props => [];
}
