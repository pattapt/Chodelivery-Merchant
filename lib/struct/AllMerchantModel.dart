// To parse this JSON data, do
//
//     final allMerchantModel = allMerchantModelFromJson(jsonString);

import 'dart:convert';

AllMerchantModel allMerchantModelFromJson(String str) => AllMerchantModel.fromJson(json.decode(str));

String allMerchantModelToJson(AllMerchantModel data) => json.encode(data.toJson());

class AllMerchantModel {
    int? statusCode;
    String? status;
    String? msg;
    Data? data;

    AllMerchantModel({
        this.statusCode,
        this.status,
        this.msg,
        this.data,
    });

    factory AllMerchantModel.fromJson(Map<String, dynamic> json) => AllMerchantModel(
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
    int? pageId;
    int? totalPage;
    int? totalItem;
    List<Merchant>? merchants;

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
    int? id;
    String? uuid;
    String? name;
    String? description;
    bool? open;
    bool? visible;
    String? imageUrl;
    Address? address;
    DateTime? createDate;
    DateTime? updateDate;

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
    String? address;
    String? street;
    String? building;
    String? district;
    String? amphure;
    String? province;
    String? zipcode;

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
