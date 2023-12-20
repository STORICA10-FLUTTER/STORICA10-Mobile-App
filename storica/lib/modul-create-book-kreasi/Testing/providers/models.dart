import 'package:flutter/cupertino.dart';

class BukuProvider extends ChangeNotifier {
  String judul = "";
  int jumlahHalaman = 0;
  String bahasa = "";
  String penerbit = "";
  String waktuTerbit = "";
  String image = "";

  void show() {
    print("Judul : " + judul);
  }

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    super.notifyListeners();
  }
}
