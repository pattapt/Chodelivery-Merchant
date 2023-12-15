// To parse this JSON data, do
//
//     final listItemModel = listItemModelFromJson(jsonString);

import 'dart:convert';

ListItemModel listItemModelFromJson(String str) => ListItemModel.fromJson(json.decode(str));

String listItemModelToJson(ListItemModel data) => json.encode(data.toJson());

class ListItemModel {
    final int? statusCode;
    final String? status;
    final String? msg;
    final List<Datum>? data;

    ListItemModel({
        this.statusCode,
        this.status,
        this.msg,
        this.data,
    });

    factory ListItemModel.fromJson(Map<String, dynamic> json) => ListItemModel(
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
    final int? productId;
    final String? productToken;
    final String? barcode;
    final int? categoryId;
    final String? name;
    final String? description;
    final String? imageUrl;
    final int? price;
    final double? cost;
    final int? quantity;
    final Status? status;
    final bool? visible;
    final DateTime? createDate;
    final DateTime? updateDate;

    Datum({
        this.productId,
        this.productToken,
        this.barcode,
        this.categoryId,
        this.name,
        this.description,
        this.imageUrl,
        this.price,
        this.cost,
        this.quantity,
        this.status,
        this.visible,
        this.createDate,
        this.updateDate,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        productId: json["productId"],
        productToken: json["productToken"],
        barcode: json["barcode"],
        categoryId: json["categoryId"],
        name: json["name"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        price: json["price"],
        cost: json["cost"]?.toDouble(),
        quantity: json["quantity"],
        status: statusValues.map[json["status"]]!,
        visible: json["visible"],
        createDate: json["createDate"] == null ? null : DateTime.parse(json["createDate"]),
        updateDate: json["updateDate"] == null ? null : DateTime.parse(json["updateDate"]),
    );

    Map<String, dynamic> toJson() => {
        "productId": productId,
        "productToken": productToken,
        "barcode": barcode,
        "categoryId": categoryId,
        "name": name,
        "description": description,
        "imageUrl": imageUrl,
        "price": price,
        "cost": cost,
        "quantity": quantity,
        "status": statusValues.reverse[status],
        "visible": visible,
        "createDate": createDate?.toIso8601String(),
        "updateDate": updateDate?.toIso8601String(),
    };
}

enum Status {
    AVAILABLE
}

final statusValues = EnumValues({
    "available": Status.AVAILABLE
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
