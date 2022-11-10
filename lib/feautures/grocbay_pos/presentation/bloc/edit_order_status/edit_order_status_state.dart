
part of 'edit_order_status_bloc.dart';

abstract class EditOrderStatusState extends Equatable {
  const EditOrderStatusState();
}


class EditOrderStatusStateInitial extends EditOrderStatusState {
  @override
  List<Object> get props => [];
}
class EditOrderStatusStateLoading extends  EditOrderStatusState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class EditOrderStatusStateSucsess<T> extends  EditOrderStatusState{

  T data;
  EditOrderStatusStateSucsess(this.data);
  @override
  // TODO: implement props
  List<Object?> get props => [data];
}
class EditOrderStatusStateError extends  EditOrderStatusState{
  String e;
  EditOrderStatusStateError(this.e);
  @override
  // TODO: implement props
  List<Object?> get props => [e];
}