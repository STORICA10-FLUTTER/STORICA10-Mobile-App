// To parse this JSON data, do
//
//     final komentarBiasa = komentarBiasaFromJson(jsonString);

import 'dart:convert';

List<Komentar> komentarBiasaFromJson(String str) => List<Komentar>.from(json.decode(str).map((x) => Komentar.fromJson(x)));

String komentarBiasaToJson(List<Komentar> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Komentar {
    String model;
    int pk;
    Fields fields;

    Komentar({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Komentar.fromJson(Map<String, dynamic> json) => Komentar(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

  get rating => null;

  String get isiKomentar => isiKomentar;

  DateTime get tglKomentar => tglKomentar;

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String nama;
    String rating;
    DateTime tglKomentar;
    String isiKomentar;
    int dariBuku;

    Fields({
        required this.nama,
        required this.rating,
        required this.tglKomentar,
        required this.isiKomentar,
        required this.dariBuku,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        nama: json["nama"],
        rating: json["rating"],
        tglKomentar: DateTime.parse(json["tgl_komentar"]),
        isiKomentar: json["isi_komentar"],
        dariBuku: json["dari_buku"],
    );

    Map<String, dynamic> toJson() => {
        "nama": nama,
        "rating": rating,
        "tgl_komentar": tglKomentar.toIso8601String(),
        "isi_komentar": isiKomentar,
        "dari_buku": dariBuku,
    };
}
