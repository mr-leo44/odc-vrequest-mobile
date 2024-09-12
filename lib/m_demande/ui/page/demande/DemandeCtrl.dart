import 'package:odc_mobile_project/m_demande/business/model/Personn.dart';
import 'package:odc_mobile_project/m_user/business/model/User.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../m_user/business/interactor/UserInteractor.dart';
import '../../../business/interactor/demandeInteractor.dart';
import '../../../business/model/DemandeRequest.dart';
import 'DemandeState.dart';

part 'DemandeCtrl.g.dart';

@riverpod
class DemandeCtrl extends _$DemandeCtrl {
  @override
  DemandeState build() {
    return DemandeState();
  }

  void recupereListSite() async {
    state = state.copyWith(switchCarte: true);
    var useCase = ref
        .watch(demandeInteractorProvider)
        .listSiteUseCase;
    var res = await useCase.run();
    print("pas encore des sites");
    if (res != null) {
      state = state.copyWith(site: res);
      print(state.site);
    }
  }

  void getUser() async {
    var usecase = ref
        .watch(userInteractorProvider)
        .getUserLocalUseCase;
    var res = await usecase.run();
    state = state.copyWith(user: res);
  }

  Future<bool?> demandeByForm(DemandeRequest data) async {
    state = state.copyWith(isLoading: true);
    if (data.validate()) {
      state = state.copyWith(isValid: true);
      var useCase = ref
          .watch(demandeInteractorProvider)
          .creerDemandeUseCase;
      var res = await useCase.run(data);
      state = state.copyWith(isLoading: false);
      return true;
    }else{
      state = state.copyWith(isLoading: false);
      return false;
    }


  }

  void switchCarte(int? index) {
    if (index == 0) {
      state = state.copyWith(switchCarte: true);
    } else {
      state = state.copyWith(switchCarte: false);
    }
    print(state.switchCarte);
  }

  Future<List<Personn>> getNameUser(String name) async{
    var usecase = ref.watch(demandeInteractorProvider).getUserByName;
    var res = await usecase.run(name);
    return res;
  }
  Future<User> getName()  async{
    var usecase = ref.watch(userInteractorProvider).getUserLocalUseCase;
    var res=await usecase.run();
    return Future.value(res);

  }

  void changePage(){
    if(state.page == 1){
      state = state.copyWith(page:2);
    }else{
      state = state.copyWith(page: 1);
    }
  }
}