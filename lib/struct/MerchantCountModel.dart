// To parse this JSON data, do
//
//     final merchantCountModel = merchantCountModelFromJson(jsonString);

import 'dart:convert';

MerchantCountModel merchantCountModelFromJson(String str) => MerchantCountModel.fromJson(json.decode(str));

String merchantCountModelToJson(MerchantCountModel data) => json.encode(data.toJson());

class MerchantCountModel {
    final int? statusCode;
    final String? status;
    final String? msg;
    final Data? data;

    MerchantCountModel({
        this.statusCode,
        this.status,
        this.msg,
        this.data,
    });

    factory MerchantCountModel.fromJson(Map<String, dynamic> json) => MerchantCountModel(
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
    final int? pageId;
    final int? totalPage;
    final int? totalItem;
    final List<Merchant>? merchants;

    Data({
        this.pageId,
        this.totalPage,
        this.totalItem,
        this.merchants,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        pageId: json["pageId"],
        totalPage: json["totalPage"],
        totalItem: json["totalItem"],
        merchants: json["merchants"] == null ? [] : List<Merchant>.from(json["merchants"]!.map((x) => Merchant.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "pageId": pageId,
        "totalPage": totalPage,
        "totalItem": totalItem,
        "merchants": merchants == null ? [] : List<dynamic>.from(merchants!.map((x) => x.toJson())),
    };
}

class Merchant {
    final int? id;
    final String? uuid;
    final String? name;
    final String? description;
    final bool? open;
    final bool? visible;
    final String? imageUrl;
    final Address? address;
    final DateTime? createDate;
    final DateTime? updateDate;

    Merchant({
        this.id,
        this.uuid,
        this.name,
        this.description,
        this.open,
        this.visible,
        this.imageUrl,
        this.address,
        this.createDate,
        this.updateDate,
    });

    factory Merchant.fromJson(Map<String, dynamic> json) => Merchant(
        id: json["id"],
        uuid: json["uuid"],
        name: json["name"],
        description: json["description"],
        open: json["open"],
        visible: json["visible"],
        imageUrl: json["image_url"],
        address: json["Address"] == null ? null : Address.fromJson(json["Address"]),
        createDate: json["CreateDate"] == null ? null : DateTime.parse(json["CreateDate"]),
        updateDate: json["UpdateDate"] == null ? null : DateTime.parse(json["UpdateDate"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "name": name,
        "description": description,
        "open": open,
        "visible": visible,
        "image_url": imageUrl,
        "Address": address?.toJson(),
        "CreateDate": createDate?.toIso8601String(),
        "UpdateDate": updateDate?.toIso8601String(),
    };
}

class Address {
    final String? address;
    final String? street;
    final String? building;
    final String? district;
    final String? amphure;
    final String? province;
    final String? zipcode;

    Address({
        this.address,
        this.street,
        this.building,
        this.district,
        this.amphure,
        this.province,
        this.zipcode,
    });

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        address: json["address"],
        street: json["street"],
        building: json["building"],
        district: json["district"],
        amphure: json["amphure"],
        province: json["province"],
        zipcode: json["zipcode"],
    );

    Map<String, dynamic> toJson() => {
        "address": address,
        "street": street,
        "building": building,
        "district": district,
        "amphure": amphure,
        "province": province,
        "zipcode": zipcode,
    };
}
