
part of 'update_order_bloc.dart';
abstract class UpdateOrderEvent extends Equatable {
  const UpdateOrderEvent(String oID);
}
class OnUpdateOrderEvent extends UpdateOrderEvent {
  String oId;

  OnUpdateOrderEvent(this.oId) : super(oId);
  @override
  // TODO: implement props
  List<Object?> get props => [oId];
}
