
import 'package:odc_mobile_project/m_user/business/interactor/user/GetListOnboardUseCase.dart';
import 'package:odc_mobile_project/m_user/business/interactor/user/GetStatusOnboardUseCase.dart';
import 'package:odc_mobile_project/m_user/business/interactor/user/TerminateOnboardUseCase.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../service/userLocalService.dart';
import '../service/userNetworkService.dart';
import 'user/AuthenticateUseCase.dart';
import 'user/DisconnectUseCase.dart';
import 'user/GetNameUserUseCase.dart';
import 'user/GetTokenUseCase.dart';
import 'user/GetUserLocalUseCase.dart';
import 'user/GetUserNetworkUseCase.dart';
import 'user/SaveTokenUseCase.dart';
import 'user/SaveUserUseCase.dart';
import 'user/SoumettreManagerUseCase.dart';

part "UserInteractor.g.dart";

class UserInteractor{
  TerminateOnboardUseCase terminateOnboardUseCase;
  GetListOnboardUseCase getListOnboardUseCase;
  GetStatusOnboardUseCase getStatusOnboardUseCase;
  Authenticateusecase authenticateusecase;
  DisconnectUseCase  disconnectUseCase;
  GetTokenUseCase getTokenUseCase;
  GetUserLocalUseCase getUserLocalUseCase;
  GetUserNetworkUseCase getUserNetworkUseCase;
  SaveTokenUseCase saveTokenUseCase;
  SaveUserUseCase saveUserUseCase;
  GetNameUserUseCase getNameUserUseCase;
  SoumettreManagerUseCase soumettreManagerUseCase;


  UserInteractor._(
    this.terminateOnboardUseCase,
    this.getListOnboardUseCase,
    this.getStatusOnboardUseCase,
      this.authenticateusecase,
      this.disconnectUseCase,
      this.getTokenUseCase,
      this.getUserNetworkUseCase,
      this.getUserLocalUseCase,
      this.saveTokenUseCase,
      this.saveUserUseCase,
      this.getNameUserUseCase,
      this.soumettreManagerUseCase
      );

  static build(UserNetworkService network, UserLocalService local ){
    return UserInteractor._(
      TerminateOnboardUseCase(local),
      GetListOnboardUseCase(local),
      GetStatusOnboardUseCase(local),
        Authenticateusecase(network, local),
        DisconnectUseCase(local),
        GetTokenUseCase(local),
        GetUserNetworkUseCase(network,local),
        GetUserLocalUseCase(local),
        SaveTokenUseCase(local),
        SaveUserUseCase(local),
        GetNameUserUseCase(network),
        SoumettreManagerUseCase(network)
    );
  }
}

@Riverpod(keepAlive: true)
UserInteractor userInteractor(Ref ref){
  throw Exception("Non implementé");
}
