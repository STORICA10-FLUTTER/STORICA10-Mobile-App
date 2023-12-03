// To parse this JSON data, do
//
//     final quotes = quotesFromJson(jsonString);

import 'dart:convert';

List<Quotes> quotesFromJson(String str) =>
    List<Quotes>.from(json.decode(str).map((x) => Quotes.fromJson(x)));

String quotesToJson(List<Quotes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Quotes {
  String model;
  int pk;
  Fields fields;

  Quotes({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Quotes.fromJson(Map<String, dynamic> json) => Quotes(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  int user;
  String kataKata;

  Fields({
    required this.user,
    required this.kataKata,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        kataKata: json["kata_kata"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "kata_kata": kataKata,
      };
}
