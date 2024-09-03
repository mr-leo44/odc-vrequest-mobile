// To parse this JSON data, do
//
//     final vehicule = vehiculeFromJson(jsonString);

import 'dart:convert';

Vehicule vehiculeFromJson(String str) => Vehicule.fromJson(json.decode(str));

String vehiculeToJson(Vehicule data) => json.encode(data.toJson());

class Vehicule {
    int id;
    String plaque;
    String marque;
    int capacite;
    int disponibilite;

    Vehicule({
        required this.id,
        this.plaque = "",
        this.marque = "",
        this.capacite = 0 ,
        this.disponibilite = 0,
    });

    Vehicule copyWith({
        int? id,
        String? plaque,
        String? marque,
        int? capacite,
        int? disponibilite,
    }) => 
        Vehicule(
            id: id ?? this.id,
            plaque: plaque ?? this.plaque,
            marque: marque ?? this.marque,
            capacite: capacite ?? this.capacite,
            disponibilite: disponibilite ?? this.disponibilite,
        );

    factory Vehicule.fromJson(Map json) => Vehicule(
        id: json["id"] ?? 0,
        plaque: json["plaque"] ?? "",
        marque: json["marque"] ?? "",
        capacite: json["capacite"] ?? 0,
        disponibilite: json["disponibilite"] ?? 0,
    );

    Map toJson() => {
        "id": id,
        "plaque": plaque,
        "marque": marque,
        "capacite": capacite,
        "disponibilite": disponibilite,
    };
}
