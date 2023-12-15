// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
    final int? statusCode;
    final String? status;
    final String? msg;
    final List<Datum>? data;

    ChatModel({
        this.statusCode,
        this.status,
        this.msg,
        this.data,
    });

    factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
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
    final String? status;
    final String? note;
    final int? chatId;
    final String? chatToken;
    final DateTime? createDate;
    final DateTime? lastTalkDate;
    final Customer? customer;

    Datum({
        this.orderId,
        this.orderToken,
        this.status,
        this.note,
        this.chatId,
        this.chatToken,
        this.createDate,
        this.lastTalkDate,
        this.customer,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        orderId: json["orderId"],
        orderToken: json["orderToken"],
        status: json["status"],
        note: json["note"],
        chatId: json["chatId"],
        chatToken: json["chatToken"],
        createDate: json["createDate"] == null ? null : DateTime.parse(json["createDate"]),
        lastTalkDate: json["lastTalkDate"] == null ? null : DateTime.parse(json["lastTalkDate"]),
        customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    );

    Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "orderToken": orderToken,
        "status": status,
        "note": note,
        "chatId": chatId,
        "chatToken": chatToken,
        "createDate": createDate?.toIso8601String(),
        "lastTalkDate": lastTalkDate?.toIso8601String(),
        "customer": customer?.toJson(),
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
