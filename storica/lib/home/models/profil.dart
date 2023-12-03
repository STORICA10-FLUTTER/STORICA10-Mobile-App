// To parse this JSON data, do
//
//     final Profile = ProfileFromJson(jsonString);

import 'dart:convert';

List<Profile> ProfileFromJson(String str) =>
    List<Profile>.from(json.decode(str).map((x) => Profile.fromJson(x)));

String ProfileToJson(List<Profile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Profile {
  String model;
  int pk;
  Fields fields;

  Profile({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
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
  String gambar;

  Fields({
    required this.user,
    required this.gambar,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        gambar: json["gambar"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "gambar": gambar,
      };
}
