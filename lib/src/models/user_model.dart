// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:second_brain/src/utils/app_exports.dart';


UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int startupId;
  String name;
  int mobile;
  String email;
  DateTime createdAt;
  DateTime updatedAt;
  String token;
  Startup startup;

  UserModel({
    this.startupId = 0,
    this.name = "",
    this.mobile = 0,
    this.email = "",
    required this.createdAt,
    required this.updatedAt,
    this.token = '',
    required this.startup,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      startupId: json["startup_id"] ?? 0,
      name: json["name"] ?? "",
      mobile: json["mobile"] ?? 0,
      email: json["email"] ?? "",
      createdAt:
          DateTime.tryParse(json["created_at"].toString()) ?? DateTime(0),
      updatedAt:
          DateTime.tryParse(json["updated_at"].toString()) ?? DateTime(0),
      token: json["token"] ?? "",
      startup: Startup.fromJson(json["startup"] ?? {}));

  Map<String, dynamic> toJson() => {
        "startup_id": startupId,
        "name": name,
        "mobile": mobile,
        "email": email,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "token": token,
        "startup": startup.toJson(),
      };
}

class Startup {
  String brandName;
  String legalName;
  String shortDescription;
  int city;
  int state;
  int country;
  String address;
  int pincode;
  int cin;
  DateTime dateOfIncorporation;
  int status;
  String pitchDeckPath;
  String logoPath;

  Startup({
    this.brandName = "",
    this.legalName = "",
    this.shortDescription = "",
    this.city = 0,
    this.state = 0,
    this.country = 0,
    this.address = "",
    this.pincode = 0,
    this.cin = 0,
    required this.dateOfIncorporation,
    this.status = 0,
    this.pitchDeckPath = "",
    this.logoPath = "",
  });

  String get logoFile => AppUrl.imageURL + logoPath;

  String get pitchDeckFile => AppUrl.imageURL + pitchDeckPath;

  factory Startup.fromJson(Map<String, dynamic> json) => Startup(
        brandName: json["brand_name"] ?? "",
        legalName: json["legal_name"] ?? "",
        shortDescription: json["short_description"] ?? "",
        city: json["city"] ?? 0,
        state: json["state"] ?? 0,
        country: json["country"] ?? 0,
        address: json["address"] ?? "",
        pincode: json["pincode"] ?? 0,
        cin: json["cin"] ?? 0,
        dateOfIncorporation:
            DateTime.tryParse(json["date_of_incorporation"].toString()) ??
                DateTime(0),
        status: json["status"] ?? 0,
        pitchDeckPath: json["pitch_deck_path"] ?? "",
        logoPath: json["logo_path"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "brand_name": brandName,
        "legal_name": legalName,
        "short_description": shortDescription,
        "city": city,
        "state": state,
        "country": country,
        "address": address,
        "pincode": pincode,
        "cin": cin,
        "date_of_incorporation": dateOfIncorporation.serverDate,
        "status": status,
        "pitch_deck_path": pitchDeckPath,
        "logo_path": logoPath,
      };
}
