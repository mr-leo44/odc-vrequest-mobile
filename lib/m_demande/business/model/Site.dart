// To parse this JSON data, do
//
//     final site = siteFromJson(jsonString);

import 'dart:convert';

Site siteFromJson(String str) => Site.fromJson(json.decode(str));

class Site {
  int id;
  String nom;
  double longitude;
  double latitude;

  Site({
    this.id = 0,
    this.nom = "",
    this.longitude = 0.0,
    this.latitude = 0.0,
  });

  factory Site.fromJson(Map<String, dynamic> json) => Site(
    id: json["id"] ?? 0,
    nom: json["nom"] ?? "",
    longitude: json["longitude"] != null ? json["longitude"].toDouble() : 0.0,
    latitude: json["latitude"] != null ? json["latitude"].toDouble() : 0.0,
  );
}