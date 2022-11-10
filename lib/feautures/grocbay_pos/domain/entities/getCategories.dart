class GetCategories {
  String? id;
  String? categoryName;
  List<SubCategory>? subCategory;
  int? type;

  GetCategories({this.id, this.categoryName, this.subCategory, this.type});

  GetCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    if (json['SubCategory'] != null) {
      subCategory = <SubCategory>[];
      json['SubCategory'].forEach((v) {
        subCategory!.add(new SubCategory.fromJson(v));
      });
    }
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    if (this.subCategory != null) {
      data['SubCategory'] = this.subCategory!.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    return data;
  }
}

class SubCategory {
  String? id;
  String? categoryName;
  List<Nested>? nested;

  SubCategory({this.id, this.categoryName, this.nested});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['categoryName'];
    if (json['nested'] != null) {
      nested = <Nested>[];
      json['nested'].forEach((v) {
        nested!.add(new Nested.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryName'] = this.categoryName;
    if (this.nested != null) {
      data['nested'] = this.nested!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Nested {
  String? id;
  String? categoryName;
  String? categorySlug;
  String? iconImage;
  String? bannerImage;
  String? categoryDescription;
  String? parentId;
  String? featured;
  String? priority;
  String? status;
  String? nested;
  String? branch;
  String? ref;
  String? refdata;

  Nested(
      {this.id,
        this.categoryName,
        this.categorySlug,
        this.iconImage,
        this.bannerImage,
        this.categoryDescription,
        this.parentId,
        this.featured,
        this.priority,
        this.status,
        this.nested,
        this.branch,
        this.ref,
        this.refdata});

  Nested.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['categoryName'];
    categorySlug = json['categorySlug'];
    iconImage = json['iconImage'];
    bannerImage = json['bannerImage'];
    categoryDescription = json['categoryDescription'];
    parentId = json['parent_id'];
    featured = json['featured'];
    priority = json['priority'];
    status = json['status'];
    nested = json['nested'];
    branch = json['branch'];
    ref = json['ref'];
    refdata = json['refdata'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryName'] = this.categoryName;
    data['categorySlug'] = this.categorySlug;
    data['iconImage'] = this.iconImage;
    data['bannerImage'] = this.bannerImage;
    data['categoryDescription'] = this.categoryDescription;
    data['parent_id'] = this.parentId;
    data['featured'] = this.featured;
    data['priority'] = this.priority;
    data['status'] = this.status;
    data['nested'] = this.nested;
    data['branch'] = this.branch;
    data['ref'] = this.ref;
    data['refdata'] = this.refdata;
    return data;
  }
}
