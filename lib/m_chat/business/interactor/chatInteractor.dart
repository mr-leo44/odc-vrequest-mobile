import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:odc_mobile_project/m_chat/business/interactor/MessageDetails/lireListMessageDetailNetworkUseCase.dart';
import 'package:odc_mobile_project/m_chat/business/interactor/MessageDetails/creerMessageDetailNetworkUseCase.dart';
import 'package:odc_mobile_project/m_chat/business/interactor/MessageGroupe/lireListMessageGroupeNetworkUseCase.dart';
import 'package:odc_mobile_project/m_chat/business/interactor/MessageDetails/supprimerMessageDetailNetworkUseCase.dart';
import 'package:odc_mobile_project/m_chat/business/interactor/MessageGroupe/lireLesMessageGroupesLocalUseCase.dart';
import 'package:odc_mobile_project/m_chat/business/interactor/MessageDetails/lireLesMessageDetailsLocalUseCase.dart';
import 'package:odc_mobile_project/m_chat/business/interactor/MessageGroupe/sauvegarderLesMessageGroupesLocalUseCase.dart';
import 'package:odc_mobile_project/m_chat/business/interactor/MessageDetails/sauvegarderMessageDetailEntrantLocalUseCase.dart';
import 'package:odc_mobile_project/m_chat/business/interactor/MessageDetails/sauvegarderTousLesMessageDetailsLocalUseCase.dart';
import 'package:odc_mobile_project/m_chat/business/service/messageLocalService.dart';
import 'package:odc_mobile_project/m_chat/business/service/messageNetworkService.dart';
import 'package:odc_mobile_project/m_user/business/service/userLocalService.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chatInteractor.g.dart';

class ChatInteractor {
  CreerMessageDetailNetworkUseCase creerMessageDetailNetworkUseCase;
  LireListMessageDetailNetworkUseCase recupererLaListMessageDetailUseCase;
  LireListMessageGroupeNetworkUseCase lireListMessageGroupeUseCase;
  SupprimerMessageDetailNetworkUseCase supprimerMessageDetailNetworkUseCase;

  LireLesMessageGroupesLocalUseCase lireLesMessageGroupesLocalUseCase;
  LireLesMessageDetailsLocalUseCase lireLesMessageDetailsLocalUseCase;
  SauvegarderLesMessageGroupesLocalUseCase sauvegarderLesMessageGroupesLocalUseCase;
  SauvegarderMessageDetailEntrantLocalUseCase sauvegarderMessageDetailEntrantLocalUseCase;
  SauvegarderTousLesMessageDetailsLocalUseCase sauvegarderTousLesMessageDetailsLocalUseCase;

  //static UserNetworkService user;

  ChatInteractor._(
      this.creerMessageDetailNetworkUseCase,
      this.recupererLaListMessageDetailUseCase,
      this.lireListMessageGroupeUseCase,
      this.supprimerMessageDetailNetworkUseCase,
      this.lireLesMessageGroupesLocalUseCase,
      this.lireLesMessageDetailsLocalUseCase,
      this.sauvegarderLesMessageGroupesLocalUseCase,
      this.sauvegarderMessageDetailEntrantLocalUseCase,
      this.sauvegarderTousLesMessageDetailsLocalUseCase);

  static build(UserLocalService user,MessageNetworkService network, MessageLocalService local) {

    return ChatInteractor._(
        CreerMessageDetailNetworkUseCase(user, network, local),
        LireListMessageDetailNetworkUseCase(network, user),
        LireListMessageGroupeNetworkUseCase(network, user),
        SupprimerMessageDetailNetworkUseCase(network, user),
        LireLesMessageGroupesLocalUseCase(local),
        LireLesMessageDetailsLocalUseCase(local),
        SauvegarderLesMessageGroupesLocalUseCase(local),
        SauvegarderMessageDetailEntrantLocalUseCase(local),
        SauvegarderTousLesMessageDetailsLocalUseCase(local));
  }
}

@Riverpod(keepAlive: true)
ChatInteractor chatInteractor(Ref ref) {
  throw Exception("Non implementé");
}
