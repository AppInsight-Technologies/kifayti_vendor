import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../injection_container.dart';
import '../../domain/repositorie/repository_provider.dart';
import '../models/repository_modle.dart';

abstract class RemoteDataSource{
  Future<RepositoryModel> getRequest(Params param);
}
class RemoteDataSourceImpl implements RemoteDataSource{

  final http.Client client;

  final baseurl =IConstants.API_URI;
  late http.Response responsejs;

  RemoteDataSourceImpl({ required this.client});

  @override
  Future<RepositoryModel> getRequest(Params param) => _getTriviaFromUrlNew(param);

  Future<RepositoryModel> _getTriviaFromUrl(Params param) async {
    debugPrint("stateing");
    String meadiater = '';
    try {
      if(param.methed==Methed.Get){
        meadiater = "?";
        param.data!.forEach((key, value) {
          if(!meadiater.substring(meadiater.length - 1).contains("?")) {
            meadiater = meadiater+"&";
          }
          meadiater = meadiater+key+"="+value;
        });
        print("$baseurl${param.uri}$meadiater");
        // final String url = "https://manage.grocbay.com/api/app-manager/get-functionality/${param.uri}";
      }else {
        if (kDebugMode) {
          print("$baseurl${param.uri}${param.data!.map((key, value) => MapEntry(key, value.toString())).toString()}");
        }
      }
      // final response = param.methed==Methed.Get?await client.get(
      //   Uri.parse("https://manage.grocbay.com/api/app-manager/get-functionality/${param.uri}/$meadiater"),
      //   headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      // ):  param.methed==Methed.PostJson? await client.post(Uri.parse("https://manage.grocbay.com/api/app-manager/get-functionality/${param.uri}"),body: json.encode(param.data),   headers: {'Content-Type': 'application/json'},):await client.post(Uri.parse("https://manage.grocbay.com/api/app-manager/get-functionality/${param.uri}"),body: param.data,   headers: {'Content-Type': 'application/x-www-form-urlencoded'},);
      // print("url data:${param.data.toString()}");

      // print("response: ${response.body}");
      var headers = param.methed==Methed.PostJson? {
        'Content-Type': 'application/json',

      }:{
        'Content-Type': 'application/x-www-form-urlencoded',
      };
      var request = http.Request(param.methed==Methed.Get?'GET':'POST', Uri.parse('$baseurl${param.uri}$meadiater'));
      param.methed==Methed.PostJson? request.body = json.encode(param.data):request.bodyFields = param.data!.map((key, value) => MapEntry(key, value.toString()));
      request.headers.addAll(headers);
      http.StreamedResponse responses = await request.send();
      print("status code ${responses.statusCode }");
      print("$baseurl${param.uri} parms${param.data.toString()}");
      if (responses.statusCode == 200) {
        final response = await responses.stream.bytesToString();
        print(json.decode(response).toString());
        if(json.decode(response)[0]!=null){
          ///if Response is writern [{}]
          return RepositoryModel(json.decode(response)[0]);
        }else if(json.decode(response)["data"]!=null) {
          ///if Response is written {'data':[]}
          if (json.decode(response)["status"].toString() == "200") {
            return RepositoryModel(json.decode(response));
          }else if(json.decode(response)["status"].toString() == "400"){
            throw ServerExceptions(responses.statusCode,"Invalid Logins");
          } else if (json.decode(response)["status"] == true) {
            return RepositoryModel(json.decode(response));
          } else {
            print(response);
            throw ServerExceptions((json.decode(response)["status"] is bool)?500:int.parse(json.decode(response)["status"].toString()),response);
          }
        }else{
          ///if Response is written {[]}
          print("fdjjhsd..."+response.toString());
          return RepositoryModel(json.decode(response));
        }
      } else {
        // print(await responses.stream.bytesToString());
        throw ServerExceptions(responses.statusCode,await responses.stream.bytesToString());
      }
    } on Exception catch (e) {
      debugPrint("Error while fetching server data: $e");
      throw ServerExceptions(500,e.toString());
      // TODO
    }
  }
  Future<RepositoryModel> _getTriviaFromUrlNew(Params param) async {
    print("stateing");
    String meadiater = '';
    try {
      if(param.methed==Methed.Get){
        meadiater = "?";
        param.data!.forEach((key, value) {
          if(!meadiater.substring(meadiater.length - 1).contains("?")) {
            meadiater = meadiater+"&";
          }
          meadiater = meadiater+key+"="+value;
        });
        print("$baseurl${param.uri}$meadiater");
        // final String url = "https://manage.grocbay.com/api/app-manager/get-functionality/${param.uri}";
      }else {
        if (kDebugMode) {
          print("$baseurl${param.uri}${param.data!.map((key, value) => MapEntry(key, value.toString())).toString()}");
        }
      }
      // final response = param.methed==Methed.Get?await client.get(
      //   Uri.parse("https://manage.grocbay.com/api/app-manager/get-functionality/${param.uri}/$meadiater"),
      //   headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      // ):  param.methed==Methed.PostJson? await client.post(Uri.parse("https://manage.grocbay.com/api/app-manager/get-functionality/${param.uri}"),body: json.encode(param.data),   headers: {'Content-Type': 'application/json'},):await client.post(Uri.parse("https://manage.grocbay.com/api/app-manager/get-functionality/${param.uri}"),body: param.data,   headers: {'Content-Type': 'application/x-www-form-urlencoded'},);
      // print("url data:${param.data.toString()}");

      // print("response: ${response.body}");
      print("Json Value");
      if(param.methed == Methed.PostJson){
        final Map<String,String> resBody = {
          "userId": param.data!['userId'],
          "walletType": param.data!['walletType'],
          "walletBalance": param.data!['walletBalance'],
          "apiKey": param.data!['apiKey'],
          "restId": param.data!['restId'],
          "addressId": param.data!['addressId'],
          "orderType": param.data!['orderType'],
          "paymentType": param.data!['paymentType'],
          "promocode": param.data!['promocode'],
          "fix_time": "9:00 AM - 9:00 PM",
          "fixdate": param.data!['fixdate'],
          "promo":param.data!['promo'],
          "only": param.data!['only'],
          "channel": param.data!['channel'],
          "membership": param.data!['membership'],
          "membership_active": param.data!['membership_active'],
          "note": "",
          "branch": param.data!['branch'],
          "survey_mode": "0",
          "loyalty": param.data!['loyalty'],
          "loyalty_points": param.data!['loyalty_points'],
          "point": param.data!['point'],
          "version": "",
          "device": "POS",
          "posId":sl<SharedPreferences>().getString(Prefrence.posId)!,
          "posPoint":sl<SharedPreferences>().getString(Prefrence.posPoint)!,

          // "userId": "100",
          // "walletType": "4",
          // "walletBalance": "0",
          // "apiKey": "100",
          // "restId": "0",
          // "addressId": "0",
          // "orderType": "instore",
          // "paymentType": "cash",
          // "promocode": "",
          // "fix_time": "9:00 AM - 9:00 PM",
          // "fixdate": "07-06-2022",
          // "promo": "",
          // "only": "0",
          // "channel": "POS",
          // "membership": "0",
          // "membership_active": "0",
          // "note": "",
          // "branch": "999",
          // "survey_mode": "0",
          // "loyalty": "0",
          // "loyalty_points": "0",
          // "point": "0.0",
          // "version": "",
          // "device": "POS",
          // "posId": "100008",
          // "posPoint": "Point2",

          /*"items": [
                {
                  "productId": 1685,
                  "priceVariation": 1685,
                  "quantity": 1,
                  "mrp": 25,
                  "price": 25,
                  "type": "Kg",
                  "weight": 0.7
                }
              ]*/
        };
        int index = 0;
        param.data!['items']!.forEach((value)  {
          resBody['items[${index}][productId]'] = value['productId'];
          resBody['items[${index}][priceVariation]'] = value['priceVariation'];
          resBody['items[${index}][quantity]'] = value['quantity'];
          resBody['items[${index}][mrp]'] = value['mrp'];
          resBody['items[${index}][price]'] = value['price'];
          resBody['items[${index}][type]'] = value['type'];
          resBody['items[${index}][weight]'] = value['weight'];
          resBody['items[${index}][package]'] = "0";
          resBody['items[${index}][packageVarId]'] = "0";
          resBody['items[${index}][packageMenuId]'] = "0";
          index ++;
        });
        print("resp:${resBody}");
        responsejs = await http.post(Uri.parse('$baseurl${param.uri}$meadiater'),
            // headers: { 'Content-Type': "application/x-www-form-urlencoded",
            //   "Accept":'*/*',
            //   'Accept-Encoding':'gzip, deflate, br',},
            body: resBody
        );
        debugPrint("responsejs...."+responsejs.toString());
       // final responseJson = json.decode(utf8.decode(responsejs.bodyBytes));

        /*String jsonsDataString = responsejs.toString(); // Error: toString of Response is assigned to jsonDataString.
        final responseJson = jsonDecode(jsonsDataString);
        print(responseJson.toString());*/
        print("response json...."+responsejs.toString());
      }
      else  if(param.methed == Methed.Post){
        debugPrint("innn");
        responsejs = await http.post(Uri.parse('$baseurl${param.uri}$meadiater'),
            headers: {"Content-Type": "application/x-www-form-urlencoded"},
            body: param.data!.map((key, value) => MapEntry(key, value.toString()))
        );
      }
      else {
        responsejs = await http.get(Uri.parse('$baseurl${param.uri}$meadiater'),headers: {"Content-Type": "application/x-www-form-urlencoded"});
      }
      /*  var request = http.Request(param.methed==Methed.Get?'GET':'POST', Uri.parse('$baseurl${param.uri}$meadiater'));
      param.methed==Methed.PostJson? request.body = json.encode(param.data):request.bodyFields = param.data!.map((key, value) => MapEntry(key, value.toString()));
      request.headers.addAll(headers);
      http.StreamedResponse responses = await request.send();
      print("status code ${responses.statusCode }");
      print("$baseurl${param.uri} parms${param.data.toString()}");*/
      print("status code ${responsejs.statusCode }");
      if (responsejs.statusCode == 200) {
        final response = responsejs.body;
        if(json.decode(response)[0]!=null){
          ///if Response is writern [{}]
          return RepositoryModel(json.decode(response)[0]);
        }else if(json.decode(response)["data"]!=null) {
          ///if Response is written {'data':[]}
         if (json.decode(response)["status"].toString() == "200") {
            return RepositoryModel(json.decode(response));
          }
         else if (json.decode(response)["status"].toString() == "true") {
            print("response.....22");
            return RepositoryModel(json.decode(response));

          }
          else if(json.decode(response)["status"].toString() == "400"){
            print("response.....3");
            throw ServerExceptions(responsejs.statusCode,"Invalid Logins");
          } else if (json.decode(response)["status"] == true) {
            return RepositoryModel(json.decode(response));
          } else {
            print(response);
            throw ServerExceptions((json.decode(response)["status"] is bool)?500:int.parse(json.decode(response)["status"].toString()),response);
          }
        }else{
          ///if Response is written {[]}
          return RepositoryModel(json.decode(response));
        }
      } else {
        // print(await responses.stream.bytesToString());
        throw ServerExceptions(responsejs.statusCode, responsejs.body);
      }
    } on Exception catch (e) {
      debugPrint("Error while fetching server data: $e");
      throw ServerExceptions(500,e.toString());
      // TODO
    }
  }

}