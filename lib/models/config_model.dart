// To parse this JSON data, do
// final configModel = configModelFromMap(jsonString);

import 'dart:convert';

class ConfigModel {
  ConfigModel({
    required this.description,
    required this.number,
    required this.logoImage,
    required this.eMail,
  });

  String description;
  String logoImage;
  String number;
  String eMail;

  factory ConfigModel.fromJson(String str) => ConfigModel.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());

  factory ConfigModel.fromMap(Map<String, dynamic> json) => ConfigModel(
        description: json["description"],
        number: json["number"],
        logoImage: json["logoImage"],
        eMail: json["eMail"]
      );

  Map<String, dynamic> toMap() => {
        "description": description,
        "number": number,
        "logoImage": logoImage,
        "eMail": eMail,
      };

  ConfigModel copy() => ConfigModel(description: description, number: number, logoImage: logoImage, eMail: eMail);

  @override
  String toString() {
    return 'whatsappNumber222: $number, aboutDescription: $description, logoImage: $logoImage, email: $eMail';
  }
}
