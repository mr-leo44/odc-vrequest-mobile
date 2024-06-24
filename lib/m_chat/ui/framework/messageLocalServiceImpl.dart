import 'dart:async';
import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:odc_mobile_project/m_chat/business/model/messageDetails.dart';
import 'package:odc_mobile_project/m_chat/business/model/messageGroupe.dart';
import 'package:odc_mobile_project/m_chat/business/service/messageLocalService.dart';
import 'package:get_storage/get_storage.dart';

class MessageLocalServiceImpl implements MessageLocalService {
  GetStorage stockage;

  MessageLocalServiceImpl(this.stockage);



  @override
  Future<List<MessageGroupe>> lireLesMessageGroupesLocal() async {
    var key = "Groupes";
    var data = (stockage.read(key) as List?)??[];
    var objectData = data.map((e)=>MessageGroupe.fromJson(e)).toList();
    return Future.value(objectData);
  }

  @override
  Future<List<MessageDetails>> lireLesMessageDetailsLocal(int demandeId) async {
    var key = "MessageDetails_$demandeId";
    var localData = (stockage.read(key) as List?) ?? [];
    var objectData=localData.map((e)=> MessageDetails.fromJson(e)).toList();
    return Future.value(objectData);
  }

  @override
  Future<bool> sauvegarderLesMessageGroupesLocal(List<MessageGroupe> groupes) async {
    var key = "Groupes";
    var data = groupes.map((e) => e.toJson()).toList();
    await stockage.write(key, data);
    return true;
  }

  @override
  Future<bool> sauvegarderMessageDetailEntrantLocal(
      int demandeId, MessageDetails message) async {
    var key = "MessageDetails_$demandeId";
    print("la clé est $key");
    var localData = (stockage.read(key) as List?) ?? [];

    try {
      localData.add(message.toJson());
      await stockage.write(key, localData);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> sauvegarderTousLesMessageDetailsLocal(
      int demandeId, List<MessageDetails> message) async {
    var key = "MessageDetails_$demandeId";
    var data = message.map((e) => e.toJson()).toList();
    await stockage.write(key, data);
    return true;
  }
}