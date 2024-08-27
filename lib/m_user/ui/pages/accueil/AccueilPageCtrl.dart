

import 'package:odc_mobile_project/m_demande/business/interactor/demandeInteractor.dart';
import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../business/interactor/UserInteractor.dart';
import 'AccueilPageState.dart';
part "AccueilPageCtrl.g.dart";

@riverpod
class AccueilPageCtrl extends _$AccueilPageCtrl {
  @override
  AccueilPageState build() {
    return AccueilPageState();
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
  Future<List<Demande>> recentDemande() async{
    var usecase = ref.watch(demandeInteractorProvider).lastDemandeUseCase;
    var res = await usecase.run();
    state = state.copyWith(last: res);
    return res;
  }

}