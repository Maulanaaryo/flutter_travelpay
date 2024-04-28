import 'dart:convert';

class BannerResponseModel {
  final String img;
  final String caption;
  final DateTime createdAt;

  BannerResponseModel({
    required this.img,
    required this.caption,
    required this.createdAt,
  });

  factory BannerResponseModel.fromJson(String str) {
    final Map<String, dynamic> jsonMap = json.decode(str);
    return BannerResponseModel.fromMap(jsonMap);
  }

  String toJson() => json.encode(toMap());

  factory BannerResponseModel.fromMap(Map<String, dynamic> json) =>
      BannerResponseModel(
        img: json["img"],
        caption: json["caption"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toMap() => {
        "img": img,
        "caption": caption,
        "createdAt": createdAt.toIso8601String(),
      };
}
