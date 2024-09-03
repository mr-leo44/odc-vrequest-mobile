// To parse this JSON data, do
//
//     final course = courseFromJson(jsonString);

import 'dart:convert';

import 'package:odc_mobile_project/m_course/business/Vehicule.dart';
import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'package:odc_mobile_project/m_user/business/model/User.dart';

// Course courseFromJson(String str) => Course.fromJson(json.decode(str));

// String courseToJson(Course data) => json.encode(data.toJson());

class Course {
    int id;
    Vehicule vehicule;
    User chauffeur;
    Demande demande;
    String status;
    String commentaire;
    String? startedAt;
    String? endedAt;
    String date;
    String createdAt;
    String updatedAt;

    Course({
        this.id = 0,
        required this.vehicule,
        required this.chauffeur,
        required this.demande,
        this.status = "",
        this.commentaire = "",
        this.startedAt = null,
        this.endedAt = null,
        this.date = "",
        this.createdAt = "",
        this.updatedAt = "",
    });

    Course copyWith({
        int? id,
        Vehicule? vehicule,
        User? chauffeur,
        Demande? demande,
        String? status,
        String? commentaire,
        String? startedAt,
        String? endedAt,
        String? date,
        String? createdAt,
        String? updatedAt,
    }) => 
        Course(
            id: id ?? this.id,
            vehicule: vehicule ?? this.vehicule,
            chauffeur: chauffeur ?? this.chauffeur,
            demande: demande ?? this.demande,
            status: status ?? this.status,
            commentaire: commentaire ?? this.commentaire,
            startedAt: startedAt ?? this.startedAt,
            endedAt: endedAt ?? this.endedAt,
            date: date ?? this.date,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Course.fromJson(Map json) => Course(
        id: json["id"] ?? 0,
        vehicule: (json["vehicule"] != null ) ? Vehicule.fromJson(json["vehicule"]) : Vehicule.fromJson({}),
        chauffeur: (json["chauffeur"] != null) ? User.fromJson(json["chauffeur"]) : User.fromJson({}),
        demande: (json["demande"] != null) ? Demande.fromJson(json["demande"]) : Demande.fromJson({}) ,
        status: json["status"] ?? "",
        commentaire: json["commentaire"] ?? "",
        startedAt: json["started_at"] ?? null ,
        endedAt: json["ended_at"] ?? null ,
        date: json["date"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
    );

    Map toJson() => {
        "id": id,
        "vehicule": vehicule.toJson(),
        "chauffeur": chauffeur.toJson(),
        "demande": demande.toJson(),
        "status": status,
        "commentaire": commentaire,
        "started_at": startedAt,
        "ended_at": endedAt,
        "date": date,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
