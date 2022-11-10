
part of 'picker_list_bloc.dart';

abstract class PickerListState extends Equatable {
  const PickerListState();
}


class PickerListInitial extends PickerListState {
  @override
  List<Object> get props => [];
}
class PickerListLoading extends  PickerListState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class PickerListSucsess<T> extends  PickerListState{
  T data;
  PickerListSucsess(this.data);
  @override
  // TODO: implement props
  List<Object?> get props => [data];
}
class PickerListError extends  PickerListState{
  String e;
  PickerListError(this.e);
  @override
  // TODO: implement props
  List<Object?> get props => [e];
}