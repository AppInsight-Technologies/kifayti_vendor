import 'package:flutter/cupertino.dart';
// import '../..//core/util/presentation/constants/ic_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../injection_container.dart';

class GetShop {
  String? deliveryLocationType;
  String? iconImage;
  String? crispChatId;
  String? firebaseMapkey;
  String? playStore;
  String? appleStore;
  String? facebookUrl;
  String? instagramUrl;
  String? youtubeUrl;
  String? twitterUrl;
  String? holidayNote;
  String? holiday;
  String? id;
  String? restaurantName;
  String? privacy;
  String? returns;
  String? refund;
  String? wallet;
  String? description;
  String? restaurantAddress;
  String? restaurantLocation;
  String? restaurantLat;
  String? restaurantLong;
  String? countryCode;
  String? currencyFormat;
  String? slot;
  String? featured;
  String? categoryLabel;
  String? category;
  String? categoryTwoLabel;
  String? categoryTwo;
  String? categoryThree;
  String? categoryThreeLabel;
  String? discount;
  String? featuredLabel;
  String? primaryMobile;
  String? discountLabel;
  String? offerLabel;
  String? offer;
  String? cartLabel;
  String? cartItems;
  String? primaryEmail;
  String? secondaryEmail;
  String? minOrderAmount;
  String? restaurantTerms;
  String? slotdays;
  String? minimumOrderAmount;
  String? maximumOrderAmount;
  String? pickerModal;
  String? deliveryOtp;
  String? affliateModal;
  String? membershipSetting;
  String? loyaltySetting;
  String? referralSetting;
  String? returnSetting;
  String? buyOnegetOne;
  String? isWebsiteSlider;
  String? isMainSlider;
  String? isFeaturedCategoryOne;
  String? isAdsBelowFeaturedCategoriesOne;
  String? isBulkUpload;
  String? isFeaturedItems;
  String? isAdsBelowFeaturedItemsOne;
  String? isFeaturedCategoryTwo;
  String? isAdsBelowFeaturedCategoriesTwo;
  String? isFeaturedCategoryThree;
  String? isAdsBelowFeaturedCategoriesThree;
  String? isAdsBelowCategory;
  String? isCategory;
  String? isBrands;
  String? isDiscountItems;
  String? businessPlan;
  String? numberFormat;
  String? subscriptionModule;
  String? subscriptionStatus;
  String? pickUpfromStoreModule;
  String? shoppingListModule;
  String? promocodeModule;
  String? pushNotificationModule;
  String? onboardingScreenModule;
  String? expressDeliveryModule;
  String? walletModule;
  String? liveChatModule;
  String? whatsapChatModule;
  String? productFilteringModule;
  String? productShareModule;
  String? analyticsModule;
  String? offerModule;
  String? wholesaleModule;
  String? multiVendorModule;
  String? repeatOrderModule;
  String? homepageOffers;
  String? refundModule;
  String? rateOrdersModule;
  String? languageModule;
  String? callMeInsteadOTP;
  String? splitOrder;
  String? mainBanneraboveSlider;
  List<Languages>? languages;
  List<WebsiteSetting>? websiteSetting;

