import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as fb;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/struct/invokeaccesstoken.dart';

class Auth extends Chodee {
  static void setRefreshToken(String refreshToken) {
    final storage = FlutterSecureStorage();
    storage.write(key: 'refreshToken', value: refreshToken);
  }

  static Future<String?> getRefreshToken() async {
    final storage = FlutterSecureStorage();
    return storage.read(key: 'refreshToken');
  }

  static void setAccessToken(String accessToken) {
    final storage = FlutterSecureStorage();
    storage.write(key: 'accessToken', value: accessToken);
  }

  static Future<String?> getAccessToken() async {
    final storage = FlutterSecureStorage();
    return storage.read(key: 'accessToken');
  }

  static void setIsLogin(bool isLogin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLogin", isLogin);
  }

  static Future<bool?> isLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLogin") ?? false;
  }

  static Future<InvokeAccessToken> grantAccessToken() async {
    try {
      String timestamp = Chodee.getTimestamp();
      String deviceID = await Chodee.getDeviceID();
      Map<String, dynamic> postData = {
        "refreshToken": await Auth.getRefreshToken() ?? "",
        "uuid": "-",
        "type": "grantAccess",
        "app_version": Chodee.appVersion,
        "timestamp": timestamp,
        "device_id": deviceID,
        "platform": Platform.isIOS ? "ios" : "android",
      };
      String response = await Chodee.requestAPI('/api/merchant/v1/auth/InvokeAccessToken', 'POST', postData);
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        setAccessToken(jsonResponse["data"]["access_token"]);
      }
      return invokeAccessTokenFromJson(response);
      // return response;
    } catch (e) {
      // debugPrint(e.toString());
      // Chodee.showDailogCSG(
      //     "ไม่สามารถทำรายการได้", e.toString().replaceAll("Exception: ", ""), "ปิด");
      return InvokeAccessToken();
    }
  }

  static Future<dynamic> initRegisterEmail(String email, String password, String name, String lastname) async {
    try {
      String timestamp = Chodee.getTimestamp();
      String deviceID = await Chodee.getDeviceID();
      Map<String, dynamic> postData = {
        "email": email.toString(),
        "password": password.toString(),
        "name": name.toString(),
        "role": "owner",
        "last_name": lastname.toString(),
        "app_version": Chodee.appVersion,
        "timestamp": timestamp,
        "device_id": deviceID,
        "platform": Platform.isIOS ? "ios" : "android",
      };

      String response = await Chodee.requestAPI('/api/merchant/v1/auth/registerAccount', 'POST', postData);
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        Chodee.showDailogCSG("สมัครสมาชิกสำเร็จ", "ท่านได้ทำการสมัครสมาชิกสำเร็จแล้วกรูณาทำการเข้าสู่ระบบเพื่อใช้งาน", "เข้าสู่ระบบ", () {
          Navigator.of(Chodee.context!).pushNamed('/Login');
        });
        // Navigator.of(Chodee.context!).pushNamed('/Login');
      }
      return response;
    } catch (e) {
      Chodee.showDailogCSG("ไม่สามารถทำรายการได้", e.toString().replaceAll("Exception: ", ""), "ปิด");
    }
  }

  static Future<dynamic> initLoginEmail(String email, String password) async {
    try {
      String timestamp = Chodee.getTimestamp();
      String deviceID = await Chodee.getDeviceID();
      Map<String, dynamic> postData = {
        "email": email.toString(),
        "password": password.toString(),
        "role": "owner",
        "app_version": Chodee.appVersion,
        "timestamp": timestamp,
        "device_id": deviceID,
        "platform": Platform.isIOS ? "ios" : "android",
      };
      String response = await Chodee.requestAPI('/api/merchant/v1/auth/Login', 'POST', postData);
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        setAccessToken(jsonResponse["data"]["access_token"]);
        setRefreshToken(jsonResponse["data"]["refresh_token"]);
        Auth.setIsLogin(true);
        // Map<String, dynamic> data = {
        //   "index": 0,
        //   "isFromLogin": true,
        // };
        Navigator.of(Chodee.context!).pushNamed('/home', arguments: true);
      }
      return response;
    } catch (e) {
      // Chodee.showDailogCSG(
      //     "ไม่สามารถทำรายการได้", e.toString().replaceAll("Exception: ", ""), "ปิด");
    }
  }
}
