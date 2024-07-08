
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
