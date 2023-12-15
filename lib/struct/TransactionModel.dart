// To parse this JSON data, do
//
//     final transactionModel = transactionModelFromJson(jsonString);

import 'dart:convert';

TransactionModel transactionModelFromJson(String str) => TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) => json.encode(data.toJson());

class TransactionModel {
    final int? statusCode;
    final String? status;
    final String? msg;
    final List<Datum>? data;

    TransactionModel({
        this.statusCode,
        this.status,
        this.msg,
        this.data,
    });

    factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
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
    final int? orderId;
    final String? orderToken;
    final String? paymentMethod;
    final int? totalPay;
    final String? status;
    final String? note;
    final int? chatId;
    final DateTime? createDate;
    final DateTime? updateDate;
    final Customer? customer;
    final Destination? destination;

    Datum({
        this.orderId,
        this.orderToken,
        this.paymentMethod,
        this.totalPay,
        this.status,
        this.note,
        this.chatId,
        this.createDate,
        this.updateDate,
        this.customer,
        this.destination,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        orderId: json["orderId"],
        orderToken: json["orderToken"],
        paymentMethod: json["paymentMethod"],
        totalPay: json["totalPay"],
        status: json["status"],
        note: json["note"],
        chatId: json["chatId"],
        createDate: json["createDate"] == null ? null : DateTime.parse(json["createDate"]),
        updateDate: json["updateDate"] == null ? null : DateTime.parse(json["updateDate"]),
        customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
        destination: json["destination"] == null ? null : Destination.fromJson(json["destination"]),
    );

    Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "orderToken": orderToken,
        "paymentMethod": paymentMethod,
        "totalPay": totalPay,
        "status": status,
        "note": note,
        "chatId": chatId,
        "createDate": createDate?.toIso8601String(),
        "updateDate": updateDate?.toIso8601String(),
        "customer": customer?.toJson(),
        "destination": destination?.toJson(),
    };
}

class Customer {
    final int? accountId;
    final String? accountUuid;
    final String? username;
    final String? profileImageUrl;

    Customer({
        this.accountId,
        this.accountUuid,
        this.username,
        this.profileImageUrl,
    });

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        accountId: json["accountId"],
        accountUuid: json["accountUUID"],
        username: json["username"],
        profileImageUrl: json["profileImageURL"],
    );

    Map<String, dynamic> toJson() => {
        "accountId": accountId,
        "accountUUID": accountUuid,
        "username": username,
        "profileImageURL": profileImageUrl,
    };
}

class Destination {
    final int? destinationId;
    final String? destinationToken;
    final String? name;
    final String? phoneNumber;
    final String? address;
    final String? street;
    final String? building;
    final String? note;
    final String? district;
    final String? amphure;
    final String? province;
    final String? zipcode;

    Destination({
        this.destinationId,
        this.destinationToken,
        this.name,
        this.phoneNumber,
        this.address,
        this.street,
        this.building,
        this.note,
        this.district,
        this.amphure,
        this.province,
        this.zipcode,
    });

    factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        destinationId: json["destinationId"],
        destinationToken: json["destinationToken"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        street: json["street"],
        building: json["building"],
        note: json["note"],
        district: json["district"],
        amphure: json["amphure"],
        province: json["province"],
        zipcode: json["zipcode"],
    );

    Map<String, dynamic> toJson() => {
        "destinationId": destinationId,
        "destinationToken": destinationToken,
        "name": name,
        "phoneNumber": phoneNumber,
        "address": address,
        "street": street,
        "building": building,
        "note": note,
        "district": district,
        "amphure": amphure,
        "province": province,
        "zipcode": zipcode,
    };
}
