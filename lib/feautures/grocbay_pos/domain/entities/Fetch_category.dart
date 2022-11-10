
import 'package:flutter/cupertino.dart';


import '../../../../core/util/presentation/constants/ic_constants.dart';
import 'modle_entities.dart';

class CategoryFetch{
  String? id;
  String? categoryName;
  String? description;
  String? iconImage;
  String? bannerImage;
  String? heading;

  CategoryFetch(
      {this.id,
        this.categoryName,
        this.description,
        this.iconImage,
        this.bannerImage,
        this.heading});

  CategoryFetch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    debugPrint("json['category_name']...."+json['category_name']);
    description = json['description'];
    iconImage = "${IConstants.API_IMAGE}sub-category/icons/"+json['icon_image'];
    bannerImage = json['bannerImage'];
    heading = json['heading'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['description'] = this.description;
    data['icon_image'] = this.iconImage;
    data['bannerImage'] = this.bannerImage;
    data['heading'] = this.heading;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id,categoryName,description,iconImage,bannerImage,heading];
}