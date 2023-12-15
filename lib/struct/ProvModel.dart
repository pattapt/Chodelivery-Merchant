// To parse this JSON data, do
//
//     final provModel = provModelFromJson(jsonString);

import 'dart:convert';

ProvModel provModelFromJson(String str) => ProvModel.fromJson(json.decode(str));

String provModelToJson(ProvModel data) => json.encode(data.toJson());

class ProvModel {
    final int? statusCode;
    final String? status;
    final String? msg;
    final List<Datum>? data;

    ProvModel({
        this.statusCode,
        this.status,
        this.msg,
        this.data,
    });

    factory ProvModel.fromJson(Map<String, dynamic> json) => ProvModel(
        statusCode: json["status_code"],
        status: json["status"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    final District? district;
    final Amphure? amphure;
    final Province? province;
    final String? zipcode;

    Datum({
        this.district,
        this.amphure,
        this.province,
        this.zipcode,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        district: json["district"] == null ? null : District.fromJson(json["district"]),
        amphure: json["amphure"] == null ? null : Amphure.fromJson(json["amphure"]),
        province: json["province"] == null ? null : Province.fromJson(json["province"]),
        zipcode: json["zipcode"],
    );

    Map<String, dynamic> toJson() => {
        "district": district?.toJson(),
        "amphure": amphure?.toJson(),
        "province": province?.toJson(),
        "zipcode": zipcode,
    };
}

class Amphure {
    final int? amphureId;
    final String? nameTh;
    final String? nameEn;

    Amphure({
        this.amphureId,
        this.nameTh,
        this.nameEn,
    });

    factory Amphure.fromJson(Map<String, dynamic> json) => Amphure(
        amphureId: json["amphure_id"],
        nameTh: json["name_th"],
        nameEn: json["name_en"],
    );

    Map<String, dynamic> toJson() => {
        "amphure_id": amphureId,
        "name_th": nameTh,
        "name_en": nameEn,
    };
}

class District {
    final int? districtId;
    final String? nameTh;
    final String? nameEn;

    District({
        this.districtId,
        this.nameTh,
        this.nameEn,
    });

    factory District.fromJson(Map<String, dynamic> json) => District(
        districtId: json["district_id"],
        nameTh: json["name_th"],
        nameEn: json["name_en"],
    );

    Map<String, dynamic> toJson() => {
        "district_id": districtId,
        "name_th": nameTh,
        "name_en": nameEn,
    };
}

class Province {
    final int? provinceId;
    final String? nameTh;
    final String? nameEn;

    Province({
        this.provinceId,
        this.nameTh,
        this.nameEn,
    });

    factory Province.fromJson(Map<String, dynamic> json) => Province(
        provinceId: json["province_id"],
        nameTh: json["name_th"],
        nameEn: json["name_en"],
    );

    Map<String, dynamic> toJson() => {
        "province_id": provinceId,
        "name_th": nameTh,
        "name_en": nameEn,
    };
}
