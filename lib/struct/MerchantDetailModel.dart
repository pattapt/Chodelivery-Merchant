// To parse this JSON data, do
//
//     final merchantDetailModel = merchantDetailModelFromJson(jsonString);

import 'dart:convert';

MerchantDetailModel merchantDetailModelFromJson(String str) => MerchantDetailModel.fromJson(json.decode(str));

String merchantDetailModelToJson(MerchantDetailModel data) => json.encode(data.toJson());

class MerchantDetailModel {
    final int? statusCode;
    final String? status;
    final String? msg;
    final Data? data;

    MerchantDetailModel({
        this.statusCode,
        this.status,
        this.msg,
        this.data,
    });

    factory MerchantDetailModel.fromJson(Map<String, dynamic> json) => MerchantDetailModel(
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
    final int? id;
    final String? uuid;
    final String? name;
    final String? description;
    final String? promptPayPhone;
    final bool? open;
    final bool? visible;
    final String? imageUrl;
    final Address? address;
    final DateTime? createDate;
    final DateTime? updateDate;

    Data({
        this.id,
        this.uuid,
        this.name,
        this.description,
        this.promptPayPhone,
        this.open,
        this.visible,
        this.imageUrl,
        this.address,
        this.createDate,
        this.updateDate,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        uuid: json["uuid"],
        name: json["name"],
        description: json["description"],
        promptPayPhone: json["promptPayPhone"],
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
        "promptPayPhone": promptPayPhone,
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
    final int? districtId;
    final String? amphure;
    final String? province;
    final String? zipcode;

    Address({
        this.address,
        this.street,
        this.building,
        this.district,
        this.districtId,
        this.amphure,
        this.province,
        this.zipcode,
    });

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        address: json["address"],
        street: json["street"],
        building: json["building"],
        district: json["district"],
        districtId: json["district_id"],
        amphure: json["amphure"],
        province: json["province"],
        zipcode: json["zipcode"],
    );

    Map<String, dynamic> toJson() => {
        "address": address,
        "street": street,
        "building": building,
        "district": district,
        "district_id": districtId,
        "amphure": amphure,
        "province": province,
        "zipcode": zipcode,
    };
}
