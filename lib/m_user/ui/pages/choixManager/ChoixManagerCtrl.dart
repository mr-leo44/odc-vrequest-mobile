import 'package:odc_mobile_project/m_user/ui/pages/choixManager/ChoixManagerState.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../business/interactor/UserInteractor.dart';
import '../../../business/model/User.dart';


part "ChoixManagerCtrl.g.dart";

@riverpod
class ChoixManagerCtrl extends _$ChoixManagerCtrl{
  @override
  ChoixManagerState build() {
    return ChoixManagerState();
  }

  Future<List<String>> getNameUser(String name) async{
    var usecase = ref.watch(userInteractorProvider).getNameUserUseCase;
    var res = await usecase.run(name);
    state = state.copyWith(getname: res);
    return res;
  }
  Future<User> getUser()  async{
    var usecase = ref.watch(userInteractorProvider).getUserLocalUseCase;
    var res=await usecase.run();
    state = state.copyWith(user: res);
    return Future.value(res);

  }
  Future<bool> soumettreManager(String name, int id) async{
    var usecase = ref.watch(userInteractorProvider).soumettreManagerUseCase;
    await usecase.run(name, id);
    return true;
  }
  Future<String> getToken() async{
    var usecase =  ref.watch(userInteractorProvider).getTokenUseCase;
    var res = await usecase.run();
    state = state.copyWith(token: res);
    return Future.value(res);
  }
  Future<User?> getNetworkUser() async{
    var usecase = ref.watch(userInteractorProvider).getUserNetworkUseCase;
    var res = await usecase.run();
    return res;
  }
}