class checkLoyalty {
  double? points;

  checkLoyalty({this.points});

  checkLoyalty.fromJson(Map<String, dynamic> json) {
    if(json["status"]==null) {
      points = (json['points'] as num).toDouble();
    }else {
      points =0;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['points'] = this.points;
    return data;
  }
}
