import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/struct/ListItem.dart';

class Product extends Chodee {


  static Future<String?> getMerchantToken() async {
    final storage = FlutterSecureStorage();
    return storage.read(key: 'merchantToken');
  }
  static Future<String?> getAccessToken() async {
    final storage = FlutterSecureStorage();
    return storage.read(key: 'accessToken');
  }
   
  static Future<ListItemModel> getListItem(int page) async {
    try {
      String x = await getMerchantToken() ?? "";
      String response =
          await Chodee.requestAPI('/api/merchant/v1/store/$x/Products?page=${page.toString()}&limit=20', 'GET');
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        // setOrderToken(jsonResponse["data"]["orderToken"]);
        return listItemModelFromJson(response);
      }
      return ListItemModel();
      // return response;
    } catch (e) {
      return ListItemModel();
    }
  }
  static Future<void> uploadImg(img,String token) async {
    try {
      String x = await getMerchantToken() ?? "";
      String a = await getAccessToken() ?? "";
      var headers = {
        'Authorization': 'bearer $a',
        'Content-Type': 'application/json'
      };
      var request = http.MultipartRequest('POST', Uri.parse('https://mobile-api-gateway.patta.dev/api/merchant/v1/store/$x/Products/$token/UploadImage'));
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
  // static Future<void> uploadImg(img,String token) async {
  //   try {
  //     if (img == null) {
  //       return;
  //     }
  //     String x = await getMerchantToken() ?? "";
  //     Map<String, dynamic> postData = {
  //       "Image": img.path,
  //     };

  //     String response = await Chodee.requestAPI('/api/merchant/v1/store/$x/Products/$token/UploadImage', 'POST', postData);
  //     dynamic jsonResponse = jsonDecode(response);
  //     print(jsonResponse);
  //     if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
  //       // Chodee.showDailogCSG("สมัครสมาชิกสำเร็จ","ท่านได้ทำการสมัครสมาชิกสำเร็จแล้วกรูณาทำการเข้าสู่ระบบเพื่อใช้งาน","เข้าสู่ระบบ",(){Navigator.of(Chodee.context!).pushNamed('/Login');});
  //       // Navigator.of(Chodee.context!).pushNamed('/Login');
  //     }
  
  //   } catch (e) {
  //     // Chodee.showDailogCSG(
  //     //     "ไม่สามารถทำรายการได้", e.toString().replaceAll("Exception: ", ""), "ปิด");
  //   }
  // }

   static Future<ListItemModel> createItem(String name,String desc,int quantity,int price,String barcode,int cat,img) async {
    try {
      String x = await getMerchantToken() ?? "";
      Map<String, dynamic> postData = {
        "barcode": barcode,
        "categoryId": cat,
        "name": name,
        "description": desc,
        "price": price,
        "cost": price*0.7,
        "quantity": quantity,
        "status": "available",
        "visible": true
      };
      String response =
          await Chodee.requestAPI('/api/merchant/v1/store/$x/Products/Create', 'POST',postData);
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        // setOrderToken(jsonResponse["data"]["orderToken"]);
        uploadImg(img,jsonResponse["data"]["productToken"]);
        Chodee.showDailogCSG("เพิ่มสินค้าสำเร็จ","ท่านได้ทำการเพิ่มสินค้าสำเร็จแล้ว","ตกลง",(){Chodee.popPageFromEditProduct();});
      }
      return ListItemModel();
      // return response;
    } catch (e) {
      return ListItemModel();
    }
  }
  static Future<ListItemModel> editListItem(Datum orgData,String name,String desc,int quantity,int price,String barcode,int cat,String pToken,img) async {
    try {
      String x = await getMerchantToken() ?? "";
      Map<String, dynamic> postData = {
        "productId": orgData.productId,
        "barcode": barcode,
        "categoryId": cat,
        "name": name,
        "description": desc,
        "imageUrl": orgData.imageUrl,
        "price": price,
        "cost": orgData.cost,
        "quantity": quantity,
        "status": "available",
        "visible": false
      };
      uploadImg(img,pToken);
      String response =
          await Chodee.requestAPI('/api/merchant/v1/store/$x/Products/$pToken/Update', 'POST',postData);
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        // setOrderToken(jsonResponse["data"]["orderToken"]);
        Chodee.showDailogCSG("แก้ไขข้อมูลสำเร็จ","ท่านได้ทำการแก้้ไขข้อมูลสำเร็จแล้ว","ตกลง",(){Chodee.popPageFromEditProduct();});
      }
      return ListItemModel();
      // return response;
    } catch (e) {
      return ListItemModel();
    }
  }
}