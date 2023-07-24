import 'dart:convert';

List<Detek> detekFromJson(String str) =>
    List<Detek>.from(json.decode(str).map((x) => Detek.fromJson(x)));

String arusToJson(List<Detek> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Detek {
  Detek({
    required this.Waktu,
    required this.Emosi,
    required this.Name_File,
    required this.id,
  });

  String Waktu;
  String Emosi;
  String Name_File;
  int id;

  factory Detek.fromJson(Map<String, dynamic> json) => Detek(
        Waktu: json["Waktu"],
        Emosi: json["Emosi"],
        Name_File: json["Name_File"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "Waktu": Waktu,
        "Emosi": Emosi,
        "Name_File": Name_File,
        "id": id,
      };

  @override
  String toString() {
    String result = Emosi;
    return result;
  }
}
