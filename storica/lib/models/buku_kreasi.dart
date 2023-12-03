// To parse this JSON data, do
//
//     final bukuKreasi = bukuKreasiFromJson(jsonString);

import 'dart:convert';

List<BukuKreasi> bukuKreasiFromJson(String str) =>
    List<BukuKreasi>.from(json.decode(str).map((x) => BukuKreasi.fromJson(x)));

String bukuKreasiToJson(List<BukuKreasi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BukuKreasi {
  String model;
  int pk;
  Fields fields;

  BukuKreasi({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory BukuKreasi.fromJson(Map<String, dynamic> json) => BukuKreasi(
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
  String judul;
  int jumlahHalaman;
  String bahasa;
  String penulis;
  String penerbit;
  int jumlahReview;
  String rating;
  String gambar;
  DateTime tanggalTerbit;
  bool isPublished;
  String isiBuku;

  Fields({
    required this.user,
    required this.judul,
    required this.jumlahHalaman,
    required this.bahasa,
    required this.penulis,
    required this.penerbit,
    required this.jumlahReview,
    required this.rating,
    required this.gambar,
    required this.tanggalTerbit,
    required this.isPublished,
    required this.isiBuku,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        judul: json["judul"],
        jumlahHalaman: json["jumlah_halaman"],
        bahasa: json["bahasa"],
        penulis: json["penulis"],
        penerbit: json["penerbit"],
        jumlahReview: json["jumlah_review"],
        rating: json["rating"],
        gambar: json["gambar"],
        tanggalTerbit: DateTime.parse(json["tanggal_terbit"]),
        isPublished: json["is_published"],
        isiBuku: json["isi_buku"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "judul": judul,
        "jumlah_halaman": jumlahHalaman,
        "bahasa": bahasa,
        "penulis": penulis,
        "penerbit": penerbit,
        "jumlah_review": jumlahReview,
        "rating": rating,
        "gambar": gambar,
        "tanggal_terbit":
            "${tanggalTerbit.year.toString().padLeft(4, '0')}-${tanggalTerbit.month.toString().padLeft(2, '0')}-${tanggalTerbit.day.toString().padLeft(2, '0')}",
        "is_published": isPublished,
        "isi_buku": isiBuku,
      };
}
