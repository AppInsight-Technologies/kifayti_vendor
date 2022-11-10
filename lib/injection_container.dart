
import 'package:data_connection_checker/data_connection_checker.dart' if (dart.library.html) "core/network/data_connection_checker_web.dart";
import 'package:get_it/get_it.dart';

import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'core/util/input_data_converter.dart';
import 'package:http/http.dart' as http;
import 'feautures/grocbay_pos/data/datasours/local_data_source.dart';
import 'feautures/grocbay_pos/data/datasours/remote_data_sources.dart';
import 'feautures/grocbay_pos/data/repositorie/data_layer_repo_impl.dart';
import 'feautures/grocbay_pos/domain/entities/getRestaraunt.dart';
import 'feautures/grocbay_pos/domain/entities/modle_entities.dart';
import 'feautures/grocbay_pos/domain/repositorie/repository_provider.dart';
import 'feautures/grocbay_pos/domain/usecases/VendorProduct_usecase.dart';
import 'feautures/grocbay_pos/domain/usecases/barcode_search_usecase.dart';
import 'feautures/grocbay_pos/domain/usecases/cart_item_usecase.dart';
import 'feautures/grocbay_pos/domain/usecases/check_loyalty_usecase.dart';
import 'feautures/grocbay_pos/domain/usecases/check_out_usecase.dart';
import 'feautures/grocbay_pos/domain/usecases/check_promo_usecase.dart';
import 'feautures/grocbay_pos/domain/usecases/create-profile_usecase.dart';
import 'feautures/grocbay_pos/domain/usecases/delivery_list_usecase.dart';
import 'feautures/grocbay_pos/domain/usecases/edit_order_status_usecase.dart';
import 'feautures/grocbay_pos/domain/usecases/edit_product_usecase.dart';
import 'feautures/grocbay_pos/domain/usecases/get-brands_usecase.dart';
import 'feautures/grocbay_pos/domain/usecases/getCategories_usercase.dart';
import 'feautures/grocbay_pos/domain/usecases/get_all_count_usecase.dart';
import 'feautures/grocbay_pos/domain/usecases/get_category.dart';
import 'feautures/grocbay_pos/domain/usecases/get_category_product.dart';
import 'feautures/grocbay_pos/domain/usecases/get_coupans_usecase.dart';
import 'feautures/grocbay_pos/domain/usecases/get_loyalty_usecase.dart';
import 'feautures/grocbay_pos/domain/usecases/get_product_data_barcode.dart';
import 'feautures/grocbay_pos/domain/usecases/get_shop_usecase.dart';
import 'feautures/grocbay_pos/domain/usecases/get_sub_category.dart';
import 'feautures/grocbay_pos/domain/usecases/get_userprofile_usercase.dart';
import 'feautures/grocbay_pos/domain/usecases/login_usecase.dart';
import 'feautures/grocbay_pos/domain/usecases/picker_list_usecase.dart';
import 'feautures/grocbay_pos/domain/usecases/product_search_usecase.dart';
import 'feautures/grocbay_pos/domain/usecases/searchorderlist_usercase.dart';
import 'feautures/grocbay_pos/domain/usecases/shop_status_usecase.dart';
import 'feautures/grocbay_pos/domain/usecases/update_order_status_usecase.dart';
import 'feautures/grocbay_pos/domain/usecases/update_order_usecase.dart';
import 'feautures/grocbay_pos/domain/usecases/user_email_exist_usercase.dart';
import 'feautures/grocbay_pos/domain/usecases/user_mobile_exist_usercase.dart';
import 'feautures/grocbay_pos/domain/usecases/usersearch_usecase.dart';
import 'feautures/grocbay_pos/presentation/bloc/CategoriesBrands/CategoriesBrands_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/Loyalty/loyalty_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/VendorProduct/VendorProduct.dart';
import 'feautures/grocbay_pos/presentation/bloc/VendorProductVariation/VendorProductVariation.dart';
import 'feautures/grocbay_pos/presentation/bloc/cart/cart_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/checkout/check_out_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/customers/Register/register_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/customers/userprofile_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/delivery_list/delivery_list_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/edit_order_status/edit_order_status_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/edit_product/edit_product_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/getAllCount/get_All_Count_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/homepage/category/category_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/homepage/product/product_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/homepage/subcategory/subCategory_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/loginBloc/login_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/order/order_managment_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/picker_list/picker_list_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/promocode/promo_code_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/search/search_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/searchBarcode/search_barcode_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/shop/my_shop_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/shop_status/shopstatus.dart';
import 'feautures/grocbay_pos/presentation/bloc/themeControllBloc/theme_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/update_order/update_order_bloc.dart';
import 'feautures/grocbay_pos/presentation/bloc/update_order_status/update_order_status_bloc.dart';
final sl = GetIt.instance;

