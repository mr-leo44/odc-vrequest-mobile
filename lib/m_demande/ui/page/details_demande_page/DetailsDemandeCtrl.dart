import 'package:odc_mobile_project/m_chat/business/interactor/chatInteractor.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';
import 'package:odc_mobile_project/m_demande/business/interactor/demandeInteractor.dart';
import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'package:odc_mobile_project/m_demande/ui/page/details_demande_page/DetailsDemandeState.dart';
import 'package:odc_mobile_project/m_user/business/interactor/UserInteractor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'DetailsDemandeCtrl.g.dart';

@riverpod
class DetailsDemandeCtrl extends _$DetailsDemandeCtrl {
  @override
  DetailsDemandeState build() {
    return DetailsDemandeState();
  }

  void recupererDemande(int id) async {
    state = state.copyWith(isLoading: true);
    var useCase = ref.watch(demandeInteractorProvider).getDemandeUseCase;
    var res = await useCase.run(id);
    if (res != null) {
      state = state.copyWith(demande: res, isLoading: false);
      print("updated state ${res.initiateur!.nom}");
    } else {
      state = state.copyWith(isEmpty: true);
    }
  }

  void annulerDemande(int id) async {
    var useCase = ref.watch(demandeInteractorProvider).annulerDemandeUseCase;
    var res = await useCase.run(id);
  }

  Future<String> getToken() async{
    var usecase =  ref.watch(userInteractorProvider).getTokenUseCase;
    var res = await usecase.run();
    return Future.value(res);
  }

  void getMessages(int demandeId) async {
    state = state.copyWith(isLoading: true, chatsUsers: null);
    var token = await getToken(); 
    var interactor = ref.watch(chatInteractorProvider);
    ChatUsersModel res = await interactor.recupererMessageGroupeUseCase.run(demandeId,token);
    state = state.copyWith(isLoading: false, chatsUsers: res);
  }

}
