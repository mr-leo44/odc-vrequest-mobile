

import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
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
  void nombreDemande() async{
    state = state.copyWith(isLoading: true, isEmpty: true);
    List<Demande> demandes = [];
    var usecase = ref.watch(demandeInteractorProvider).nombreDemandeUseCase;
    var res = await usecase.run();
    var data = res['demandes_encours'];
    for (int i = 0; i < data.length; i++) {
      var item = data[i];
      demandes.add(Demande.fromJson(item));
    }
    if(demandes.length != 0){
      state = state.copyWith(demande: demandes, nbrDemande: demandes.length, isLoading: false, isEmpty: false);
    }else{
      state = state.copyWith(isLoading: true, isEmpty: true, nbrDemande: 0);
    }
  }
  void getUser()  async{
    var usecase = ref.watch(userInteractorProvider).getUserLocalUseCase;
    var res=await usecase.run();
    state = state.copyWith(user: res);

  }

}