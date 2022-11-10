part of 'my_shop_bloc.dart';

@immutable
abstract class MyShopEvent {}
class GetShopEvent extends MyShopEvent{
  String branch;
  GetShopEvent({required this.branch});
}
