
part of 'update_order_status_bloc.dart';
abstract class UpdateOrderStatusEvent extends Equatable {
  final String branch;
  final String orderid;
  final String orderStatus;
  const UpdateOrderStatusEvent( this.branch,this.orderid,this.orderStatus);
}
class OnUpdateOrderStatusEvent extends UpdateOrderStatusEvent {

  String picker;
  String delivery;

  OnUpdateOrderStatusEvent(String branch,String orderid, String orderStatus,this.picker,this.delivery) : super(branch,orderid,orderStatus);
  @override
  // TODO: implement props
  List<Object?> get props => [branch,orderid,orderStatus,picker,delivery];
}
class AssainPicker extends UpdateOrderStatusEvent{
  final String picker;
  const AssainPicker(String branch, String orderid, String orderStatus,this.picker) : super(branch, orderid, orderStatus);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
class AssainDelevery extends UpdateOrderStatusEvent{
  final String delivery;
  AssainDelevery(String branch, String orderid, String orderStatus,this.delivery) : super(branch, orderid, orderStatus);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class OrderReady extends UpdateOrderStatusEvent{
  final String picker;
  final String delivery;
  OrderReady(String branch, String orderid, String orderStatus,this.picker,this.delivery) : super(branch, orderid, orderStatus);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}