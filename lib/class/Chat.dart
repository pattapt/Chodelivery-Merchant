import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/struct/ChatModel.dart';
import 'package:showd_delivery/struct/MessageModel.dart';
import 'package:http/http.dart' as http;

class inChat extends Chodee {
  static Future<String?> getMerchantToken() async {
    final storage = FlutterSecureStorage();
    return storage.read(key: 'merchantToken');
  }
  
  static Future<String?> getAccessToken() async {
    final storage = FlutterSecureStorage();
    return storage.read(key: 'accessToken');
  }

  static Future<void> sendMessag(id,mess,token) async {
    try {
      String x = await getMerchantToken() ?? "";
      Map<String, dynamic> postData = {
          "chatId": id,
          "type": "Message",
          "message" : mess
      };
      String response =
          await Chodee.requestAPI('/api/merchant/v1/store/$x/chat/$token/Send', 'POST',postData);
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        // setOrderToken(jsonResponse["data"]["orderToken"]);
      }
      // return response;
    } catch (e) {
    }
  }

  static Future<void> getImage(String Chattoken,String msgToken) async {
    try {
      String x = await getMerchantToken() ?? "";
      String response =
          await Chodee.requestAPI('/api/merchant/v1/store/$x/chat/$Chattoken/Image/$msgToken', 'GET');
      dynamic jsonResponse = jsonDecode(response);
      print("jsonResponse");
      print(jsonResponse);
      // if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        // setOrderToken(jsonResponse["data"]["orderToken"]);
        // return File(response);
      // }
      // return response;
    } catch (e) {
    }
  }

  static Future<MessageModel> getMessage(String token) async {
    try {
      String x = await getMerchantToken() ?? "";
      String response =
          await Chodee.requestAPI('/api/merchant/v1/store/$x/chat/$token/Message', 'GET');
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        // setOrderToken(jsonResponse["data"]["orderToken"]);
        return messageModelFromJson(response);
      }
      return MessageModel();
      // return response;
    } catch (e) {
      return MessageModel();
    }
  }


  static Future<void> sendImage(img,String token) async {
    try {
      String x = await getMerchantToken() ?? "";
      String a = await getAccessToken() ?? "";
      var headers = {
        'Authorization': 'bearer $a',
        'Content-Type': 'application/json'
      };
      var request = http.MultipartRequest('POST', Uri.parse('https://mobile-api-gateway.patta.dev/api/merchant/v1/store/$x/chat/$token/SendImage'));
      request.files.add(await http.MultipartFile.fromPath('Image', img.path));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      }
      else{
        Chodee.showDailogCSG("ส่งไม่สำเร็จ","ท่านส่งรูปภาพไม่สำเร็จกรุุณาลองใหม่อีกครั้ง","ตกลง");
      }
      // return response;
    } catch (e) {
    }
  }

  static Future<ChatModel> getAllChat() async {
    try {
      String x = await getMerchantToken() ?? "";
      String response =
          await Chodee.requestAPI('/api/merchant/v1/store/$x/chat?page=1&limit=50', 'GET');
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        return chatModelFromJson(response);
      }
      return ChatModel();
      // return response;
    } catch (e) {
      return ChatModel();
      
    }
  }
}