// To parse this JSON data, do
//
//     final sumModel = sumModelFromJson(jsonString);

import 'dart:convert';

SumModel sumModelFromJson(String str) => SumModel.fromJson(json.decode(str));

String sumModelToJson(SumModel data) => json.encode(data.toJson());

class SumModel {
    final int? statusCode;
    final String? status;
    final String? msg;
    final Data? data;

    SumModel({
        this.statusCode,
        this.status,
        this.msg,
        this.data,
    });

    factory SumModel.fromJson(Map<String, dynamic> json) => SumModel(
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
    final int? totalOrder;
    final int? totalAmount;
    final int? lastWeekOrder;
    final int? lastWeekSales;

    Data({
        this.totalOrder,
        this.totalAmount,
        this.lastWeekOrder,
        this.lastWeekSales,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalOrder: json["totalOrder"],
        totalAmount: json["totalAmount"],
        lastWeekOrder: json["lastWeekOrder"],
        lastWeekSales: json["lastWeekSales"],
    );

    Map<String, dynamic> toJson() => {
        "totalOrder": totalOrder,
        "totalAmount": totalAmount,
        "lastWeekOrder": lastWeekOrder,
        "lastWeekSales": lastWeekSales,
    };
}