  GetShop(
      {
        this.deliveryLocationType,
        this.iconImage,
        this.crispChatId,
        this.firebaseMapkey,
        this.playStore,
        this.appleStore,
        this.facebookUrl,
        this.instagramUrl,
        this.youtubeUrl,
        this.twitterUrl,
        this.holidayNote,
        this.holiday,
        this.id,
        this.restaurantName,
        this.privacy,
        this.returns,
        this.refund,
        this.wallet,
        this.description,
        this.restaurantAddress,
        this.restaurantLocation,
        this.restaurantLat,
        this.restaurantLong,
        this.countryCode,
        this.currencyFormat,
        this.slot,
        this.featured,
        this.categoryLabel,
        this.category,
        this.categoryTwoLabel,
        this.categoryTwo,
        this.categoryThree,
        this.categoryThreeLabel,
        this.discount,
        this.featuredLabel,
        this.primaryMobile,
        this.discountLabel,
        this.offerLabel,
        this.offer,
        this.cartLabel,
        this.cartItems,
        this.primaryEmail,
        this.secondaryEmail,
        this.minOrderAmount,
        this.restaurantTerms,
        this.slotdays,
        this.minimumOrderAmount,
        this.maximumOrderAmount,
        this.pickerModal,
        this.deliveryOtp,
        this.affliateModal,
        this.membershipSetting,
        this.loyaltySetting,
        this.referralSetting,
        this.returnSetting,
        this.buyOnegetOne,
        this.isWebsiteSlider,
        this.isMainSlider,
        this.isFeaturedCategoryOne,
        this.isAdsBelowFeaturedCategoriesOne,
        this.isBulkUpload,
        this.isFeaturedItems,
        this.isAdsBelowFeaturedItemsOne,
        this.isFeaturedCategoryTwo,
        this.isAdsBelowFeaturedCategoriesTwo,
        this.isFeaturedCategoryThree,
        this.isAdsBelowFeaturedCategoriesThree,
        this.isAdsBelowCategory,
        this.isCategory,
        this.isBrands,
        this.isDiscountItems,
        this.businessPlan,
        this.numberFormat,
        this.subscriptionModule,
        this.subscriptionStatus,
        this.pickUpfromStoreModule,
        this.shoppingListModule,
        this.promocodeModule,
        this.pushNotificationModule,
        this.onboardingScreenModule,
        this.expressDeliveryModule,
        this.walletModule,
        this.liveChatModule,
        this.whatsapChatModule,
        this.productFilteringModule,
        this.productShareModule,
        this.analyticsModule,
        this.offerModule,
        this.wholesaleModule,
        this.multiVendorModule,
        this.repeatOrderModule,
        this.homepageOffers,
        this.refundModule,
        this.rateOrdersModule,
        this.languageModule,
        this.callMeInsteadOTP,
        this.splitOrder,
        this.mainBanneraboveSlider,
        this.languages,
        this.websiteSetting});