init() async{
  _bloc();
  _usecase();
  _repo();
  _datasource();
  _core();
  await _external();
}
_bloc(){
  //Bloc
  sl.registerFactory(() => LoginBloc(loginusecase: LoginUseCase(repo: sll()), fetchUserUseCase: FetchUserUseCase(repo:  sll(),),
  ));
  sl.registerFactory(() => RegisterBloc(customerRegisterUsecase: CustomerRegisterUsecase(repo: sll()), checkEmailUsecase: CheckEmailUsecase(repo: sll()), checkMobileUsecase: CheckMobileUsecase(repo: sll()),
  ));
  sl.registerFactory(() => LoyaltyBloc(getLoyaltyUsecase: GetLoyaltyUsecase(sll(),), checkLoyaltyUsecase: CheckLoyaltyUsecase( DataLayerRepositoryImpl (
    remoteDataSource:  RemoteDataSourceImpl(client: sl()),
    localDataSource: LocalDataSourceImpl(sharedPreferences: sl()),
    networkInfo: NetworkInfoImpl(sl()),
  ),),checkPromoUsecase: CheckPromoUsecase(repo: sll()),));
  //Bloc
  sl.registerFactory(() => PromoCodeBloc(GetCoupansUsecase(repo:  sll(),),));//Bloc
  sl.registerFactory(() => CategoryBloc(GetCategory( sll()),));//Bloc
  sl.registerFactory(() => SubcategoryBloc(GetSubCategory( sll()),));//Bloc
  sl.registerFactory(() => ProductBloc(GetCategoryProduct( sll()),));//Bloc
  sl.registerFactory(() => MyShopBloc(GetShopUseCase( repo:  sll(),),));//Bloc
  sl.registerFactory(() => CartItemBloc(CartItemUseCase( sll()),GetProductBarCode(sll())));//Bloc
  // sl.registerFactory(() => CartItemBloc(CartItemUseCase( sll()),));//Bloc
  sl.registerFactory(() => CheckOutBloc(CheckOutUsecase( sll()),));
  sl.registerFactory(() => OrderManagmentBloc(SearchOrderUsecase( repo:sll(), ),));
  sl.registerFactory(() => ShopstatusBloc(ShopStatus( repo:sll(), ),));
  sl.registerFactory(() => UserProfileBloc(profileUserUsecase:GetProfileCustomerUcase(repo:  sll()),),);
  sl.registerFactory(() => SearchBloc(
    searchUserrUsecase:SearchUserUsecase(repo:  sll()),
    searchProductUsecase: SearchProductUsecase(repo:  sll()),
    searchOrderUsecase: SearchOrderUsecase(repo: sll())
  ),);//Bloc/Bloc
  sl.registerFactory(() => ThemeBloc());
  sl.registerFactory(() => VendorProductVariationBloc());
  sl.registerFactory(() => VendorProductBloc(VendorProductUsecase( sll()),));
  sl.registerFactory(() => CategoriesBrandsBloc(getCategory:GetCategoriesUsecase(sll()), getBrands: GetBrandsUsecase(sll()),),);//Bloc/Bloc
  sl.registerFactory(() => UpdateOrderBloc( getUpdateOrder: GetUpdateOrderUsecase( sll()),));//Bloc
  sl.registerFactory(() => DeliveryListBloc( getdeliveryList: deliveryListUsecase( sll()),));//Bloc
  sl.registerFactory(() => PickerListBloc( getPickerList: pickerListUsecase( sll()),));//Bloc
  sl.registerFactory(() => UpdateOrderStatusBloc( getUpdateOrderStatus: UpdateOrderStatusUsecase( sll()),));//Bloc
  sl.registerFactory(() => EditOrderStatusBloc( editOrderStatus: editOrderStatusUsecase( sll()),));//Bloc
  sl.registerFactory(() => EditProductBloc( editProduct: editProductUsecase( sll()),));//Bloc
  sl.registerFactory(() => GetAllCountBloc( getGetAllCount: GetAllCountUsecase( sll()),));//Bloc
  sl.registerFactory(() => SearchBarcodeBloc(getSearchBarcodeData: SearchBarcodeUsecase(repo: sll()),));//Bloc
}
_usecase(){
  sl.registerLazySingleton(() => LoginUseCase(repo: sll()));//UseCaseCase
  sl.registerLazySingleton(() => GetShopUseCase(repo: sll()));//UseCaseCase
}
_repo(){
  sl.registerLazySingleton<DependencyRepostProvider<Map<String,dynamic>>>(
        () => DataLayerRepositoryImpl(
      remoteDataSource: RemoteDataSourceImpl(client: sl()),
      localDataSource: LocalDataSourceImpl(sharedPreferences: sl()),
      networkInfo: NetworkInfoImpl(sl()),
    ),
  );//Repository
}
_datasource(){
  sl.registerLazySingleton<RemoteDataSource>(
        () => RemoteDataSourceImpl(client: sl()),
  );//DataSource

  sl.registerLazySingleton<LocalDataSource>(
        () => LocalDataSourceImpl(sharedPreferences: sl()),
  );//DataSource
}
_core(){
  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
_external()async {
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  //
  Hive.registerAdapter(GetRestarauntAdapter() );
  Hive.registerAdapter(ModelEntitiesAdapter() );
}
sll(){
  return DataLayerRepositoryImpl (
    remoteDataSource:  RemoteDataSourceImpl(client: sl()),
    localDataSource: LocalDataSourceImpl(sharedPreferences: sl()),
    networkInfo: NetworkInfoImpl(sl()),
  );
}