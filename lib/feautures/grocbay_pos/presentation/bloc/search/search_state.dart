part of 'search_bloc.dart';



abstract class SearchState extends Equatable {
  const SearchState();
}


class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoading extends  SearchState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class SearchSucsess<T> extends  SearchState{
  T data;
  SearchSucsess(this.data);
  @override
  // TODO: implement props
  List<Object?> get props => [data];
}
class SearchError extends  SearchState{
  String e;
  SearchError(this.e);
  @override
  // TODO: implement props
  List<Object?> get props => [e];
}