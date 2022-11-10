class getLoyalty {
  String? id;
  String? status;
  String? type;
  String? minimumOrderAmount;
  String? points;
  String? maximumRedeem;
  String? discount;
  String? branch;

  getLoyalty(
      {this.id,
        this.status,
        this.type,
        this.minimumOrderAmount,
        this.points,
        this.maximumRedeem,
        this.discount,
        this.branch});

  getLoyalty.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    type = json['type'];
    minimumOrderAmount = json['minimum_order_amount'];
    points = json['points'];
    maximumRedeem = json['maximum_redeem'];
    discount = json['discount'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['type'] = this.type;
    data['minimum_order_amount'] = this.minimumOrderAmount;
    data['points'] = this.points;
    data['maximum_redeem'] = this.maximumRedeem;
    data['discount'] = this.discount;
    data['branch'] = this.branch;
    return data;
  }
}
