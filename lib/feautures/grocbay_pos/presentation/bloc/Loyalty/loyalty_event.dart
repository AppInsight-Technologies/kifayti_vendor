part of 'loyalty_bloc.dart';

abstract class LoyaltyEvent extends Equatable {
  const LoyaltyEvent();
}
// class OnGetLoyalty extends LoyaltyEvent{
//   String branch;
//
//   OnGetLoyalty(this.branch);
//   @override
//   // TODO: implement props
//   List<Object?> get props => [];
//
// }

class OnCheckLoyalty extends LoyaltyEvent{
 // String total;
 String branch;
  String user_point;
  String wallet_amount;
 bool lenable;
 bool wenable;
 String promocode;
 String user;
 List<CartItemModel> items;
 bool promoenable;
  bool ismember;


 OnCheckLoyalty({ required this.branch, required this.user_point, required this.lenable, required this.wenable,required this.wallet_amount, required this.promocode, required this.user, required this.items, required this.promoenable,required this.ismember });
  // TODO: implement props
  List<Object?> get props => [branch,user_point,lenable,wenable,wallet_amount,promocode,user,items,promoenable,ismember];

}







