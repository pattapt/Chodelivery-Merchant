import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/struct/AllMerchantModel.dart';
import 'package:showd_delivery/struct/MerchantCountModel.dart';
import 'package:showd_delivery/struct/MerchantDetailModel.dart';
import 'package:showd_delivery/struct/ProvModel.dart';
import 'package:showd_delivery/struct/SumModel.dart';
import 'package:http/http.dart' as http;

class Merchant extends Chodee {
  
  static void setMerchantToken(String Token) {
    final storage = FlutterSecureStorage();
    storage.write(key: 'merchantToken', value: Token);
  }

  static Future<String?> getMerchantToken() async {
    final storage = FlutterSecureStorage();
    return storage.read(key: 'merchantToken');
  }
  
  static Future<String?> getAccessToken() async {
    final storage = FlutterSecureStorage();
    return storage.read(key: 'accessToken');
  }

  static Future<void> uploadMerImg(img,String uuid) async {
    try {
      String x = await getAccessToken() ?? "";
      var headers = {
        'Authorization': 'bearer $x',
        'Content-Type': 'application/json'
      };
      var request = http.MultipartRequest('POST', Uri.parse('https://mobile-api-gateway.patta.dev/api/merchant/v1/store/$uuid/UpdateImage'));
      request.files.add(await http.MultipartFile.fromPath('Image', img.path));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      }
      else {
        print(response.reasonPhrase);
      }


    } catch (e) {
        print(e);
      // Chodee.showDailogCSG(
      //     "ไม่สามารถทำรายการได้", e.toString().replaceAll("Exception: ", ""), "ปิด");
    }
  }

  static Future<void> createStore(String name,String desc,String tel,String addr,String st,String build,int dis,int amp,int prov,String zip,img) async {
    try {
      Map<String, dynamic> postData = {
         "name" : name,
          "description" : desc,
          "promptPayPhone" : tel,
          "address" : addr,
          "street" : st,
          "building" : build,
          "district" : dis,
          "amphures" : amp,
          "provinces" : prov,
          "zipcode" : zip
      };
      String response =
          await Chodee.requestAPI('/api/merchant/v1/store/CreateMerchant', 'POST',postData);
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        // setOrderToken(jsonResponse["data"]["orderToken"]);
        uploadMerImg(img,jsonResponse["data"]["merchantUUID"]);
        Chodee.showDailogCSG("เพิ่มร้านค้าสำเร็จ","ท่านได้ทำการเพิ่มร้านค้าสำเร็จแล้วกรุณาล็อกอินอีกครั้ง","ตกลง",(){Chodee.openPage("/Login", 1);});
      }
      // return response;
    } catch (e) {
    }
  }

  static Future<SumModel> getSum() async {
    try {
      String x = await getMerchantToken() ?? "";
      String response =
          await Chodee.requestAPI('/api/merchant/v1/store/$x/Summary', 'GET');
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        return sumModelFromJson(response);
      }
      return SumModel();
      // return response;
    } catch (e) {
      return SumModel();
      
    }
  }
  static Future<ProvModel> getProv(String zip) async {
    try {
      String response =
          await Chodee.requestAPI('/api/merchant/v1/Util/GetProvince?zipcode=$zip', 'GET');
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        return provModelFromJson(response);
        }
        return ProvModel();
      // return response;
    } catch (e) {
      return ProvModel();
    }
  }

  static Future<void> getMerchant(int page,int lim) async {
    try {
      String response =
          await Chodee.requestAPI('/api/merchant/v1/store/GetMerchant?page=${page.toString()}&limit=${lim.toString()}', 'GET');
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        AllMerchantModel Data = allMerchantModelFromJson(response);
        if(Data.data!.merchants!.isEmpty){
          Chodee.showDailogCSG("คุณยังไม่มีร้านค้า","ท่านยังได้ทำการเพิ่มร้านค้า","ตกลง",(){Chodee.openPage("/CreateStore", 1);});
        }
        else{
          String merchantToken = Data.data?.merchants?[0].uuid ?? "";
          setMerchantToken(merchantToken);
        }
        }
      // return response;
    } catch (e) {
    }
  }
  static Future<void> editMerchantDetail(name,desc,tel,addr,st,build,dis,uuid,img) async {
    try {
      print(tel);
      Map<String, dynamic> postData = {
        "name": name,
        "description": desc,
        "promptPayPhone": tel,
        "open": true,
        "visible": true,
        "address": addr,
        "street": st,
        "building": build,
        "district": dis
      };
      uploadMerImg(img,uuid);
      String response =
          await Chodee.requestAPI('/api/merchant/v1/store/$uuid/Update', 'POST',postData);
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        // setOrderToken(jsonResponse["data"]["orderToken"]);
        Chodee.showDailogCSG("เพิ่มร้านค้าสำเร็จ","ท่านได้ทำการเพิ่มร้านค้าสำเร็จแล้วกรุณาล็อกอินอีกครั้ง","ตกลง",(){Chodee.openPage("/home", 4);});
      }
      // return response;
    } catch (e) {
    }
  }

  static Future<MerchantDetailModel> getMerchantDetail() async {
    try {
      String x = await getMerchantToken() ?? "";
      String response =
          await Chodee.requestAPI('/api/merchant/v1/store/$x/Detail', 'GET');
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        return merchantDetailModelFromJson(response);
      }
      return MerchantDetailModel();
      // return response;
    } catch (e) {
      return MerchantDetailModel();
    }
  }
}