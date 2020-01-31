// To parse this JSON data, do
//
//     final infoModel = infoModelFromJson(jsonString);

import 'dart:convert';

import 'package:Npay/MODEL/base_model.dart';

InfoModel infoModelFromJson(String str) => InfoModel.fromJson(json.decode(str));

String infoModelToJson(InfoModel data) => json.encode(data.toJson());

class InfoModel extends BaseModel {
  Result result;
  String msg;
  String status;

  InfoModel({
    this.result,
    this.msg,
    this.status,
  });

  factory InfoModel.fromJson(Map<String, dynamic> json) => InfoModel(
    result: Result.fromJson(json["result"]),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "result": result.toJson(),
    "msg": msg,
    "status": status,
  };
}

class Result {
  String name;
  String kdReferral;
  String noHp;
  String picture;
  String qr;
  String saldo;
  String saldoRaw;
  String saldoMain;
  String saldoBonus;
  String versionCode;
  int notifikasi;
  List<Slider> slider;
  List<ProductType> productType;
  List<HotSale> hotSale;

  Result({
    this.name,
    this.kdReferral,
    this.noHp,
    this.picture,
    this.qr,
    this.saldo,
    this.saldoRaw,
    this.saldoMain,
    this.saldoBonus,
    this.versionCode,
    this.notifikasi,
    this.slider,
    this.productType,
    this.hotSale,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    name: json["name"],
    kdReferral: json["kd_referral"],
    noHp: json["no_hp"],
    picture: json["picture"],
    qr: json["qr"],
    saldo: json["saldo"],
    saldoRaw: json["saldo_raw"],
    saldoMain: json["saldo_main"],
    saldoBonus: json["saldo_bonus"],
    versionCode: json["version_code"],
    notifikasi: json["notifikasi"],
    slider: List<Slider>.from(json["slider"].map((x) => Slider.fromJson(x))),
    productType: List<ProductType>.from(json["productType"].map((x) => ProductType.fromJson(x))),
    hotSale: List<HotSale>.from(json["hotSale"].map((x) => HotSale.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "kd_referral": kdReferral,
    "no_hp": noHp,
    "picture": picture,
    "qr": qr,
    "saldo": saldo,
    "saldo_raw": saldoRaw,
    "saldo_main": saldoMain,
    "saldo_bonus": saldoBonus,
    "version_code": versionCode,
    "notifikasi": notifikasi,
    "slider": List<dynamic>.from(slider.map((x) => x.toJson())),
    "productType": List<dynamic>.from(productType.map((x) => x.toJson())),
    "hotSale": List<dynamic>.from(hotSale.map((x) => x.toJson())),
  };
}

class HotSale {
  String code;
  String provider;
  int priceBefore;
  int price;
  String note;
  int disc;

  HotSale({
    this.code,
    this.provider,
    this.priceBefore,
    this.price,
    this.note,
    this.disc,
  });

  factory HotSale.fromJson(Map<String, dynamic> json) => HotSale(
    code: json["code"],
    provider: json["provider"],
    priceBefore: json["price_before"],
    price: json["price"],
    note: json["note"],
    disc: json["disc"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "provider": provider,
    "price_before": priceBefore,
    "price": price,
    "note": note,
    "disc": disc,
  };
}

class ProductType {
  String title;
  String image;
  String type;

  ProductType({
    this.title,
    this.image,
    this.type,
  });

  factory ProductType.fromJson(Map<String, dynamic> json) => ProductType(
    title: json["title"],
    image: json["image"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "image": image,
    "type": type,
  };
}

class Slider {
  String image;
  String title;

  Slider({
    this.image,
    this.title,
  });

  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
    image: json["image"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "title": title,
  };
}
