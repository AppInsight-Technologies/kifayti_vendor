class PosGetAllCount {
  int? activeorderscount;
  int? pickuporderscount;
  int? deliveredorderscount;
  int? processingorderscount;
  int? onwayorderscount;
  int? pendingorderscount;
  int? returnorderscount;
  int? readynorderscount;
  int? dispatchedorderscount;
  int? completedorderscount;
  int? allorderscount;
  int? homedeliveriescount;
  int? instoreorderscount;
  int? expressorderscount;
  int? customerscount;

  PosGetAllCount(
      {
        this.activeorderscount,
        this.pickuporderscount,
        this.deliveredorderscount,
        this.processingorderscount,
        this.onwayorderscount,
        this.pendingorderscount,
        this.returnorderscount,
        this.readynorderscount,
        this.dispatchedorderscount,
        this.completedorderscount,
        this.allorderscount,
        this.homedeliveriescount,
        this.instoreorderscount,
        this.expressorderscount,
        this.customerscount});

  PosGetAllCount.fromJson(Map<String, dynamic> json) {
    activeorderscount = json['activeorderscount'];
    pickuporderscount = json['pickuporderscount'];
    deliveredorderscount = json['deliveredorderscount'];
    processingorderscount = json['processingorderscount'];
    onwayorderscount = json['onwayorderscount'];
    readynorderscount = json['readyorderscount'];
    pendingorderscount = json['pendingorderscount'];
    returnorderscount = json['returnorderscount'];
    dispatchedorderscount = json['dispatchedorderscount'];
    completedorderscount = json['completedorderscount'];
    allorderscount = json['allorderscount'];
    homedeliveriescount = json['homedeliveriescount'];
    instoreorderscount = json['instoreorderscount'];
    expressorderscount = json['expressorderscount'];
    customerscount = json['customerscount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activeorderscount'] = this.activeorderscount;
    data['pickuporderscount'] = this.pickuporderscount;
    data['deliveredorderscount'] = this.deliveredorderscount;
    data['processingorderscount'] = this.processingorderscount;
    data['onwayorderscount'] = this.onwayorderscount;
  data['readynorderscount'] = this.readynorderscount;
    data['pendingorderscount'] = this.pendingorderscount;
    data['returnorderscount'] = this.returnorderscount;
    data['dispatchedorderscount'] = this.dispatchedorderscount;
    data['completedorderscount'] = this.completedorderscount;
    data['allorderscount'] = this.allorderscount;
    data['homedeliveriescount'] = this.homedeliveriescount;
    data['instoreorderscount'] = this.instoreorderscount;
    data['expressorderscount'] = this.expressorderscount;
    data['customerscount'] = this.customerscount;
    return data;
  }
}