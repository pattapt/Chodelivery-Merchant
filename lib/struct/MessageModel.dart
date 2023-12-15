// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

MessageModel messageModelFromJson(String str) => MessageModel.fromJson(json.decode(str));
Datum messageDetaillFromJson(String str) => Datum.fromJson(json.decode(str));
String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
    final int? statusCode;
    final String? status;
    final String? msg;
    final List<Datum>? data;

    MessageModel({
        this.statusCode,
        this.status,
        this.msg,
        this.data,
    });

    factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
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
    final int? messageId;
    final String? type;
    final DateTime? createAt;
    final Source? source;
    final Message? message;

    Datum({
        this.messageId,
        this.type,
        this.createAt,
        this.source,
        this.message,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        messageId: json["messageId"],
        type: json["type"],
        createAt: json["createAt"] == null ? null : DateTime.parse(json["createAt"]),
        source: json["source"] == null ? null : Source.fromJson(json["source"]),
        message: json["message"] == null ? null : Message.fromJson(json["message"]),
    );

    Map<String, dynamic> toJson() => {
        "messageId": messageId,
        "type": type,
        "createAt": createAt?.toIso8601String(),
        "source": source?.toJson(),
        "message": message?.toJson(),
    };
}

class Message {
    final String? messageToken;
    final String? messageType;
    final String? message;

    Message({
        this.messageToken,
        this.messageType,
        this.message,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        messageToken: json["messageToken"],
        messageType: json["messageType"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "messageToken": messageToken,
        "messageType": messageType,
        "message": message,
    };
}

class Source {
    final int? chatMemberId;
    final String? memberUuid;
    final String? accountUuid;
    final int? accountId;
    final String? chatToken;
    final String? accountName;
    final String? accountType;

    Source({
        this.chatMemberId,
        this.memberUuid,
        this.accountUuid,
        this.accountId,
        this.chatToken,
        this.accountName,
        this.accountType,
    });

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        chatMemberId: json["chatMemberId"],
        memberUuid: json["memberUUID"],
        accountUuid: json["accountUUID"],
        accountId: json["accountId"],
        chatToken: json["chatToken"],
        accountName: json["accountName"],
        accountType: json["accountType"],
    );

    Map<String, dynamic> toJson() => {
        "chatMemberId": chatMemberId,
        "memberUUID": memberUuid,
        "accountUUID": accountUuid,
        "accountId": accountId,
        "chatToken": chatToken,
        "accountName": accountName,
        "accountType": accountType,
    };
}
