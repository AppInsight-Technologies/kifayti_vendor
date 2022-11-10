import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/util/presentation/controller/global_focus.dart';
import '../../../../../core/util/presentation/controller/onpress_controller.dart';
import '../../../../../core/util/presentation/styles/screen_size_rario.dart';
import '../../../domain/entities/cart_item_modle.dart';
import '../../../domain/entities/fetch_category_product.dart';
import '../../../domain/entities/get_profile_modle.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../../bloc/checkout/check_out_bloc.dart';
import '../../bloc/customers/userprofile_bloc.dart';
import '../../bloc/homepage/category/category_bloc.dart';
import '../../bloc/homepage/product/product_bloc.dart';
import '../../bloc/homepage/subcategory/subCategory_bloc.dart';
import '../../bloc/search/search_bloc.dart';
import '../component/checkout.dart';
import '../component/product_component.dart';
import '../../../../../injection_container.dart';
import '../component/recentOrder.dart';


class CreateOrderScreen extends StatefulWidget {

   CreateOrderScreen({Key? defaultkey, }) : super(key: defaultkey);

  @override
  _CreateOrderScreenState createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  bool is_draweropen = false;
  final ProductValueController _productvalcontroller = ProductValueController(FetchCategoryProduct());
  // final CheckoutValueController _checkoutvalcontroller = CheckoutValueController((CheckoutModel()));
  final GlobalKey<ScaffoldState> _sc_key = GlobalKey();

  @override
  void initState() {
    FocusN.f_usersearch.requestFocus();

    // TODO: implement initState
    super.initState();
    print("draweropen" + is_draweropen.toString());
  }

  @override
  Widget build(BuildContext context) {
    return /*!is_draweropen ?CheckoutDrawer():*/WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        key: _sc_key,
        // endDrawer: CheckoutDrawer(_productvalcontroller,_checkoutvalcontroller),
        // drawerEnableOpenDragGesture: true,
        endDrawerEnableOpenDragGesture: true,
        onEndDrawerChanged: (isOpen) {},
        body: Container(
          color: Colors.grey.shade200,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Product(s_key: _sc_key,),
              ),
            (sl<SharedPreferences>().containsKey("opendrawer") && sl<SharedPreferences>().getBool("opendrawer") == true)?
            Expanded(
              flex: 1,
              child:  RecentOrder(),
            )
             :(LayoutView(context).isWeb)?
                Expanded(
                  flex: 1,
                  child: Checkout( s_key: _sc_key),
                ):SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
