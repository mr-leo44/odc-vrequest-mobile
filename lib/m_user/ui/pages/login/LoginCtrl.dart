import 'package:odc_mobile_project/m_user/business/interactor/UserInteractor.dart';
import 'package:odc_mobile_project/m_user/business/model/Authenticate.dart';
import 'package:odc_mobile_project/m_user/business/model/AuthenticateResponse.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'LoginState.dart';


part "LoginCtrl.g.dart";

@riverpod
class LoginCtrl extends _$LoginCtrl {
  @override
  LoginState build() {
    return LoginState();
  }

  void readLocalToken()async{
    var usecase = ref.watch(userInteractorProvider).getUserLocalUseCase;
    var res=await usecase.run();
    print("token local ${res?.toJson()}");

  }

  // execution d'une action
  Future<AuthenticateResponse?> authenticate(String username, String passwordValue) async {
    var data =
    AuthenticateRequestBody(username: username, password: passwordValue);
    var usecase = ref.watch(userInteractorProvider).authenticateusecase;
    state = state.copyWith(isLoading: true);
    var res = await usecase.run(data);
    state = state.copyWith(isLoading: false);
    return res;
  }
}
