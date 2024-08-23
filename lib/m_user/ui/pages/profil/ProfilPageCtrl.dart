import 'package:get_storage/get_storage.dart';
import 'package:odc_mobile_project/m_user/business/interactor/UserInteractor.dart';
import 'package:odc_mobile_project/m_user/business/model/User.dart';
import 'package:odc_mobile_project/m_user/ui/pages/profil/ProfilPageState.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "ProfilPageCtrl.g.dart";


@riverpod
class ProfilPageCtrl extends _$ProfilPageCtrl {
  @override
  ProfilPageState build() {
    return ProfilPageState();
  }

  void getUser()  async{
    var usecase = ref.watch(userInteractorProvider).getUserLocalUseCase;
    var res=await usecase.run();
    state = state.copyWith(user: res);

  }

  Future<bool> disconnect() async {

    var usecase = ref.watch(userInteractorProvider).disconnectUseCase;
    await usecase.run();

    return true;

  }
}
