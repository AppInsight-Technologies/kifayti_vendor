class GetBrands {
  String? id;
  String? categoryName;
  String? iconImage;

  GetBrands({this.id, this.categoryName, this.iconImage});

  GetBrands.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    iconImage = json['icon_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['icon_image'] = this.iconImage;
    return data;
  }
}
