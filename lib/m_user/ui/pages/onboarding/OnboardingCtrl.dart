import 'package:flutter/material.dart';
import 'package:odc_mobile_project/m_user/business/interactor/UserInteractor.dart';
import 'package:odc_mobile_project/m_user/business/interactor/user/TerminateOnboardUseCase.dart';
import 'package:odc_mobile_project/m_user/business/model/OnboardingPageModel.dart';
import 'package:odc_mobile_project/m_user/ui/pages/onboarding/OnboardingState.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "OnboardingCtrl.g.dart";

@riverpod
class OnboardingCtrl extends _$OnboardingCtrl {
  @override
  OnboardingState build() {
    getUser();
    return OnboardingState();
  }

  Future getUser() async {
    var usecase = ref.watch(userInteractorProvider).getUserLocalUseCase;
    var res = await usecase.run();
    state = state.copyWith(auth: res);
  }

  Future<bool?> getStatusOnboard() async {
    var usecase = ref.watch(userInteractorProvider).getStatusOnboardUseCase;
    return await usecase.run();
  }

  List<OnboardingPageModel> getListOnboard() {
    var usecase = ref.watch(userInteractorProvider).getListOnboardUseCase;
    var onboards = usecase.run();
    // print(onboards);
    return onboards;
  }

  Future terminateOnboard()async {
    var usecase = ref.watch(userInteractorProvider).terminateOnboardUseCase;
    return await usecase.run();
  }
}
