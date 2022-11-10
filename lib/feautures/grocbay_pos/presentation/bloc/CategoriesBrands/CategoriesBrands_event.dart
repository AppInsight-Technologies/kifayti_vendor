

part of 'CategoriesBrands_bloc.dart';

abstract class GetCategoriesBrandsEvent extends Equatable {
  const GetCategoriesBrandsEvent(String apiKey);
}
class OnGetCategoriesBrands extends GetCategoriesBrandsEvent {
  String branch;

  OnGetCategoriesBrands(this.branch) : super(branch);
  @override
  // TODO: implement props
  List<Object?> get props => [branch];
}