  GetShop.fromJson(Map<String, dynamic> json) {
    print("json val: ${json.toString()}");
    deliveryLocationType = json['deliveryLocationType'];
    iconImage = json['icon_image']!=null?"${IConstants.API_IMAGE}restaurant/icons/"+json['icon_image']:"";
    print("sssa $iconImage");
    crispChatId = json['crispChatId'];
    firebaseMapkey = json['firebaseMapkey'];
    playStore = json['play_store'];
    appleStore = json['apple_store'];
    facebookUrl = json['facebook_url'];
    instagramUrl = json['instagram_url'];
    youtubeUrl = json['youtube_url'];
    twitterUrl = json['twitter_url'];
    holidayNote = json['holidayNote'];
    holiday = json['holiday'];
    id = json['id'];
    restaurantName = json['restaurant_name'];
    privacy = json['privacy'];
    returns = json['returns'];
    refund = json['refund'];
    wallet = json['wallet'];
    description = json['description'];
    restaurantAddress = json['restaurant_address'];
    restaurantLocation = json['restaurant_location'];
    restaurantLat = json['restaurant_lat'];
    restaurantLong = json['restaurant_long'];
    countryCode = json['country_code'];
    currencyFormat = json['currency_format'];
    slot = json['slot'];
    featured = json['featured'];
    categoryLabel = json['category_label'];
    category = json['category'];
    categoryTwoLabel = json['category_two_label'];
    categoryTwo = json['category_two'];
    categoryThree = json['category_three'];
    categoryThreeLabel = json['category_three_label'];
    discount = json['discount'];
    featuredLabel = json['featured_label'];
    primaryMobile = json['primary_mobile'];
    discountLabel = json['discount_label'];
    offerLabel = json['offer_label'];
    offer = json['offer'];
    cartLabel = json['cart_label'];
    cartItems = json['cartItems'];
    primaryEmail = json['primary_email'];
    secondaryEmail = json['secondary_email'];
    minOrderAmount = json['min_order_amount'];
    restaurantTerms = json['restaurant_terms'];
    slotdays = json['slotdays'];
    minimumOrderAmount = json['minimum_order_amount'];
    maximumOrderAmount = json['maximum_order_amount'];
    pickerModal = json['pickerModal'];
    deliveryOtp = json['deliveryOtp'];
    affliateModal = json['affliateModal'];
    membershipSetting = json['membershipSetting'];
    loyaltySetting = json['loyaltySetting'];
    referralSetting = json['referralSetting'];
    returnSetting = json['returnSetting'];
    buyOnegetOne = json['buyOnegetOne'];
    isWebsiteSlider = json['isWebsiteSlider'];
    isMainSlider = json['isMainSlider'];
    isFeaturedCategoryOne = json['isFeaturedCategoryOne'];
    isAdsBelowFeaturedCategoriesOne = json['isAdsBelowFeaturedCategoriesOne'];
    isBulkUpload = json['isBulkUpload'];
    isFeaturedItems = json['isFeaturedItems'];
    isAdsBelowFeaturedItemsOne = json['isAdsBelowFeaturedItemsOne'];
    isFeaturedCategoryTwo = json['isFeaturedCategoryTwo'];
    isAdsBelowFeaturedCategoriesTwo = json['isAdsBelowFeaturedCategoriesTwo'];
    isFeaturedCategoryThree = json['isFeaturedCategoryThree'];
    isAdsBelowFeaturedCategoriesThree =
    json['isAdsBelowFeaturedCategoriesThree'];
    isAdsBelowCategory = json['isAdsBelowCategory'];
    isCategory = json['isCategory'];
    isBrands = json['isBrands'];
    isDiscountItems = json['isDiscountItems'];
    businessPlan = json['businessPlan'];
    numberFormat = json['number_format'];
    subscriptionModule = json['subscriptionModule'];
    subscriptionStatus = json['subscriptionStatus'];
    pickUpfromStoreModule = json['pickUpfromStoreModule'];
    shoppingListModule = json['shoppingListModule'];
    promocodeModule = json['promocodeModule'];
    pushNotificationModule = json['pushNotificationModule'];
    onboardingScreenModule = json['onboardingScreenModule'];
    expressDeliveryModule = json['expressDeliveryModule'];
    walletModule = json['walletModule'];
    liveChatModule = json['liveChatModule'];
    whatsapChatModule = json['whatsapChatModule'];
    productFilteringModule = json['productFilteringModule'];
    productShareModule = json['productShareModule'];
    analyticsModule = json['analyticsModule'];
    offerModule = json['offerModule'];
    wholesaleModule = json['wholesaleModule'];
    multiVendorModule = json['multiVendorModule'];
    repeatOrderModule = json['repeatOrderModule'];
    homepageOffers = json['homepageOffers'];
    refundModule = json['refundModule'];
    rateOrdersModule = json['rateOrdersModule'];
    languageModule = json['languageModule'];
    callMeInsteadOTP = json['callMeInsteadOTP'];
    splitOrder = json['splitOrder'];
    mainBanneraboveSlider = json['mainBanneraboveSlider'];
    debugPrint("json['languages']..."+json['languages'].toString());
    if (json['languages'] != null) {
      Languages language =  new Languages(languageCode: "en", name: "English", status: "0", id: "", branch:sl<SharedPreferences>().getString(Prefrence.BRANCH),ref: "",createdAt: "",invoice: "");
      languages = <Languages>[];
      languages!.add(language);
      json['languages'].forEach((v) {
        languages!.add(new Languages.fromJson(v));
      });
    }else{
      Languages language =  new Languages(languageCode: "en", name: "English", status: "0", id: "", branch:sl<SharedPreferences>().getString(Prefrence.BRANCH),ref: "",createdAt: "",invoice: "");
      languages = <Languages>[];
      languages!.add(language);
    }
    if (json['WebsiteSetting'] != null) {
      websiteSetting = <WebsiteSetting>[];
      json['WebsiteSetting'].forEach((v) {
        websiteSetting!.add(WebsiteSetting.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deliveryLocationType']= this.deliveryLocationType;
    data['icon_image'] = this.iconImage;
    data['crispChatId'] = this.crispChatId;
    data['firebaseMapkey'] = this.firebaseMapkey;
    data['play_store'] = this.playStore;
    data['apple_store'] = this.appleStore;
    data['facebook_url'] = this.facebookUrl;
    data['instagram_url'] = this.instagramUrl;
    data['youtube_url'] = this.youtubeUrl;
    data['twitter_url'] = this.twitterUrl;
    data['holidayNote'] = this.holidayNote;
    data['holiday'] = this.holiday;
    data['id'] = this.id;
    data['restaurant_name'] = this.restaurantName;
    data['privacy'] = this.privacy;
    data['returns'] = this.returns;
    data['refund'] = this.refund;
    data['wallet'] = this.wallet;
    data['description'] = this.description;
    data['restaurant_address'] = this.restaurantAddress;
    data['restaurant_location'] = this.restaurantLocation;
    data['restaurant_lat'] = this.restaurantLat;
    data['restaurant_long'] = this.restaurantLong;
    data['country_code'] = this.countryCode;
    data['currency_format'] = this.currencyFormat;
    data['slot'] = this.slot;
    data['featured'] = this.featured;
    data['category_label'] = this.categoryLabel;
    data['category'] = this.category;
    data['category_two_label'] = this.categoryTwoLabel;
    data['category_two'] = this.categoryTwo;
    data['category_three'] = this.categoryThree;
    data['category_three_label'] = this.categoryThreeLabel;
    data['discount'] = this.discount;
    data['featured_label'] = this.featuredLabel;
    data['primary_mobile'] = this.primaryMobile;
    data['discount_label'] = this.discountLabel;
    data['offer_label'] = this.offerLabel;
    data['offer'] = this.offer;
    data['cart_label'] = this.cartLabel;
    data['cartItems'] = this.cartItems;
    data['primary_email'] = this.primaryEmail;
    data['secondary_email'] = this.secondaryEmail;
    data['min_order_amount'] = this.minOrderAmount;
    data['restaurant_terms'] = this.restaurantTerms;
    data['slotdays'] = this.slotdays;
    data['minimum_order_amount'] = this.minimumOrderAmount;
    data['maximum_order_amount'] = this.maximumOrderAmount;
    data['pickerModal'] = this.pickerModal;
    data['deliveryOtp'] = this.deliveryOtp;
    data['affliateModal'] = this.affliateModal;
    data['membershipSetting'] = this.membershipSetting;
    data['loyaltySetting'] = this.loyaltySetting;
    data['referralSetting'] = this.referralSetting;
    data['returnSetting'] = this.returnSetting;
    data['buyOnegetOne'] = this.buyOnegetOne;
    data['isWebsiteSlider'] = this.isWebsiteSlider;
    data['isMainSlider'] = this.isMainSlider;
    data['isFeaturedCategoryOne'] = this.isFeaturedCategoryOne;
    data['isAdsBelowFeaturedCategoriesOne'] =
        this.isAdsBelowFeaturedCategoriesOne;
    data['isBulkUpload'] = this.isBulkUpload;
    data['isFeaturedItems'] = this.isFeaturedItems;
    data['isAdsBelowFeaturedItemsOne'] = this.isAdsBelowFeaturedItemsOne;
    data['isFeaturedCategoryTwo'] = this.isFeaturedCategoryTwo;
    data['isAdsBelowFeaturedCategoriesTwo'] =
        this.isAdsBelowFeaturedCategoriesTwo;
    data['isFeaturedCategoryThree'] = this.isFeaturedCategoryThree;
    data['isAdsBelowFeaturedCategoriesThree'] =
        this.isAdsBelowFeaturedCategoriesThree;
    data['isAdsBelowCategory'] = this.isAdsBelowCategory;
    data['isCategory'] = this.isCategory;
    data['isBrands'] = this.isBrands;
    data['isDiscountItems'] = this.isDiscountItems;
    data['businessPlan'] = this.businessPlan;
    data['number_format'] = this.numberFormat;
    data['subscriptionModule'] = this.subscriptionModule;
    data['subscriptionStatus'] = this.subscriptionStatus;
    data['pickUpfromStoreModule'] = this.pickUpfromStoreModule;
    data['shoppingListModule'] = this.shoppingListModule;
    data['promocodeModule'] = this.promocodeModule;
    data['pushNotificationModule'] = this.pushNotificationModule;
    data['onboardingScreenModule'] = this.onboardingScreenModule;
    data['expressDeliveryModule'] = this.expressDeliveryModule;
    data['walletModule'] = this.walletModule;
    data['liveChatModule'] = this.liveChatModule;
    data['whatsapChatModule'] = this.whatsapChatModule;
    data['productFilteringModule'] = this.productFilteringModule;
    data['productShareModule'] = this.productShareModule;
    data['analyticsModule'] = this.analyticsModule;
    data['offerModule'] = this.offerModule;
    data['wholesaleModule'] = this.wholesaleModule;
    data['multiVendorModule'] = this.multiVendorModule;
    data['repeatOrderModule'] = this.repeatOrderModule;
    data['homepageOffers'] = this.homepageOffers;
    data['refundModule'] = this.refundModule;
    data['rateOrdersModule'] = this.rateOrdersModule;
    data['languageModule'] = this.languageModule;
    data['callMeInsteadOTP'] = this.callMeInsteadOTP;
    data['splitOrder'] = this.splitOrder;
    data['mainBanneraboveSlider'] = this.mainBanneraboveSlider;
    debugPrint("this.languages.."+this.languages.toString());
    if (this.languages != null) {
      data['languages'] = this.languages!.map((v) => v.toJson()).toList();
    }
    if (this.websiteSetting != null) {
      data['WebsiteSetting'] =
          this.websiteSetting!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Languages {
  String? id;
  String? name;
  String? createdAt;
  String? branch;
  String? status;
  String? languageCode;
  String? ref;
  String? invoice;


  Languages(
      {this.id,
        this.name,
        this.createdAt,
        this.branch,
        this.status,
        this.languageCode,
        this.ref,
        this.invoice,

      });

  Languages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    branch = json['branch'];
    status = json['status'];
    languageCode = json['languageCode'];
    ref = json['ref'];
    invoice = json['invoice'];
    if(!sl<SharedPreferences>().containsKey("Languageid")){
      sl<SharedPreferences>().setString("Languageid", "");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['branch'] = this.branch;
    data['status'] = this.status;
    data['languageCode'] = this.languageCode;
    data['ref'] = this.ref;
    data['invoice'] = this.invoice;

    return data;
  }
}

class WebsiteSetting {
  String? paymentGateway;
  String? webViewUrl;
  String? gatewayId;
  String? gatewaySecret;
  String? mode;

  WebsiteSetting(
      {this.paymentGateway,
        this.webViewUrl,
        this.gatewayId,
        this.gatewaySecret,
        this.mode});

  WebsiteSetting.fromJson(Map<String, dynamic> json) {
    paymentGateway = json['payment_gateway'];
    webViewUrl = json['webViewUrl'];
    gatewayId = json['gateway_id'];
    gatewaySecret = json['gateway_secret'];
    mode = json['mode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_gateway'] = this.paymentGateway;
    data['webViewUrl'] = this.webViewUrl;
    data['gateway_id'] = this.gatewayId;
    data['gateway_secret'] = this.gatewaySecret;
    data['mode'] = this.mode;
    return data;
  }
}
