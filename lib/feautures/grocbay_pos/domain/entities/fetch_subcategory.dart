

import '../../../../core/util/presentation/constants/ic_constants.dart';
import 'modle_entities.dart';

class FetchSubCategory {
  String? id;
  String? categoryName;
  String? iconImage;
  String? parentId;
  int? type;

  FetchSubCategory(
      {this.id, this.categoryName, this.iconImage, this.parentId, this.type});

  FetchSubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    iconImage = "${IConstants.API_IMAGE}sub-category/icons/"+json['icon_image'];
    parentId = json['parentId'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['icon_image'] = this.iconImage;
    data['parentId'] = this.parentId;
    data['type'] = this.type;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}