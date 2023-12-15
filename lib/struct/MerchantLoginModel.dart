// To parse this JSON data, do
//
//     final merchantLoginModel = merchantLoginModelFromJson(jsonString);

import 'dart:convert';

MerchantLoginModel merchantLoginModelFromJson(String str) => MerchantLoginModel.fromJson(json.decode(str));

String merchantLoginModelToJson(MerchantLoginModel data) => json.encode(data.toJson());

class MerchantLoginModel {
    final int? statusCode;
    final String? status;
    final String? msg;
    final Data? data;

    MerchantLoginModel({
        this.statusCode,
        this.status,
        this.msg,
        this.data,
    });

    factory MerchantLoginModel.fromJson(Map<String, dynamic> json) => MerchantLoginModel(
        statusCode: json["status_code"],
        status: json["status"],
        msg: json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "msg": msg,
        "data": data?.toJson(),
    };
}

class Data {
    final int? sellerId;
    final String? sellerUuid;
    final String? role;
    final String? name;
    final String? lastName;
    final String? email;
    final int? merchantId;
    final String? profileImageUrl;
    final String? refreshToken;
    final String? accessToken;
    final DateTime? createDate;
    final DateTime? expiredDate;

    Data({
        this.sellerId,
        this.sellerUuid,
        this.role,
        this.name,
        this.lastName,
        this.email,
        this.merchantId,
        this.profileImageUrl,
        this.refreshToken,
        this.accessToken,
        this.createDate,
        this.expiredDate,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        sellerId: json["seller_id"],
        sellerUuid: json["seller_uuid"],
        role: json["role"],
        name: json["name"],
        lastName: json["last_name"],
        email: json["email"],
        merchantId: json["merchant_id"],
        profileImageUrl: json["profile_image_url"],
        refreshToken: json["refresh_token"],
        accessToken: json["access_token"],
        createDate: json["create_date"] == null ? null : DateTime.parse(json["create_date"]),
        expiredDate: json["expired_date"] == null ? null : DateTime.parse(json["expired_date"]),
    );

    Map<String, dynamic> toJson() => {
        "seller_id": sellerId,
        "seller_uuid": sellerUuid,
        "role": role,
        "name": name,
        "last_name": lastName,
        "email": email,
        "merchant_id": merchantId,
        "profile_image_url": profileImageUrl,
        "refresh_token": refreshToken,
        "access_token": accessToken,
        "create_date": createDate?.toIso8601String(),
        "expired_date": expiredDate?.toIso8601String(),
    };
}
