part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {

}

/// For Intial Product And Product On Click Sub category We call This
class ProductEventInitial extends ProductEvent {
  final FetchSubCategory productid;
  final int subcatid;
    ProductEventInitial(this.productid,this.subcatid);

  @override
  List<Object> get props => [productid,subcatid];
}
/// For Pagination Within Product Widegt We Call This
class ProductPagination extends ProductEvent {
  final FetchSubCategory productid;
  final int subcatid;
  final int start;
  final int end;
  ProductPagination(this.productid,this.subcatid,{
    this.start = 0,
    this.end = 0,
  });

  @override
  List<Object> get props => [productid,start,end,subcatid];
}
/// For search Caling this
class OnProductGet extends ProductEvent{
  List<FetchCategoryProduct> data =[];
  bool isall ;
  OnProductGet(this.data, {this.isall = true});
  @override
  // TODO: implement props
  List<Object?> get props => [data,isall];

}