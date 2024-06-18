import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:odc_mobile_project/chat/ui/pages/ChatDetail/ChatDetailModel.dart';
import 'package:odc_mobile_project/chat/ui/pages/ChatDetail/ChatDetailState.dart';
import 'package:odc_mobile_project/chat/ui/pages/ChatDetail/Passager.dart';

part "ChatDetailCtrl.g.dart";

@riverpod
class ChatDetailCtrl extends _$ChatDetailCtrl {
  ChatDetailModel chatDetailModel = ChatDetailModel(
    ticket: "Ticket 007",
    dateDemande: "12/12/2024 12:40:02",
    motif: "Depot courrier a la banque",
    lieuDestination: "Matadi",
    lieuDepart: "Kinshasa",
    status: "En Cours",
  );
  Passager passagers = Passager(
    initiateur: "Kevin Hart",
    chauffeur: "Atari",
    nbrEtranger: 2,
  );

  @override
  ChatDetailState build() {
    ChatDetailModel chatDetail = getChatDetail();
    return ChatDetailState(chatDetail: chatDetail);
  }

  ChatDetailModel getChatDetail() {
    state = state.copyWith(
      isLoading: true,
      chatDetail: this.chatDetailModel,
    );
    Future.delayed(Duration(minutes: 2));
    state = state.copyWith(
        isLoading: false,
        chatDetail: this.chatDetailModel);

    return this.chatDetailModel;
  }

  void getPassagers() async {
    state = state.copyWith(
      isLoading: true,
      chatDetail: this.chatDetailModel,
    );
    Future.delayed(Duration(minutes: 2));
    state = state.copyWith(
        isLoading: false,
        chatDetail: this.chatDetailModel,
        passager: this.passagers);
  }
}
