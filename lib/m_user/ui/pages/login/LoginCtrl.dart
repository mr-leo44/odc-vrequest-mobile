import 'package:odc_mobile_project/m_user/business/interactor/UserInteractor.dart';
import 'package:odc_mobile_project/m_user/business/model/Authenticate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'LoginState.dart';


part "LoginCtrl.g.dart";

@riverpod
class LoginCtrl extends _$LoginCtrl {
  @override
  LoginState build() {
    return LoginState();
  }

  // execution d'une action
  void authenticate(String emailValue, String passwordValue) async {
    var data =
        AuthenticateRequestBody(email: emailValue, password: passwordValue);
    var usecase = ref.watch(userInteractorProvider).authenticateusecase;
    state = state.copyWith(isLoading: true);
    var res = await usecase.run(data);
    state = state.copyWith(isLoading: false);
  }
}
