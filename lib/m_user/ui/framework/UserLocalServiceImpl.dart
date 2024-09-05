import 'package:flutter/material.dart';
import 'package:odc_mobile_project/m_user/business/model/OnboardingPageModel.dart';
import 'package:odc_mobile_project/m_user/business/model/User.dart';
import 'package:odc_mobile_project/utils/colors.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../business/service/userLocalService.dart';

class UserLocalServiceImpl implements UserLocalService {
  Database db;
  String userKey = 'UserKey';
  String tokenKey = 'TOKENKey';
  var stockage = StoreRef.main();
  UserLocalServiceImpl(this.db);

  @override
  Future<String> getToken() async {
    var data = await stockage.record(tokenKey).get(db) as String?;
    print("data token: $data");
    return Future.value(data);
  }

  @override
  Future<bool> saveToken(String data) async {
    await stockage.record(tokenKey).put(db, data);
    return true;
  }

  @override
  Future<bool> disconnect() async {
    await stockage.record(userKey).delete(db);
    await stockage.record(tokenKey).delete(db);
    return true;
  }

  @override
  Future<User?> getUser() async {
    var data = await stockage.record(userKey).get(db) as Map?;
    print("data local uer $data");
    return Future.value(User.fromJson(data ?? {"id": 0}));
  }

  @override
  Future<bool> saveUser(User data) async {
    print("User ${data.toJson()}");
    await stockage.record(userKey).put(db, data.toJson());

    return true;
  }

  @override
  List<OnboardingPageModel> getListOnboard() {
    List<OnboardingPageModel> onboards = [
      OnboardingPageModel(
        title: 'Vrequest',
        description:
            'Gestion optimale de la demande de charroi et une meilleure accessibilité des véhicules aux personnes sollicitant le service.',
        image: 'assets/logo.png',
        bgColor: Colors.blueGrey,
        textColor: Colors.white,
      ),
      OnboardingPageModel(
        title: 'Courses',
        description:
            'Permet d\'assigner des véhicules de service aux personnes sollicitant un déplacement dans le cadre d'
            'une activité professionnelle.',
        image: 'images/intro.png',
        bgColor: Colors.teal,
        textColor: Colors.white,
      ),
      OnboardingPageModel(
        title: 'Geolocalisation',
        description:
            'Permet de suivre la position des véhicules en temps réel.',
        image: 'images/car.png',
        bgColor: Colors.blueGrey,
        textColor: Colors.white,
      ),
      OnboardingPageModel(
        title: 'Messagerie Instantanée',
        description:
            'Permet d\'entamer une messagerie instantanée avec le chauffeur assigné a votre course.',
        image: 'assets/images/chat.avif',
        bgColor: Colors.teal,
        textColor: Colors.white,
      ),
    ];

    return onboards;
  }

  @override
  Future<bool?> getStatusOnboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool('onboarding');
  }

  @override
  Future terminateOnboard() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('onboarding', true);
  }
}

void main() {}
