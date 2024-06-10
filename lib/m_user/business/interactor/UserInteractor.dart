import 'package:odc_mobile_project/m_user/business/interactor/userUseCase/DisconnectUseCase.dart';
import 'package:odc_mobile_project/m_user/business/interactor/userUseCase/GetTokenUseCase.dart';
import 'package:odc_mobile_project/m_user/business/interactor/userUseCase/GetUserLocalUseCase.dart';
import 'package:odc_mobile_project/m_user/business/interactor/userUseCase/GetUserNetworkUseCase.dart';
import 'package:odc_mobile_project/m_user/business/interactor/userUseCase/SaveTokenUseCase.dart';
import 'package:odc_mobile_project/m_user/business/interactor/userUseCase/SaveUserUseCase.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../service/userLocalService.dart';
import '../service/userNetworkService.dart';
import 'userUseCase/AuthenticateUseCase.dart';
part "UserInteractor.g.dart";

class UserInteractor{
  Authenticateusecase authenticateusecase;
  DisconnectUseCase  disconnectUseCase;
  GetTokenUseCase getTokenUseCase;
  GetUserLocalUseCase getUserLocalUseCase;
  GetUserNetworkUseCase getUserNetworkUseCase;
  SaveTokenUseCase saveTokenUseCase;
  SaveUserUseCase saveUserUseCase;


  UserInteractor._(
        this.authenticateusecase,
      this.disconnectUseCase,
      this.getTokenUseCase,
      this.getUserNetworkUseCase,
      this.getUserLocalUseCase,
      this.saveTokenUseCase,
      this.saveUserUseCase
      );

  static build(UserNetworkService network, UserLocalService local ){
    return UserInteractor._(
        Authenticateusecase(network, local),
        DisconnectUseCase(local),
        GetTokenUseCase(local),
        GetUserNetworkUseCase(network),
        GetUserLocalUseCase(local),
        SaveTokenUseCase(local),
        SaveUserUseCase(local)
    );
  }
}

@Riverpod(keepAlive: true)
UserInteractor userInteractor(Ref ref){
  throw Exception("Non implementé");
}
