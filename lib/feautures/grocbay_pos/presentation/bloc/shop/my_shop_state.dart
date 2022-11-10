part of 'my_shop_bloc.dart';

@immutable
abstract class MyShopState {}

class MyShopInitial extends MyShopState {}
class MyShopSucsess extends MyShopState{
  GetShop shopdata;
  MyShopSucsess(this.shopdata);
}
class MyShopFailed extends MyShopState{
  MyShopFailed();
}
