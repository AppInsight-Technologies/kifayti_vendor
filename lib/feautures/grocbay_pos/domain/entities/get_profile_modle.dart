import 'package:flutter/material.dart';

import 'modle_entities.dart';

class GetCustomerProfile {
  List<CustomerData>? data;
  int? notificationCount;
  List<Prepaid>? prepaid;

  GetCustomerProfile({this.data, this.notificationCount, this.prepaid});

  GetCustomerProfile.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CustomerData>[];
      json['data'].forEach((v) {
        data!.add(new CustomerData.fromJson(v));
      });
    }
    notificationCount = json['notification_count'];
    if (json['prepaid'] != null) {
      prepaid = <Prepaid>[];
      json['prepaid'].forEach((v) {
        prepaid!.add(new Prepaid.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['notification_count'] = this.notificationCount;
    if (this.prepaid != null) {
      data['prepaid'] = this.prepaid!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CustomerData {
  int? id;
  String? email;
  String? mobileNumber;
  String? username;
  String? membership;
  String? area;
  String? ip;
  String? createdDate;
  String? channel;
  String? device;
  String? latitude;
  String? longitude;
  bool? isActive;
  String? branch;
  bool? isOnline;
  List<String>? roles;
  String? apiKey;
  String? otp;
  String? path;
  String? registrationKey;
  String? sex;
  String? myref;
  int? welcomebonus;
  List<Address>? billingAddress;

  CustomerData(
      {this.id,
        this.email,
        this.mobileNumber,
        this.username,
        this.membership,
        this.area,
        this.ip,
        this.createdDate,
        this.channel,
        this.device,
        this.latitude,
        this.longitude,
        this.isActive,
        this.branch,
        this.isOnline,
        this.roles,
        this.apiKey,
        this.otp,
        this.path,
        this.registrationKey,
        this.sex,
        this.myref,
        this.welcomebonus,
        this.billingAddress});

  CustomerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    username = json['username'];
    membership = json['membership'];
    area = json['area'];
    ip = json['ip'];
    createdDate = json['createdDate'];
    channel = json['channel'];
    device = json['device'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isActive = json['isActive'];
    branch = json['branch'];
    isOnline = json['isOnline'];
    roles = json['roles'].cast<String>();
    apiKey = json['apiKey'];
    otp = json['otp'];
    path = json['path'];
    registrationKey = json['registrationKey'];
    sex = json['sex'];
    myref = json['myref'];
    welcomebonus = json['welcomebonus'];
    if (json['billingAddress'] != null) {
      billingAddress = <Address>[];
      json['billingAddress'].forEach((v) {
        billingAddress!.add(new Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['mobileNumber'] = this.mobileNumber;
    data['username'] = this.username;
    data['membership'] = this.membership;
    data['area'] = this.area;
    data['ip'] = this.ip;
    data['createdDate'] = this.createdDate;
    data['channel'] = this.channel;
    data['device'] = this.device;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['isActive'] = this.isActive;
    data['branch'] = this.branch;
    data['isOnline'] = this.isOnline;
    data['roles'] = this.roles;
    data['apiKey'] = this.apiKey;
    data['otp'] = this.otp;
    data['path'] = this.path;
    data['registrationKey'] = this.registrationKey;
    data['sex'] = this.sex;
    data['myref'] = this.myref;
    data['welcomebonus'] = this.welcomebonus;
    if (this.billingAddress != null) {
      data['billingAddress'] =
          this.billingAddress!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Prepaid {
  int? postpaid;
  int? prepaid;
  double? loyalty;

  Prepaid({this.postpaid, this.prepaid, this.loyalty});

  Prepaid.fromJson(Map<String, dynamic> json) {
    postpaid = json['postpaid'];
    prepaid = json['prepaid'];
    loyalty = (json['loyalty'] as num).toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postpaid'] = this.postpaid;
    data['prepaid'] = this.prepaid;
    data['loyalty'] = this.loyalty;
    return data;
  }
}

class Address {
  int? id;
  String? customer;
  String? addressType;
  String? fullName;
  String? address;
  String? lattitude;
  String? logingitude;
  String? isdefault;
  String? pincode;
  IconData? addressicon;

  Address(
      {this.id,
        this.customer,
        this.addressType,
        this.fullName,
        this.address,
        this.lattitude,
        this.logingitude,
        this.isdefault,
        this.pincode,
        this.addressicon,
      });

  Address.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    customer = json['customer'];
    addressType = json['addressType'];
    fullName = json['fullName'];
    address = json['address'];
    lattitude = json['lattitude'];
    logingitude = json['logingitude'];
    isdefault = json['isdefault'];
    pincode = json['pincode'];
    addressicon= json['addressType'].toString().toLowerCase()=="home"? Icons.home:json['addressType'].toString().toLowerCase()=="work"?Icons.work:Icons.location_on;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer'] = this.customer;
    data['addressType'] = this.addressType;
    data['fullName'] = this.fullName;
    data['address'] = this.address;
    data['lattitude'] = this.lattitude;
    data['logingitude'] = this.logingitude;
    data['isdefault'] = this.isdefault;
    data['pincode'] = this.pincode;
    return data;
  }
}