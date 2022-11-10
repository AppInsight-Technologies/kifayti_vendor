part of 'promo_code_bloc.dart';

abstract class PromoCodeEvent extends Equatable {
  const PromoCodeEvent();
}
class FetchPromoCode extends PromoCodeEvent{
  GetPromoParams getPromoParams;

  FetchPromoCode(this.getPromoParams);


  @override
  // TODO: implement props
  List<Object?> get props => [getPromoParams];

}
