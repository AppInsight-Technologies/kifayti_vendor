part of 'check_out_bloc.dart';

abstract class CheckOutEvent extends Equatable {
  const CheckOutEvent();
}
class OnCheckOut extends CheckOutEvent{
  List<CartItemModel> data;
  CheckoutModel model;
  OnCheckOut(this.data,this.model);
  @override
  // TODO: implement props
  List<Object?> get props => [data,model];

}
class Checkoutdata{

}