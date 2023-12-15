import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:crypto/crypto.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showd_delivery/class/auth.dart';
import 'package:showd_delivery/main.dart';

class Chodee {
  static String baseApiUrl = "https://mobile-api-gateway.patta.dev";
  static BuildContext? context = navigatorKey.currentContext!;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static const String appVersion = "1.0.0";

  static String getTimestamp() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  static String generateNonce() {
    final randomBytes = Random.secure().nextInt(1000000000).toString();
    final bytes = utf8.encode(randomBytes);
    final hash = sha256.convert(bytes);
    final nonce = base64Url.encode(hash.bytes);
    return nonce;
  }

  static Future<String> getDeviceID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("deviceId") ?? "";
  }

  static Future<http.StreamedResponse> getImageData(String endPoint, String method, [dynamic postData = null, dynamic headersData = null]) async {
    try {
      Map<String, String> postHeader = {};
      if (headersData != null) {
        for (var key in headersData.keys) {
          postHeader[key] = headersData[key];
        }
      }

      Uri uri = Uri.parse(endPoint);
      if (postData != null && method == "GET") {
        uri = uri.replace(queryParameters: postData);
      }
      String timestamp = getTimestamp();
      String nonce = generateNonce();
      http.Request request = http.Request(method, uri);
      request.headers.addAll(postHeader);
      request.headers['content-type'] = 'application/json';
      request.headers['cache-control'] = 'true';
      request.headers['timestamp'] = timestamp;
      request.headers['nonce'] = nonce;

      String accessToken = await Auth.getAccessToken() ?? "";
      if (accessToken != "" && accessToken.isNotEmpty && !endPoint.contains("mobile-auth-services")) {
        request.headers['authorization'] = "bearer " + accessToken;
      }
      var response = await request.send();
      return response;
    } catch (e) {
      return http.StreamedResponse(
        http.ByteStream.fromBytes([]),
        404,
        headers: {},
        reasonPhrase: e.toString(),
      );
    }
  }

  static Future<List<int>> getImagePrivate(String endpoint) async {
    dynamic processedResponse = await Chodee.getImageData(endpoint, "GET");
    if (processedResponse is http.StreamedResponse) {
      // Handle image response
      final response = processedResponse as http.StreamedResponse;
      if (response.headers['content-type']?.contains('image/jpeg') == true || response.headers['content-type']?.contains('image/png') == true) {
        return await response.stream.toBytes();
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  static Future<String> requestAPI(String endPoint, String method, [dynamic postData = null, dynamic headersData = null]) async {
    try {
      Uri uri = Uri.parse(baseApiUrl + endPoint);
      if (postData != null && method == "GET") {
        uri = uri.replace(queryParameters: postData);
      }
      String timestamp = getTimestamp();
      String nonce = generateNonce();
      http.Request request = http.Request(method, uri);
      request.headers['content-type'] = 'application/json';
      request.headers['cache-control'] = 'true';
      request.headers['timestamp'] = timestamp;
      request.headers['nonce'] = nonce;

      String accessToken = await Auth.getAccessToken() ?? "";
      if (accessToken != "" && accessToken.isNotEmpty && !endPoint.contains("auth")) {
        request.headers['authorization'] = "bearer " + accessToken;
      }
      var response = await request.send();
      return await processResponse(response);
    } catch (e) {
      // showDailogCSG("ไม่สามารถทำรายการได้","ไม่สามารถทำรายการได้ เนื่องจากข้อมูลไม่ถูกต้อง โปรดแก้ไขข้อมูลแล้วลองใหม่ภายหลัง","ปิด");
      return "";
    }
  }

  static Future<dynamic> processResponse(http.StreamedResponse response) async {
    switch (response.statusCode) {
      case 200:
        String contentType = response.headers['content-type'] ?? '';
        if (contentType.contains('jpeg')) {
          return response;
        } else {
          String responseBody = await response.stream.bytesToString();
          dynamic jsonResponse = jsonDecode(responseBody);
          if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] != 200) {
            showDailogCSG("ไม่สามารถทำรายการได้", "ไม่สามารถทำรายการได้ เนื่องจากข้อมูลไม่ถูกต้อง โปรดแก้ไขข้อมูลแล้วลองใหม่ภายหลัง", "ปิด");
          }
          return responseBody;
        }
      case 400:
        String responseBody = await response.stream.bytesToString();
        dynamic jsonResponse = jsonDecode(responseBody);
        if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] != 200) {
          showDailogCSG(jsonResponse['data']['title'], jsonResponse['data']['description'], "ปิด");
        }
        return responseBody;
      case 401:
        throw Exception('คุณทำรายการเกินเวลาที่กำหนดแล้ว กรุณาเข้าสู่ระบบใหม่อีกครั้งเพื่อใช้งานต่อ');
      case 403:
        throw Exception('คุณไม่มีสิทธิ์เข้าถึงข้อมูล');
      case 404:
        throw Exception('ไม่พบข้อมูลที่คุณต้องการ อาจถูกย้ายหรือลบออกแล้ว กรุณาตรวจสอบข้อมูล แล้วลองใหม่อีกครั้ง');
      case 500:
        throw Exception('ระบบไม่สามารถใช้งานได้ในขณะนี้ โปรดเว้นช่วงเวลาการทำรายการ แล้วลองทำรายการใหม่ภายหลัง');
      default:
        throw Exception('ระบบเกิดข้อผิดพลาดในการทำรายการ โปรดเว้นช่วงเวลาการทำรายการ แล้วลองทำรายการใหม่ภายหลัง');
    }
  }

  static void showDailogCSG(String title, String description, String btnText, [VoidCallback? onClicked]) {
    onClicked ??= () {
      Navigator.of(context!).pop();
    };
    showDialog(
      context: context!,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(45),
                    backgroundColor: Color.fromARGB(255, 0, 208, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: onClicked,
                  child: Text(
                    btnText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static void openPage(String url, dynamic args) async {
    navigatorKey.currentState?.pushNamed(url, arguments: args);
  }

  static void popPageFromEditProduct() async {
    navigatorKey.currentState?.pop();
    navigatorKey.currentState?.pushNamed('/home', arguments: 2);
  }
}
