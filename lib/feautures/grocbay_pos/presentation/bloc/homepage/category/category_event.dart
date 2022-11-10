part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class CategoryEventInitial extends CategoryEvent {
  const CategoryEventInitial();

  @override
  List<Object> get props => [];
}