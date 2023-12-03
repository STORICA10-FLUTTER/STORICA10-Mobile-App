// To parse this JSON data, do
//
//     final level = levelFromJson(jsonString);

import 'dart:convert';

List<Level> levelFromJson(String str) =>
    List<Level>.from(json.decode(str).map((x) => Level.fromJson(x)));

String levelToJson(List<Level> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Level {
  String model;
  int pk;
  Fields fields;

  Level({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Level.fromJson(Map<String, dynamic> json) => Level(
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
  int level;
  int bukuTotal;
  int batasAtas;
  int persen;

  Fields({
    required this.user,
    required this.level,
    required this.bukuTotal,
    required this.batasAtas,
    required this.persen,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        level: json["level"],
        bukuTotal: json["buku_total"],
        batasAtas: json["batas_atas"],
        persen: json["persen"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "level": level,
        "buku_total": bukuTotal,
        "batas_atas": batasAtas,
        "persen": persen,
      };
}
