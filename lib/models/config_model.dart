// To parse this JSON data, do
// final configModel = configModelFromMap(jsonString);

import 'dart:convert';

ConfigModel configModelFromMap(String str) => ConfigModel.fromMap(json.decode(str));
String configModelToMap(ConfigModel data) => json.encode(data.toMap());

class ConfigModel {
    ConfigModel({
        required this.number,
        required this.description,
    });

    String number;
    String description;

    factory ConfigModel.fromMap(Map<String, dynamic> json) => ConfigModel(
        number: json["number"],
        description: json["description"],
    );

    Map<String, dynamic> toMap() => {
        "number": number,
        "description": description,
    };

    @override
    String toString() {
      return 'whatsappNumber: $number, aboutDescription: $description';
    }
}
