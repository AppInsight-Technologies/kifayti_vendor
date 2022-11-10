import 'package:flutter/cupertino.dart';
// import '../../core/util/presentation/constants/ic_constants.dart';
// import '../../feautures/grocbay_pos/domain/entities/picker_list_model.dart';
// import '../../injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../feautures/grocbay_pos/domain/entities/cart_item_modle.dart';
import '../../../../feautures/grocbay_pos/domain/entities/fetch_category_product.dart';
import '../../../../feautures/grocbay_pos/domain/entities/get_profile_modle.dart';

abstract class ValueListnabelController<T> with  ChangeNotifier{
  late ValueNotifier<T> _value ;
  ValueListnabelController(T val){
    this._value = ValueNotifier<T>(val);
    notifyListeners();
  }
  ValueNotifier<T> get value => _value;
  set value(ValueNotifier<T> value) {
    _value = value ;
    _value.notifyListeners();
    notifyListeners();
  }
}
class CartValueController extends ValueListnabelController<CartItemModel>{
  CartValueController(val) : super(val);
}
final CartValueController cartValueController = CartValueController(CartItemModel());

class ProductValueController extends ValueListnabelController<FetchCategoryProduct>{
  ProductValueController(val) : super(val);
}
final ProductValueController productValueController = ProductValueController(FetchCategoryProduct());

class UserValueController extends ValueListnabelController<GetCustomerProfile>{
  UserValueController(val) : super(val);
}
final UserValueController userValueController = UserValueController(GetCustomerProfile());
class CheckoutValueController extends ValueListnabelController<CheckoutModel>{
  CheckoutValueController(val) : super(val);
}
final CheckoutValueController checkoutValueController = CheckoutValueController(CheckoutModel());
class StringValueListnabel extends ValueListnabelController<String>{
  StringValueListnabel(String val) : super(val);
}
class PickerValueController extends ValueListnabelController<String>{
  PickerValueController(val) : super(val);
}
final PickerValueController pickerValueController = PickerValueController('');

class DeliveryValueController extends ValueListnabelController<String>{
  DeliveryValueController(val) : super(val);
}
final DeliveryValueController deliveryValueController = DeliveryValueController('');


final StringValueListnabel stringvalControler  = StringValueListnabel("");

class CheckoutModel{
  String? userId;
  bool walletType;
  String? walletBalance;
  String? apiKey;
  String? restId;
  String? addressId;
  String? orderType;
  String? paymentType;
  String? promocode;
  // String? fixTime;
  // String? fixdate;
  String? promo;
  String? only;
  String? channel;
  String? membership;
  String? membershipActive;
  String? note;
  String? branch;
  bool loyalty;
  String? loyaltyPoints;
  String? point;
  String? version;
  String? device;
  String? is_membered_user;
  String? posId;
  String? posPoint;

  CheckoutModel(
      {this.userId,
        this.walletType =false,
        this.walletBalance="0",
        this.apiKey,
        this.restId = "0",
        this.addressId="0",
        this.orderType ="instore",
        this.paymentType ,
        this.promocode = "",
        // this.fixTime,
        // this.fixdate,
        this.promo = "",
        this.only = "0",
        this.is_membered_user,
        this.channel = "POS",
        this.membership ="0",
        this.membershipActive="0",
        this.note = "0",
        this.branch ,
        this.loyalty =false,
        this.loyaltyPoints ="0",
        this.point="0",
        this.version = "",
        this.device ="POS",
        this.posId,
        this.posPoint
      });
}