part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class CartEventInitial extends CartEvent {
  const CartEventInitial();

  @override
  List<Object> get props => [];
}
class CartAdd extends CartEvent{
  FetchCategoryProduct data;
  double quantity;
  String u_id;
  String varid;
  String membered_user;
  IDType idtype;
  @override
  // TODO: implement props
  List<Object?> get props => [];
  CartAdd({required this.data,this.quantity = 1,required this.u_id,required this.varid,required this.membered_user,required this.idtype});
}
class CartRemove extends CartEvent{
  String u_id;
  String varid;

  @override
  // TODO: implement props
  List<Object?> get props => [];
  CartRemove({required this.u_id,required this.varid});
}
class ClearCart extends CartEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
  const ClearCart();
}
class FetchUserCart extends CartEvent{
  String u_id;
  @override
  // TODO: implement props
  List<Object?> get props => [];
  FetchUserCart({required this.u_id});
}
class RecycleCart extends CartEvent{
  String uid;
  RecycleCart(this.uid);
  @override
  // TODO: implement props
  List<Object?> get props => [uid];

}
class HoldCart extends CartEvent{
  String uid;
  HoldCart(this.uid);
  @override
  // TODO: implement props
  List<Object?> get props => [uid];

}
enum IDType{
  barcode,variation
}