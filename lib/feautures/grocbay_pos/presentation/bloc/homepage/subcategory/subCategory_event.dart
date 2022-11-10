part of 'subCategory_bloc.dart';

abstract class SubcategoryEvent extends Equatable {
  const SubcategoryEvent(int catid);
}

class SubcategoryEventInitial extends SubcategoryEvent {
  final int  catid;
  const SubcategoryEventInitial(this.catid) : super(catid);

  @override
  List<Object> get props => [catid];
}