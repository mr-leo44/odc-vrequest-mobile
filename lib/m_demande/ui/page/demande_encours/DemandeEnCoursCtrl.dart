

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../m_user/business/interactor/UserInteractor.dart';
import '../../../business/interactor/demandeInteractor.dart';
import 'demandeEnCoursState.dart';

part 'DemandeEnCoursCtrl.g.dart';
@riverpod
class DemandeEnCoursCtrl extends _$DemandeEnCoursCtrl{

  @override
  DemandeEnCoursState build(){
    return DemandeEnCoursState();
  }
  Future<Map<String,dynamic>> nombreDemande() async{
    var usecase = ref.watch(demandeInteractorProvider).nombreDemandeUseCase;
    var res = await usecase.run();

    state = state.copyWith(demande: res);
    return res;
  }
  void getUser()  async{
    var usecase = ref.watch(userInteractorProvider).getUserLocalUseCase;
    var res=await usecase.run();
    state = state.copyWith(user: res);

  }

}