// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `clicked`
  String get clicked {
    return Intl.message(
      'clicked',
      name: 'clicked',
      desc: '',
      args: [],
    );
  }

  /// `Search For Products`
  String get search_for_prod {
    return Intl.message(
      'Search For Products',
      name: 'search_for_prod',
      desc: '',
      args: [],
    );
  }

  /// `Multi SKU`
  String get multi_sku {
    return Intl.message(
      'Multi SKU',
      name: 'multi_sku',
      desc: '',
      args: [],
    );
  }

  /// `Single SKU`
  String get single_sku {
    return Intl.message(
      'Single SKU',
      name: 'single_sku',
      desc: '',
      args: [],
    );
  }

  /// `Slot Based Delivery`
  String get slot_based_deli {
    return Intl.message(
      'Slot Based Delivery',
      name: 'slot_based_deli',
      desc: '',
      args: [],
    );
  }

  /// `Standard`
  String get standard {
    return Intl.message(
      'Standard',
      name: 'standard',
      desc: '',
      args: [],
    );
  }

  /// `No Return`
  String get no_return {
    return Intl.message(
      'No Return',
      name: 'no_return',
      desc: '',
      args: [],
    );
  }

  /// `yes`
  String get yes {
    return Intl.message(
      'yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `No Vendor`
  String get no_vendor {
    return Intl.message(
      'No Vendor',
      name: 'no_vendor',
      desc: '',
      args: [],
    );
  }

  /// `PRPARING`
  String get preparing {
    return Intl.message(
      'PRPARING',
      name: 'preparing',
      desc: '',
      args: [],
    );
  }

  /// `Originally Ordered Qty`
  String get original_ord_qty {
    return Intl.message(
      'Originally Ordered Qty',
      name: 'original_ord_qty',
      desc: '',
      args: [],
    );
  }

  /// `Updated Item Qty`
  String get updated_item_qty {
    return Intl.message(
      'Updated Item Qty',
      name: 'updated_item_qty',
      desc: '',
      args: [],
    );
  }

  /// `Edit weight`
  String get edit_weight {
    return Intl.message(
      'Edit weight',
      name: 'edit_weight',
      desc: '',
      args: [],
    );
  }

  /// `Reason for editing`
  String get reason_for_editing {
    return Intl.message(
      'Reason for editing',
      name: 'reason_for_editing',
      desc: '',
      args: [],
    );
  }

  /// `Wrong item price`
  String get wrong_item_price {
    return Intl.message(
      'Wrong item price',
      name: 'wrong_item_price',
      desc: '',
      args: [],
    );
  }

  /// `Their is some difference in current price`
  String get some_difference_in_current_price {
    return Intl.message(
      'Their is some difference in current price',
      name: 'some_difference_in_current_price',
      desc: '',
      args: [],
    );
  }

  /// `Out of Stock`
  String get out_of_stock {
    return Intl.message(
      'Out of Stock',
      name: 'out_of_stock',
      desc: '',
      args: [],
    );
  }

  /// `Item is not on the shelf`
  String get item_is_not_on_the_shelf {
    return Intl.message(
      'Item is not on the shelf',
      name: 'item_is_not_on_the_shelf',
      desc: '',
      args: [],
    );
  }

  /// `Poor Quality`
  String get poor_quality {
    return Intl.message(
      'Poor Quality',
      name: 'poor_quality',
      desc: '',
      args: [],
    );
  }

  /// `Item is in a bad condition`
  String get item_is_in_a_bad_condition {
    return Intl.message(
      'Item is in a bad condition',
      name: 'item_is_in_a_bad_condition',
      desc: '',
      args: [],
    );
  }

  /// `You can't Edit more than`
  String get cant_edit_more {
    return Intl.message(
      'You can\'t Edit more than',
      name: 'cant_edit_more',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Issue`
  String get please_enter_issue {
    return Intl.message(
      'Please Enter Issue',
      name: 'please_enter_issue',
      desc: '',
      args: [],
    );
  }

  /// `UPDATE`
  String get update {
    return Intl.message(
      'UPDATE',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `DELIVERY TYPE `
  String get delivery_type {
    return Intl.message(
      'DELIVERY TYPE ',
      name: 'delivery_type',
      desc: '',
      args: [],
    );
  }

  /// `DELIVERY`
  String get delivery {
    return Intl.message(
      'DELIVERY',
      name: 'delivery',
      desc: '',
      args: [],
    );
  }

  /// `GRAND TOTAL`
  String get grand_total {
    return Intl.message(
      'GRAND TOTAL',
      name: 'grand_total',
      desc: '',
      args: [],
    );
  }

  /// `Assign to Delivery Partner`
  String get assign_to_delivery_partner {
    return Intl.message(
      'Assign to Delivery Partner',
      name: 'assign_to_delivery_partner',
      desc: '',
      args: [],
    );
  }

  /// `Order updated successfully`
  String get order_updated_successfully {
    return Intl.message(
      'Order updated successfully',
      name: 'order_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `ORDER READY`
  String get order_ready {
    return Intl.message(
      'ORDER READY',
      name: 'order_ready',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message(
      'Order',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Items`
  String get items {
    return Intl.message(
      'Items',
      name: 'items',
      desc: '',
      args: [],
    );
  }

  /// `Assign to picker`
  String get assign_to_picker {
    return Intl.message(
      'Assign to picker',
      name: 'assign_to_picker',
      desc: '',
      args: [],
    );
  }

  /// `Are you Sure you want to assign order to`
  String get are_you_sure {
    return Intl.message(
      'Are you Sure you want to assign order to',
      name: 'are_you_sure',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Prepared`
  String get prepared {
    return Intl.message(
      'Prepared',
      name: 'prepared',
      desc: '',
      args: [],
    );
  }

  /// `Find customer by Name, Phone`
  String get find_customer {
    return Intl.message(
      'Find customer by Name, Phone',
      name: 'find_customer',
      desc: '',
      args: [],
    );
  }

  /// `Add Customer`
  String get add_customer {
    return Intl.message(
      'Add Customer',
      name: 'add_customer',
      desc: '',
      args: [],
    );
  }

  /// `Please Select User`
  String get please_select_user {
    return Intl.message(
      'Please Select User',
      name: 'please_select_user',
      desc: '',
      args: [],
    );
  }

  /// `PROCEED`
  String get proceed {
    return Intl.message(
      'PROCEED',
      name: 'proceed',
      desc: '',
      args: [],
    );
  }

  /// `LOGOUT`
  String get logout {
    return Intl.message(
      'LOGOUT',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Vendor`
  String get vendor {
    return Intl.message(
      'Vendor',
      name: 'vendor',
      desc: '',
      args: [],
    );
  }

  /// `failed`
  String get failed {
    return Intl.message(
      'failed',
      name: 'failed',
      desc: '',
      args: [],
    );
  }

  /// `delivered`
  String get delivered {
    return Intl.message(
      'delivered',
      name: 'delivered',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back!`
  String get welcome {
    return Intl.message(
      'Welcome Back!',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Please sign in to continue`
  String get please_sign {
    return Intl.message(
      'Please sign in to continue',
      name: 'please_sign',
      desc: '',
      args: [],
    );
  }

  /// `Email*`
  String get email {
    return Intl.message(
      'Email*',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Enter Password`
  String get enter {
    return Intl.message(
      'Enter Password',
      name: 'enter',
      desc: '',
      args: [],
    );
  }

  /// `ALL`
  String get ALL {
    return Intl.message(
      'ALL',
      name: 'ALL',
      desc: '',
      args: [],
    );
  }

  /// `Received`
  String get Received {
    return Intl.message(
      'Received',
      name: 'Received',
      desc: '',
      args: [],
    );
  }

  /// `Preparing`
  String get Preparing {
    return Intl.message(
      'Preparing',
      name: 'Preparing',
      desc: '',
      args: [],
    );
  }

  /// `Ready`
  String get Ready {
    return Intl.message(
      'Ready',
      name: 'Ready',
      desc: '',
      args: [],
    );
  }

  /// `Delivering`
  String get Delivering {
    return Intl.message(
      'Delivering',
      name: 'Delivering',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get Completed {
    return Intl.message(
      'Completed',
      name: 'Completed',
      desc: '',
      args: [],
    );
  }

  /// `Canceled`
  String get Canceled {
    return Intl.message(
      'Canceled',
      name: 'Canceled',
      desc: '',
      args: [],
    );
  }

  /// `avg`
  String get avg {
    return Intl.message(
      'avg',
      name: 'avg',
      desc: '',
      args: [],
    );
  }

  /// `Create Order`
  String get create_order {
    return Intl.message(
      'Create Order',
      name: 'create_order',
      desc: '',
      args: [],
    );
  }

  /// `Category Product Loading...`
  String get category_product {
    return Intl.message(
      'Category Product Loading...',
      name: 'category_product',
      desc: '',
      args: [],
    );
  }

  /// `No Product`
  String get no_product {
    return Intl.message(
      'No Product',
      name: 'no_product',
      desc: '',
      args: [],
    );
  }

  /// `Item`
  String get Item {
    return Intl.message(
      'Item',
      name: 'Item',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get Amount {
    return Intl.message(
      'Amount',
      name: 'Amount',
      desc: '',
      args: [],
    );
  }

  /// `Item Available`
  String get item_available {
    return Intl.message(
      'Item Available',
      name: 'item_available',
      desc: '',
      args: [],
    );
  }

  /// `Categories Loading...`
  String get categories_loading {
    return Intl.message(
      'Categories Loading...',
      name: 'categories_loading',
      desc: '',
      args: [],
    );
  }

  /// `Apply Promo Code`
  String get apply_promo {
    return Intl.message(
      'Apply Promo Code',
      name: 'apply_promo',
      desc: '',
      args: [],
    );
  }

  /// `member:`
  String get member {
    return Intl.message(
      'member:',
      name: 'member',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get Profile {
    return Intl.message(
      'Profile',
      name: 'Profile',
      desc: '',
      args: [],
    );
  }

  /// `Create Personal information`
  String get create_personal {
    return Intl.message(
      'Create Personal information',
      name: 'create_personal',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Number`
  String get mobile_number {
    return Intl.message(
      'Mobile Number',
      name: 'mobile_number',
      desc: '',
      args: [],
    );
  }

  /// `Email(optional)`
  String get email_opt {
    return Intl.message(
      'Email(optional)',
      name: 'email_opt',
      desc: '',
      args: [],
    );
  }

  /// `Name(optional)`
  String get name_opt {
    return Intl.message(
      'Name(optional)',
      name: 'name_opt',
      desc: '',
      args: [],
    );
  }

  /// `Guest User`
  String get Guest_User {
    return Intl.message(
      'Guest User',
      name: 'Guest_User',
      desc: '',
      args: [],
    );
  }

  /// `Order Created`
  String get Order_Created {
    return Intl.message(
      'Order Created',
      name: 'Order_Created',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get Create {
    return Intl.message(
      'Create',
      name: 'Create',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get Loading {
    return Intl.message(
      'Loading',
      name: 'Loading',
      desc: '',
      args: [],
    );
  }

  /// `All Sale`
  String get all_sale {
    return Intl.message(
      'All Sale',
      name: 'all_sale',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the fields`
  String get please_enter_the_fields {
    return Intl.message(
      'Please enter the fields',
      name: 'please_enter_the_fields',
      desc: '',
      args: [],
    );
  }

  /// `Invalid credentials`
  String get invalid_credentials {
    return Intl.message(
      'Invalid credentials',
      name: 'invalid_credentials',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get Login {
    return Intl.message(
      'Login',
      name: 'Login',
      desc: '',
      args: [],
    );
  }

  /// `Pending Order`
  String get pending_order {
    return Intl.message(
      'Pending Order',
      name: 'pending_order',
      desc: '',
      args: [],
    );
  }

  /// `No Product found....`
  String get No_Product_found {
    return Intl.message(
      'No Product found....',
      name: 'No_Product_found',
      desc: '',
      args: [],
    );
  }

  /// `Variation Name`
  String get variation_name {
    return Intl.message(
      'Variation Name',
      name: 'variation_name',
      desc: '',
      args: [],
    );
  }

  /// `Priority`
  String get priority {
    return Intl.message(
      'Priority',
      name: 'priority',
      desc: '',
      args: [],
    );
  }

  /// `Barcode`
  String get Barcode {
    return Intl.message(
      'Barcode',
      name: 'Barcode',
      desc: '',
      args: [],
    );
  }

  /// `HSN`
  String get HSN {
    return Intl.message(
      'HSN',
      name: 'HSN',
      desc: '',
      args: [],
    );
  }

  /// `Loyalty Points`
  String get loyalty_points {
    return Intl.message(
      'Loyalty Points',
      name: 'loyalty_points',
      desc: '',
      args: [],
    );
  }

  /// `Gross Weight(in kg)`
  String get gross_weight {
    return Intl.message(
      'Gross Weight(in kg)',
      name: 'gross_weight',
      desc: '',
      args: [],
    );
  }

  /// `Minimum Order Qty`
  String get minimum_order_qty {
    return Intl.message(
      'Minimum Order Qty',
      name: 'minimum_order_qty',
      desc: '',
      args: [],
    );
  }

  /// `Maximum Order Qty`
  String get maximum_order_qty {
    return Intl.message(
      'Maximum Order Qty',
      name: 'maximum_order_qty',
      desc: '',
      args: [],
    );
  }

  /// `Min-Max Expiry(Hours)`
  String get min_max_expiry {
    return Intl.message(
      'Min-Max Expiry(Hours)',
      name: 'min_max_expiry',
      desc: '',
      args: [],
    );
  }

  /// `Price Per Unit`
  String get price_per_unit {
    return Intl.message(
      'Price Per Unit',
      name: 'price_per_unit',
      desc: '',
      args: [],
    );
  }

  /// `Actual Price`
  String get actual_price {
    return Intl.message(
      'Actual Price',
      name: 'actual_price',
      desc: '',
      args: [],
    );
  }

  /// `Discounted Price`
  String get discounted_price {
    return Intl.message(
      'Discounted Price',
      name: 'discounted_price',
      desc: '',
      args: [],
    );
  }

  /// `Membership Price`
  String get membership_price {
    return Intl.message(
      'Membership Price',
      name: 'membership_price',
      desc: '',
      args: [],
    );
  }

  /// `Stock`
  String get Stock {
    return Intl.message(
      'Stock',
      name: 'Stock',
      desc: '',
      args: [],
    );
  }

  /// `SAVE`
  String get SAVE {
    return Intl.message(
      'SAVE',
      name: 'SAVE',
      desc: '',
      args: [],
    );
  }

  /// `No variations`
  String get no_variations {
    return Intl.message(
      'No variations',
      name: 'no_variations',
      desc: '',
      args: [],
    );
  }

  /// `Home Delivery`
  String get home_delivery {
    return Intl.message(
      'Home Delivery',
      name: 'home_delivery',
      desc: '',
      args: [],
    );
  }

  /// `Express Delivery`
  String get express_delivery {
    return Intl.message(
      'Express Delivery',
      name: 'express_delivery',
      desc: '',
      args: [],
    );
  }

  /// `Pick up from Store`
  String get pick_up_from_store {
    return Intl.message(
      'Pick up from Store',
      name: 'pick_up_from_store',
      desc: '',
      args: [],
    );
  }

  /// `Active\nOrders`
  String get Active_Orders {
    return Intl.message(
      'Active\nOrders',
      name: 'Active_Orders',
      desc: '',
      args: [],
    );
  }

  /// `Ticket\nWaiting`
  String get Ticket_Waiting {
    return Intl.message(
      'Ticket\nWaiting',
      name: 'Ticket_Waiting',
      desc: '',
      args: [],
    );
  }

  /// `Return\nReady`
  String get Return_Ready {
    return Intl.message(
      'Return\nReady',
      name: 'Return_Ready',
      desc: '',
      args: [],
    );
  }

  /// `Out For\nDelivery`
  String get Out_For_Delivery {
    return Intl.message(
      'Out For\nDelivery',
      name: 'Out_For_Delivery',
      desc: '',
      args: [],
    );
  }

  /// `Out For Delivery`
  String get out_For_Delivery {
    return Intl.message(
      'Out For Delivery',
      name: 'out_For_Delivery',
      desc: '',
      args: [],
    );
  }

  /// `Stock\nLow`
  String get Stock_Low {
    return Intl.message(
      'Stock\nLow',
      name: 'Stock_Low',
      desc: '',
      args: [],
    );
  }

  /// `Completed\nOrder`
  String get Completed_Order {
    return Intl.message(
      'Completed\nOrder',
      name: 'Completed_Order',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Product`
  String get Please_Select_Product {
    return Intl.message(
      'Please Select Product',
      name: 'Please_Select_Product',
      desc: '',
      args: [],
    );
  }

  /// `Please select customer to proceed`
  String get Please_select_customer_proceed {
    return Intl.message(
      'Please select customer to proceed',
      name: 'Please_select_customer_proceed',
      desc: '',
      args: [],
    );
  }

  /// `No customer found`
  String get No_customer_found {
    return Intl.message(
      'No customer found',
      name: 'No_customer_found',
      desc: '',
      args: [],
    );
  }

  /// `wallet`
  String get wallet {
    return Intl.message(
      'wallet',
      name: 'wallet',
      desc: '',
      args: [],
    );
  }

  /// `Wallet Balence `
  String get Wallet_Balence {
    return Intl.message(
      'Wallet Balence ',
      name: 'Wallet_Balence',
      desc: '',
      args: [],
    );
  }

  /// `Loyalty`
  String get Loyalty {
    return Intl.message(
      'Loyalty',
      name: 'Loyalty',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get Payment_Method {
    return Intl.message(
      'Payment Method',
      name: 'Payment_Method',
      desc: '',
      args: [],
    );
  }

  /// `Your Cart Value`
  String get Your_Cart_Value {
    return Intl.message(
      'Your Cart Value',
      name: 'Your_Cart_Value',
      desc: '',
      args: [],
    );
  }

  /// `You saved (Loyalty Coins)`
  String get You_saved {
    return Intl.message(
      'You saved (Loyalty Coins)',
      name: 'You_saved',
      desc: '',
      args: [],
    );
  }

  /// `Your Wallet Amount`
  String get Your_Wallet_Amount {
    return Intl.message(
      'Your Wallet Amount',
      name: 'Your_Wallet_Amount',
      desc: '',
      args: [],
    );
  }

  /// `invalid promocode!`
  String get invalid_promocode {
    return Intl.message(
      'invalid promocode!',
      name: 'invalid_promocode',
      desc: '',
      args: [],
    );
  }

  /// `You have applied `
  String get You_have_applied {
    return Intl.message(
      'You have applied ',
      name: 'You_have_applied',
      desc: '',
      args: [],
    );
  }

  /// ` promocode`
  String get promocode {
    return Intl.message(
      ' promocode',
      name: 'promocode',
      desc: '',
      args: [],
    );
  }

  /// `Total Amount Payable`
  String get Total_Amount_Payable {
    return Intl.message(
      'Total Amount Payable',
      name: 'Total_Amount_Payable',
      desc: '',
      args: [],
    );
  }

  /// `Your Savings`
  String get Your_Savings {
    return Intl.message(
      'Your Savings',
      name: 'Your_Savings',
      desc: '',
      args: [],
    );
  }

  /// `Select Payment Method`
  String get Select_Payment_Method {
    return Intl.message(
      'Select Payment Method',
      name: 'Select_Payment_Method',
      desc: '',
      args: [],
    );
  }

  /// `DASHBOARD`
  String get DASHBOARD {
    return Intl.message(
      'DASHBOARD',
      name: 'DASHBOARD',
      desc: '',
      args: [],
    );
  }

  /// `Mark as Preparing`
  String get mark_as_preparing {
    return Intl.message(
      'Mark as Preparing',
      name: 'mark_as_preparing',
      desc: '',
      args: [],
    );
  }

  /// `Assign to Deliver`
  String get assign_to_deliver {
    return Intl.message(
      'Assign to Deliver',
      name: 'assign_to_deliver',
      desc: '',
      args: [],
    );
  }

  /// `Mark as Delivered`
  String get mark_as_delivered {
    return Intl.message(
      'Mark as Delivered',
      name: 'mark_as_delivered',
      desc: '',
      args: [],
    );
  }

  /// `Mark as Completed`
  String get mark_as_completed {
    return Intl.message(
      'Mark as Completed',
      name: 'mark_as_completed',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'No Matches found' key

  /// `Available Coupons`
  String get Available_Coupons {
    return Intl.message(
      'Available Coupons',
      name: 'Available_Coupons',
      desc: '',
      args: [],
    );
  }

  /// `Recent Order`
  String get Recent_Orders {
    return Intl.message(
      'Recent Order',
      name: 'Recent_Orders',
      desc: '',
      args: [],
    );
  }

  /// `Barcode doesn't match`
  String get barcode_doesnt_match {
    return Intl.message(
      'Barcode doesn\'t match',
      name: 'barcode_doesnt_match',
      desc: '',
      args: [],
    );
  }

  /// `Create Item`
  String get Create_Item {
    return Intl.message(
      'Create Item',
      name: 'Create_Item',
      desc: '',
      args: [],
    );
  }

  /// `Item Name`
  String get item_name {
    return Intl.message(
      'Item Name',
      name: 'item_name',
      desc: '',
      args: [],
    );
  }

  /// `Stock Type`
  String get stock_type {
    return Intl.message(
      'Stock Type',
      name: 'stock_type',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Duration`
  String get delivery_duration {
    return Intl.message(
      'Delivery Duration',
      name: 'delivery_duration',
      desc: '',
      args: [],
    );
  }

  /// `Product Type`
  String get product_type {
    return Intl.message(
      'Product Type',
      name: 'product_type',
      desc: '',
      args: [],
    );
  }

  /// `Stock Notify`
  String get stock_notify {
    return Intl.message(
      'Stock Notify',
      name: 'stock_notify',
      desc: '',
      args: [],
    );
  }

  /// `Return Duration`
  String get return_duration {
    return Intl.message(
      'Return Duration',
      name: 'return_duration',
      desc: '',
      args: [],
    );
  }

  /// `Tax`
  String get Tax {
    return Intl.message(
      'Tax',
      name: 'Tax',
      desc: '',
      args: [],
    );
  }

  /// `Express Delivery Eligible`
  String get express_delivery_eligible {
    return Intl.message(
      'Express Delivery Eligible',
      name: 'express_delivery_eligible',
      desc: '',
      args: [],
    );
  }

  /// `Item Description`
  String get item_description {
    return Intl.message(
      'Item Description',
      name: 'item_description',
      desc: '',
      args: [],
    );
  }

  /// `Manufacturer Description`
  String get manufacturer_description {
    return Intl.message(
      'Manufacturer Description',
      name: 'manufacturer_description',
      desc: '',
      args: [],
    );
  }

  /// `Item Priority`
  String get item_priority {
    return Intl.message(
      'Item Priority',
      name: 'item_priority',
      desc: '',
      args: [],
    );
  }

  /// `Country of Origin`
  String get country_of_origin {
    return Intl.message(
      'Country of Origin',
      name: 'country_of_origin',
      desc: '',
      args: [],
    );
  }

  /// `Subscription Product`
  String get subscription_product {
    return Intl.message(
      'Subscription Product',
      name: 'subscription_product',
      desc: '',
      args: [],
    );
  }

  /// `Select Vendor`
  String get select_vendor {
    return Intl.message(
      'Select Vendor',
      name: 'select_vendor',
      desc: '',
      args: [],
    );
  }

  /// `Brand`
  String get Brand {
    return Intl.message(
      'Brand',
      name: 'Brand',
      desc: '',
      args: [],
    );
  }

  /// `SKU`
  String get SKU {
    return Intl.message(
      'SKU',
      name: 'SKU',
      desc: '',
      args: [],
    );
  }

  /// `Net Weight`
  String get net_weight {
    return Intl.message(
      'Net Weight',
      name: 'net_weight',
      desc: '',
      args: [],
    );
  }

  /// `Min`
  String get Min {
    return Intl.message(
      'Min',
      name: 'Min',
      desc: '',
      args: [],
    );
  }

  /// `Max`
  String get Max {
    return Intl.message(
      'Max',
      name: 'Max',
      desc: '',
      args: [],
    );
  }

  /// `Unit`
  String get Unit {
    return Intl.message(
      'Unit',
      name: 'Unit',
      desc: '',
      args: [],
    );
  }

  /// `Increment`
  String get Increment {
    return Intl.message(
      'Increment',
      name: 'Increment',
      desc: '',
      args: [],
    );
  }

  /// `Selling Price`
  String get selling_price {
    return Intl.message(
      'Selling Price',
      name: 'selling_price',
      desc: '',
      args: [],
    );
  }

  /// `Short Note`
  String get Short_Note {
    return Intl.message(
      'Short Note',
      name: 'Short_Note',
      desc: '',
      args: [],
    );
  }

  /// `Item Variations`
  String get item_variations {
    return Intl.message(
      'Item Variations',
      name: 'item_variations',
      desc: '',
      args: [],
    );
  }

  /// `All items need to be prepared to update the order`
  String get all_item_need {
    return Intl.message(
      'All items need to be prepared to update the order',
      name: 'all_item_need',
      desc: '',
      args: [],
    );
  }

  /// `There is no Delivery boy`
  String get there_is_no_delivery {
    return Intl.message(
      'There is no Delivery boy',
      name: 'there_is_no_delivery',
      desc: '',
      args: [],
    );
  }

  /// `ORDER COMPLETE`
  String get order_completed {
    return Intl.message(
      'ORDER COMPLETE',
      name: 'order_completed',
      desc: '',
      args: [],
    );
  }

  /// `DISPATCHED`
  String get DISPATCHED {
    return Intl.message(
      'DISPATCHED',
      name: 'DISPATCHED',
      desc: '',
      args: [],
    );
  }

  /// `RECEIVED`
  String get RECEIVED {
    return Intl.message(
      'RECEIVED',
      name: 'RECEIVED',
      desc: '',
      args: [],
    );
  }

  /// `PICK`
  String get PICK {
    return Intl.message(
      'PICK',
      name: 'PICK',
      desc: '',
      args: [],
    );
  }

  /// `CANCELLED`
  String get CANCELLED {
    return Intl.message(
      'CANCELLED',
      name: 'CANCELLED',
      desc: '',
      args: [],
    );
  }

  /// `Search For Order Id`
  String get Search_For_Order_Id {
    return Intl.message(
      'Search For Order Id',
      name: 'Search_For_Order_Id',
      desc: '',
      args: [],
    );
  }

  /// `OFFLINE`
  String get OFFLINE {
    return Intl.message(
      'OFFLINE',
      name: 'OFFLINE',
      desc: '',
      args: [],
    );
  }

  /// `ONLINE`
  String get ONLINE {
    return Intl.message(
      'ONLINE',
      name: 'ONLINE',
      desc: '',
      args: [],
    );
  }

  /// `ORDERS`
  String get ORDERS {
    return Intl.message(
      'ORDERS',
      name: 'ORDERS',
      desc: '',
      args: [],
    );
  }

  /// `MENU`
  String get MENU {
    return Intl.message(
      'MENU',
      name: 'MENU',
      desc: '',
      args: [],
    );
  }

  /// `INSIGHTS`
  String get INSIGHTS {
    return Intl.message(
      'INSIGHTS',
      name: 'INSIGHTS',
      desc: '',
      args: [],
    );
  }

  /// `SETTINGS`
  String get SETTINGS {
    return Intl.message(
      'SETTINGS',
      name: 'SETTINGS',
      desc: '',
      args: [],
    );
  }

  /// `onway`
  String get onway {
    return Intl.message(
      'onway',
      name: 'onway',
      desc: '',
      args: [],
    );
  }

  /// `Search by order details`
  String get search_by_order {
    return Intl.message(
      'Search by order details',
      name: 'search_by_order',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get new_delivery {
    return Intl.message(
      'New',
      name: 'new_delivery',
      desc: '',
      args: [],
    );
  }

  /// `Processing / Picking`
  String get processing_picking {
    return Intl.message(
      'Processing / Picking',
      name: 'processing_picking',
      desc: '',
      args: [],
    );
  }

  /// `Ready for delivery / Pickup`
  String get ready_delivery {
    return Intl.message(
      'Ready for delivery / Pickup',
      name: 'ready_delivery',
      desc: '',
      args: [],
    );
  }

  /// `Assigned`
  String get assigned {
    return Intl.message(
      'Assigned',
      name: 'assigned',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get Language {
    return Intl.message(
      'Language',
      name: 'Language',
      desc: '',
      args: [],
    );
  }

  /// `Search Orders`
  String get Search_Orders {
    return Intl.message(
      'Search Orders',
      name: 'Search_Orders',
      desc: '',
      args: [],
    );
  }

  /// `READY`
  String get READY {
    return Intl.message(
      'READY',
      name: 'READY',
      desc: '',
      args: [],
    );
  }

  /// `COMPLETED`
  String get COMPLETED {
    return Intl.message(
      'COMPLETED',
      name: 'COMPLETED',
      desc: '',
      args: [],
    );
  }

  /// `DELIVERED`
  String get DELIVERED {
    return Intl.message(
      'DELIVERED',
      name: 'DELIVERED',
      desc: '',
      args: [],
    );
  }

  /// `Add Product`
  String get add_product {
    return Intl.message(
      'Add Product',
      name: 'add_product',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Select Delivery Partner`
  String get select_delivery_partner {
    return Intl.message(
      'Select Delivery Partner',
      name: 'select_delivery_partner',
      desc: '',
      args: [],
    );
  }

  /// `Qty:`
  String get Qty {
    return Intl.message(
      'Qty:',
      name: 'Qty',
      desc: '',
      args: [],
    );
  }

  /// `No Order found`
  String get No_order_found {
    return Intl.message(
      'No Order found',
      name: 'No_order_found',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the mandatory fields`
  String get please_enter_the_mandatory_fields {
    return Intl.message(
      'Please enter the mandatory fields',
      name: 'please_enter_the_mandatory_fields',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid mobile number`
  String get please_enter_valid_mobile_number {
    return Intl.message(
      'Please enter valid mobile number',
      name: 'please_enter_valid_mobile_number',
      desc: '',
      args: [],
    );
  }

  /// `Export`
  String get Export {
    return Intl.message(
      'Export',
      name: 'Export',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get Cancel {
    return Intl.message(
      'Cancel',
      name: 'Cancel',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get Submit {
    return Intl.message(
      'Submit',
      name: 'Submit',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get Select_Language {
    return Intl.message(
      'Select Language',
      name: 'Select_Language',
      desc: '',
      args: [],
    );
  }

  /// `Variations`
  String get Variations {
    return Intl.message(
      'Variations',
      name: 'Variations',
      desc: '',
      args: [],
    );
  }

  /// `mai@gmail.com`
  String get mai {
    return Intl.message(
      'mai@gmail.com',
      name: 'mai',
      desc: '',
      args: [],
    );
  }

  /// `ADD NEW VARIATION`
  String get add_vartiation {
    return Intl.message(
      'ADD NEW VARIATION',
      name: 'add_vartiation',
      desc: '',
      args: [],
    );
  }

  /// `MRP`
  String get mrp {
    return Intl.message(
      'MRP',
      name: 'mrp',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get Status {
    return Intl.message(
      'Status',
      name: 'Status',
      desc: '',
      args: [],
    );
  }

  /// `Assigned Delivery`
  String get Assigned_Delivery {
    return Intl.message(
      'Assigned Delivery',
      name: 'Assigned_Delivery',
      desc: '',
      args: [],
    );
  }

  /// `Print`
  String get Print {
    return Intl.message(
      'Print',
      name: 'Print',
      desc: '',
      args: [],
    );
  }

  /// `Updated Successfully`
  String get updated_success {
    return Intl.message(
      'Updated Successfully',
      name: 'updated_success',
      desc: '',
      args: [],
    );
  }

  /// `Edit Product`
  String get Edit_Product {
    return Intl.message(
      'Edit Product',
      name: 'Edit_Product',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'tr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
