import 'dart:convert';
import 'package:flutter/cupertino.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/struct/InOrderModel.dart';
import 'package:showd_delivery/struct/TransactionModel.dart';

class transaction extends Chodee {
  
  static void setOrderToken(String orderToken) {
    final storage = FlutterSecureStorage();
    storage.write(key: 'orderToken', value: orderToken);
  }

  static Future<String?> getMerchantToken() async {
    final storage = FlutterSecureStorage();
    return storage.read(key: 'merchantToken');
  }
   
  static Future<TransactionModel> updateStatus(String token,int id,String status) async {
    try {
      String x = await getMerchantToken() ?? "";
      Map<String, dynamic> postData = {
        "orderId" : id,
        "status" : status
      };
      String response =
          await Chodee.requestAPI('/api/merchant/v1/store/$x/Orders/$token/Update', 'POST',postData);
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        // setOrderToken(jsonResponse["data"]["orderToken"]);
        Chodee.showDailogCSG("สำเร็จ","ท่านได้ทำรายการสำเร็จแล้ว","ตกลง",(){Navigator.of(Chodee.context!).pushNamed('/home');});
      }
      return TransactionModel();
      // return response;
    } catch (e) {
      return TransactionModel();
    }
  }

  static Future<TransactionModel> getOrder() async {
    try {
      String x = await getMerchantToken() ?? "";
      String response =
          await Chodee.requestAPI('/api/merchant/v1/store/$x/Orders?page=1&limit=50', 'GET');
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        // setOrderToken(jsonResponse["data"]["orderToken"]);
        return transactionModelFromJson(response);
      }
      return TransactionModel();
      // return response;
    } catch (e) {
      return TransactionModel();
    }
  }

  static Future<InOrderModel> getInOrder(String to) async {
    try {
      String x = await getMerchantToken() ?? "";
      String response =
          await Chodee.requestAPI('/api/merchant/v1/store/$x/Orders/$to/Detail', 'GET');
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        // setOrderToken(jsonResponse["data"]["orderToken"]);
        return inOrderModelFromJson(response);
      }
      return InOrderModel();
      // return response;
    } catch (e) {
      return InOrderModel();
    }
  }
}