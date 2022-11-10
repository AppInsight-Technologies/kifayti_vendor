
part of 'delivery_list_bloc.dart';

abstract class DeliveryListState extends Equatable {
  const DeliveryListState();
}


class DeliveryListInitial extends DeliveryListState {
  @override
  List<Object> get props => [];
}
class DeliveryListLoading extends  DeliveryListState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class DeliveryListSucsess<T> extends  DeliveryListState{
  T data;
  DeliveryListSucsess(this.data);
  @override
  // TODO: implement props
  List<Object?> get props => [data];
}
class DeliveryListError extends  DeliveryListState{
  String e;
  DeliveryListError(this.e);
  @override
  // TODO: implement props
  List<Object?> get props => [e];
}