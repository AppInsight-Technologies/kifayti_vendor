part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}
class OnSearch extends SearchEvent {
  String query;
  SearchType type;

  OnSearch(this.query,this.type);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
enum SearchType{
  user,product,order,
}