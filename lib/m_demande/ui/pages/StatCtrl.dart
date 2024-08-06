

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../m_user/business/interactor/UserInteractor.dart';
import '../../business/interactor/demandeInteractor.dart';
import 'StatState.dart';
part 'StatCtrl.g.dart';

@riverpod
class StatCtrl extends _$StatCtrl{

  @override
  StatState build() {
    return StatState();
  }
  Future<Map<String,dynamic>> nombreDemande() async{
    var usecase = ref.watch(demandeInteractorProvider).nombreDemandeUseCase;
    var res = await usecase.run();

    state = state.copyWith(nombre: res);
    return res;
  }
  void getUser()  async{
    var usecase = ref.watch(userInteractorProvider).getUserLocalUseCase;
    var res=await usecase.run();
    state = state.copyWith(user: res);

  }
}