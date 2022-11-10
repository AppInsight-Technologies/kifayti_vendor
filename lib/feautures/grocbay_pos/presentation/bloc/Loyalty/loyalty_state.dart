part of 'loyalty_bloc.dart';


abstract class LoyaltyState extends Equatable {
  const LoyaltyState();
}


class LoyaltyInitial extends LoyaltyState {
  @override
  List<Object> get props => [];
}
class LoyaltyLoading extends  LoyaltyState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class LoyaltySucsess<T> extends  LoyaltyState{
  T data;
  String walletused;
  String loyality;
  String promocode;
  String promomsg;
  String promoamount;
  String loyaltyPoint;
  // List <getCoupans> promolist =[];
  LoyaltySucsess(this.data,this.walletused,this.loyality,this.promocode,this.promomsg,this.promoamount,this.loyaltyPoint);
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class LoyaltyError extends  LoyaltyState{
  String e;
  LoyaltyError(this.e);
  @override
  // TODO: implement props
  List<Object?> get props => [];
}