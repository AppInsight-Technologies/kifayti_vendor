
part of 'update_order_bloc.dart';

abstract class UpdateOrderState extends Equatable {
  const UpdateOrderState();
}


class UpdateOrderInitial extends UpdateOrderState {
  @override
  List<Object> get props => [];
}
class UpdateOrderLoading extends  UpdateOrderState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class UpdateOrderSucsess<T> extends  UpdateOrderState{
  T data;
  UpdateOrderSucsess(this.data);
  @override
  // TODO: implement props
  List<Object?> get props => [data];
}
class UpdateOrderError extends  UpdateOrderState{
  String e;
  UpdateOrderError(this.e);
  @override
  // TODO: implement props
  List<Object?> get props => [e];
}