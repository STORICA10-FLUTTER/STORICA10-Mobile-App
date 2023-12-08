// To parse this JSON data, do
//
//     final buku = bukuFromJson(jsonString);

import 'dart:convert';

List<Buku> bukuFromJson(String str) =>
    List<Buku>.from(json.decode(str).map((x) => Buku.fromJson(x)));

String bukuToJson(List<Buku> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Buku {
  Model model;
  int pk;
  Fields fields;

  Buku({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Buku.fromJson(Map<String, dynamic> json) => Buku(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  String judul;
  int jumlahHalaman;
  Bahasa bahasa;
  String penulis;
  String penerbit;
  int jumlahReview;
  String rating;
  String gambar;
  DateTime tanggalTerbit;
  List<int> bukuFavorites;
  String isiBuku;

  Fields({
    required this.judul,
    required this.jumlahHalaman,
    required this.bahasa,
    required this.penulis,
    required this.penerbit,
    required this.jumlahReview,
    required this.rating,
    required this.gambar,
    required this.tanggalTerbit,
    required this.bukuFavorites,
    required this.isiBuku,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        judul: json["judul"],
        jumlahHalaman: json["jumlah_halaman"],
        bahasa: bahasaValues.map[json["bahasa"]]!,
        penulis: json["penulis"],
        penerbit: json["penerbit"],
        jumlahReview: json["jumlah_review"],
        rating: json["rating"],
        gambar: json["gambar"],
        tanggalTerbit: DateTime.parse(json["tanggal_terbit"]),
        bukuFavorites: List<int>.from(json["buku_favorites"].map((x) => x)),
        isiBuku: json["isi_buku"],
      );

  Map<String, dynamic> toJson() => {
        "judul": judul,
        "jumlah_halaman": jumlahHalaman,
        "bahasa": bahasaValues.reverse[bahasa],
        "penulis": penulis,
        "penerbit": penerbit,
        "jumlah_review": jumlahReview,
        "rating": rating,
        "gambar": gambar,
        "tanggal_terbit":
            "${tanggalTerbit.year.toString().padLeft(4, '0')}-${tanggalTerbit.month.toString().padLeft(2, '0')}-${tanggalTerbit.day.toString().padLeft(2, '0')}",
        "buku_favorites": List<dynamic>.from(bukuFavorites.map((x) => x)),
        "isi_buku": isiBuku,
      };
}

enum Bahasa { ENG, EN_US }

final bahasaValues = EnumValues({"eng": Bahasa.ENG, "en-US": Bahasa.EN_US});

enum Model { MAIN_BUKU }

final modelValues = EnumValues({"main.buku": Model.MAIN_BUKU});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
