
part of 'update_order_status_bloc.dart';

abstract class UpdateOrderStatusState extends Equatable {
  const UpdateOrderStatusState();
}


class UpdateOrderStatusInitial extends UpdateOrderStatusState {
  @override
  List<Object> get props => [];
}
class UpdateOrderStatusLoading extends  UpdateOrderStatusState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class UpdateOrderStatusSucsess<T> extends  UpdateOrderStatusState{
  T data;
  UpdateOrderStatusSucsess(this.data);
  @override
  // TODO: implement props
  List<Object?> get props => [data];
}
class UpdateOrderStatusError extends  UpdateOrderStatusState{
  String e;
  UpdateOrderStatusError(this.e);
  @override
  // TODO: implement props
  List<Object?> get props => [e];
}