import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/error/failuers.dart';
import '../../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../../core/util/presentation/controller/product_add_controller.dart';
import '../../../../../injection_container.dart';
import '../../../domain/usecases/VendorProduct_usecase.dart';

part 'VendorProduct_event.dart';

part 'VendorProduct_state.dart';

class VendorProductBloc extends Bloc<VendorProductEvent, VendorProductState> {
  VendorProductBloc(VendorProductUsecase vendorProductUsecase)
      : super(VendorProductInitial()) {
    on<VendorProductEvent>((event, emit) async {
      print("inside bloc");
      // ProductAddParms modle = event.props[0] as ProductAddParms;
      AddProductController modle = event.props[0] as AddProductController;
      emit(VendorProductLoading());

      final result = await vendorProductUsecase(
          data: ProductAddParms(

            //     branch:28
            //     user:500055
            // branchtype:4
            // replacementitems:
            // itemName:test
            //     type:0
            //     nested:
            //     vegType:none
            //     alert:1
            // duration:0
            // salesTax:18
            // itemDescription:desc
            //     itemShortDescription:desc1
            //     itemPriority:100
            //     country:india
            //     isSubscription:0
            // mode:0
            // tags:test
            // brand:235
            // _token:by4k6w3W4jbruVyWDKoFVNr-gPX_TLNNaERvP15w16U
            // userType:Admin
            // delivery:slot
            // isActive:1
            // subscriptionModule:0
            // subscription:1
            //     seller:0,
            //     b2bModule:1
            //     quantity_data:0
            // productType:1
            // singleSku:
            // singleNetweight:
            // singleBarcode:
            // singleLoyalty:
            // singleMinItem:
            // singleMaxItem:
            // singleUnit:
            // singleIncrementVal:
            // fishprice:
            // singleMrp:
            // singleSellingPrice:
            // singleMembershipPrice:
            // singleHsn:
            // singleshortNote:
            // topping:
            // variation[0]:test
            // price[0]:1
            // mrp[0]:2
            // priority[0]:1
            // min[0]:1
            // max[0]:10
            // membership[0]:3
            // barcode[0]:333
            // sku[0]:1
            // hsn[0]:1
            // weight[0]:1
            // loyalty[0]:1
            // cost[0]:14
            // net_weight[0]:1
            // unit[0]:1
            // status[0]:0
            // cartexpiry[0]:1
            // quantity[0]:1
            // wholesale[0]:0
            // priceperunit[0]:0
            // addon[0]:
            // varnamesdata[0]:
            // varlanguagedata[0]:
            // unitsdata[0]:
            // unitlanguagedata[0]:
            // itemnames[0]:
            // language[0]:
            // desc[0]:
            // languagedata[0]:
            //     manufacturedesc[0]:
            //     manifacturelanguagedata[0]:
            //     category:1104,22
            //     brand:920
              branch: int.parse(sl<SharedPreferences>().getString(Prefrence.BRANCH)!),
              user: 5,
              branchtype: 4,
              replacementitems: "",
              itemName: modle.itemName,
              type: modle.type,
              nested: "",
              vegType: modle.vegType,
              alert: 1,
              duration: modle.duration,
              salesTax: modle.salesTax,
              itemDescription: modle.itemDescription,
              itemShortDescription: modle.itemDescription,
              itemPriority: modle.itemPriority,
              country: modle.country,
              isSubscription: modle.isSubscription,
              mode: 0,
              tags: modle.itemName,
              brand: 235,
              //_token:by4k6w3W4jbruVyWDKoFVNr-gPX_TLNNaERvP15w16U
              userType: "Admin",
              delivery: modle.delivery,
              isActive: modle.isActive,
              subscriptionModule: 0,
              subscription: modle.isSubscription,
              seller: 0,
              b2bModule: 1,
              //quantity_data: 0,
              productType: modle.productType,
              singleSku: modle.singleSku,
              singleNetweight: modle.singleNetweight,
              singleBarcode: modle.singleBarcode,
              singleLoyalty: modle.singleLoyalty,
              singleMinItem: modle.singleMinItem,
              singleMaxItem: modle.singleMaxItem,
              singleUnit: modle.singleUnit,
              singleIncrementVal: modle.singleIncrementVal,
              fishprice: modle.fishprice,
              singleMrp: modle.singleMrp,
              singleSellingPrice: modle.singleSellingPrice,
              singleMembershipPrice: modle.singleMembershipPrice,
              singleHsn: modle.singleHsn,
              singleshortNote: modle.singleshortNote,
              topping: modle.topping,
              variation: modle.variation));

      result.fold((l) => emit(VendorProductError(mapFailureToMessage(l))),
              (r) => emit(VendorProductSucsess(r)));
    });
  }
}
