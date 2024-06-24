import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:odc_mobile_project/m_chat/business/interactor/MessageGroupe/creerMessageUseCase.dart';
import 'package:odc_mobile_project/m_chat/business/interactor/MessageDetails/recupererListMessageDetailUseCase.dart';
import 'package:odc_mobile_project/m_chat/business/interactor/MessageGroupe/creerMessageUseCase.dart';
import 'package:odc_mobile_project/m_chat/business/interactor/MessageGroupe/recupererListMessageGroupeUseCase.dart';
import 'package:odc_mobile_project/m_chat/business/interactor/MessageDetails/supprimerMessageDetailUseCase.dart';
import 'package:odc_mobile_project/m_chat/business/interactor/MessageGroupe/lireLesGroupesUseCase.dart';
import 'package:odc_mobile_project/m_chat/business/interactor/MessageGroupe/lireLesMessagesUseCase.dart';
import 'package:odc_mobile_project/m_chat/business/interactor/MessageGroupe/recupererMessageGroupeUseCase.dart';
import 'package:odc_mobile_project/m_chat/business/interactor/MessageGroupe/sauvegarderLesGroupesUseCase.dart';
import 'package:odc_mobile_project/m_chat/business/interactor/MessageGroupe/sauvegarderMessageEntrantUseCase.dart';
import 'package:odc_mobile_project/m_chat/business/interactor/MessageGroupe/sauvegarderTousLesMessagesUseCase.dart';
import 'package:odc_mobile_project/m_chat/business/service/messageLocalService.dart';
import 'package:odc_mobile_project/m_chat/business/service/messageNetworkService.dart';
import 'package:odc_mobile_project/m_user/business/service/userLocalService.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chatInteractor.g.dart';

class ChatInteractor {
  CreerMessageUseCase creerMessageUseCase;
  RecupererListMessageDetailUseCase recupererListMessageDetailUseCase;
  RecupererListMessageGroupeUseCase recupererListMessageGroupeUseCase;
  RecupererMessageGroupeUseCase recupererMessageGroupeUseCase;
  SupprimerMessageDetailUseCase supprimerMessageDetailUseCase;

  LireLesMessageGroupesLocalUseCase lireLesMessageGroupesLocalUseCase;
  LireLesMessageDetailsLocalUseCase lireLesMessageDetailsLocalUseCase;
  SauvegarderLesMessageGroupesLocalUseCase sauvegarderLesMessageGroupesLocalUseCase;
  SauvegarderMessageDetailEntrantLocalUseCase sauvegarderMessageDetailEntrantLocalUseCase;
  SauvegarderTousLesMessageDetailsLocalUseCase sauvegarderTousLesMessageDetailsLocalUseCase;

  //static UserNetworkService user;

  ChatInteractor._(
      this.creerMessageUseCase,
      this.recupererListMessageDetailUseCase,
      this.recupererListMessageGroupeUseCase,
      this.recupererMessageGroupeUseCase,
      this.supprimerMessageDetailUseCase,
      this.lireLesGroupesUseCase,
      this.lireLesMessagesUseCase,
      this.sauvegarderLesGroupesUseCase,
      this.sauvegarderMessageEntrantUseCase,
      this.sauvegarderTousLesMessagesUseCase);

  static build(UserLocalService user,MessageNetworkService network, MessageLocalService local) {

    return ChatInteractor._(
        CreerMessageUseCase(user, network, local),
        RecupererListMessageDetailUseCase(network, local),
        RecupererListMessageGroupeUseCase(network, local),
        RecupererMessageGroupeUseCase(network, local),
        SupprimerMessageDetailUseCase(network, local),
        LireLesGroupesUseCase(network, local),
        LireLesMessagesUseCase(network, local),
        SauvegarderLesGroupesUseCase(local, network),
        SauvegarderMessageEntrantUseCase(network, local),
        SauvegarderTousLesMessagesUseCase(network, local));
  }
}

@Riverpod(keepAlive: true)
ChatInteractor chatInteractor(Ref ref) {
  throw Exception("Non implementé");
}
