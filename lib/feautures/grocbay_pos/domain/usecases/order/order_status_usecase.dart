import 'dart:convert';

import 'package:flutter/material.dart';

class OrderStatusUseCase{
  call(context)async {
    String data = await DefaultAssetBundle.of(context).loadString("assets/json_data/order_status.json");
    final jsonResult = jsonDecode(data);

  }
}