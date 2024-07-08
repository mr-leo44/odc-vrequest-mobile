import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../business/interactor/UserInteractor.dart';
import 'CompteProfilPageState.dart';

part "CompteProfilPageCtrl.g.dart";

@riverpod
class CompteProfilPageCtrl extends _$CompteProfilPageCtrl{
  @override
  CompteProfilPageState build() {
    return CompteProfilPageState();
  }
  void getUser()  async{
    var usecase = ref.watch(userInteractorProvider).getUserLocalUseCase;
    var res=await usecase.run();
    state = state.copyWith(user: res);

  }
}