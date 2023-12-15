// To parse this JSON data, do
//
//     final inOrderModel = inOrderModelFromJson(jsonString);

import 'dart:convert';

InOrderModel inOrderModelFromJson(String str) => InOrderModel.fromJson(json.decode(str));

String inOrderModelToJson(InOrderModel data) => json.encode(data.toJson());

class InOrderModel {
    final int? statusCode;
    final String? status;
    final String? msg;
    final Data? data;

    InOrderModel({
        this.statusCode,
        this.status,
        this.msg,
        this.data,
    });

    factory InOrderModel.fromJson(Map<String, dynamic> json) => InOrderModel(
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
    final Chat? chat;
    final ChatProfile? chatProfile;
    final Items? items;

    Data({
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
        this.chat,
        this.chatProfile,
        this.items,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        chat: json["chat"] == null ? null : Chat.fromJson(json["chat"]),
        chatProfile: json["chatProfile"] == null ? null : ChatProfile.fromJson(json["chatProfile"]),
        items: json["items"] == null ? null : Items.fromJson(json["items"]),
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
        "chat": chat?.toJson(),
        "chatProfile": chatProfile?.toJson(),
        "items": items?.toJson(),
    };
}

class Chat {
    final int? chatId;
    final String? chatToken;
    final bool? open;
    final DateTime? createDate;
    final DateTime? lastTalkDate;

    Chat({
        this.chatId,
        this.chatToken,
        this.open,
        this.createDate,
        this.lastTalkDate,
    });

    factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        chatId: json["chatId"],
        chatToken: json["chatToken"],
        open: json["open"],
        createDate: json["createDate"] == null ? null : DateTime.parse(json["createDate"]),
        lastTalkDate: json["lastTalkDate"] == null ? null : DateTime.parse(json["lastTalkDate"]),
    );

    Map<String, dynamic> toJson() => {
        "chatId": chatId,
        "chatToken": chatToken,
        "open": open,
        "createDate": createDate?.toIso8601String(),
        "lastTalkDate": lastTalkDate?.toIso8601String(),
    };
}

class ChatProfile {
    final int? memberId;
    final String? memberUuid;

    ChatProfile({
        this.memberId,
        this.memberUuid,
    });

    factory ChatProfile.fromJson(Map<String, dynamic> json) => ChatProfile(
        memberId: json["memberId"],
        memberUuid: json["memberUUID"],
    );

    Map<String, dynamic> toJson() => {
        "memberId": memberId,
        "memberUUID": memberUuid,
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

class Items {
    final int? totalPrice;
    final int? amount;
    final List<Cart>? cart;

    Items({
        this.totalPrice,
        this.amount,
        this.cart,
    });

    factory Items.fromJson(Map<String, dynamic> json) => Items(
        totalPrice: json["totalPrice"],
        amount: json["amount"],
        cart: json["cart"] == null ? [] : List<Cart>.from(json["cart"]!.map((x) => Cart.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalPrice": totalPrice,
        "amount": amount,
        "cart": cart == null ? [] : List<dynamic>.from(cart!.map((x) => x.toJson())),
    };
}

class Cart {
    final int? cartId;
    final String? cartToken;
    final int? amount;
    final int? totalPrice;
    final String? status;
    final DateTime? createDate;
    final DateTime? updateDate;
    final Product? product;
    final String? note;

    Cart({
        this.cartId,
        this.cartToken,
        this.amount,
        this.totalPrice,
        this.status,
        this.createDate,
        this.updateDate,
        this.product,
        this.note,
    });

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        cartId: json["cartId"],
        cartToken: json["cartToken"],
        amount: json["amount"],
        totalPrice: json["totalPrice"],
        status: json["status"],
        createDate: json["createDate"] == null ? null : DateTime.parse(json["createDate"]),
        updateDate: json["updateDate"] == null ? null : DateTime.parse(json["updateDate"]),
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        note: json["note"],
    );

    Map<String, dynamic> toJson() => {
        "cartId": cartId,
        "cartToken": cartToken,
        "amount": amount,
        "totalPrice": totalPrice,
        "status": status,
        "createDate": createDate?.toIso8601String(),
        "updateDate": updateDate?.toIso8601String(),
        "product": product?.toJson(),
        "note": note,
    };
}

class Product {
    final int? productId;
    final String? productToken;
    final String? name;
    final String? imageUrl;
    final String? description;
    final int? price;
    final bool? available;
    final bool? visible;

    Product({
        this.productId,
        this.productToken,
        this.name,
        this.imageUrl,
        this.description,
        this.price,
        this.available,
        this.visible,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["productId"],
        productToken: json["productToken"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        description: json["description"],
        price: json["price"],
        available: json["available"],
        visible: json["visible"],
    );

    Map<String, dynamic> toJson() => {
        "productId": productId,
        "productToken": productToken,
        "name": name,
        "imageUrl": imageUrl,
        "description": description,
        "price": price,
        "available": available,
        "visible": visible,
    };
}
