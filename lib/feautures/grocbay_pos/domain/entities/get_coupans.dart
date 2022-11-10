class getCoupans {
  String? id;
  String? promocode;
  String? description;
  String? appliedFor;

  getCoupans({this.id, this.promocode, this.description, this.appliedFor});

  getCoupans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    promocode = json['promocode'];
    description = json['description'];
    appliedFor = json['appliedFor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['promocode'] = this.promocode;
    data['description'] = this.description;
    data['appliedFor'] = this.appliedFor;
    return data;
  }
}
