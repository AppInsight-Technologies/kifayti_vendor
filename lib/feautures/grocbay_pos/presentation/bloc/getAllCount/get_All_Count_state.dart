
part of 'get_All_Count_bloc.dart';

abstract class GetAllCountState extends Equatable {
  const GetAllCountState();
}


class GetAllCountInitial extends GetAllCountState {
  @override
  List<Object> get props => [];
}
class GetAllCountLoading extends  GetAllCountState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class GetAllCountSucsess<T> extends  GetAllCountState{
  T data;
  GetAllCountSucsess(this.data);
  @override
  // TODO: implement props
  List<Object?> get props => [data];
}
class GetAllCountError extends  GetAllCountState{
  String e;
  GetAllCountError(this.e);
  @override
  // TODO: implement props
  List<Object?> get props => [e];
}