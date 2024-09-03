import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';
import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';

class DetailsDemandeState {
  Demande? demande;
  bool isEmpty;
  bool isLoading;
  ChatUsersModel? chatsUsers;

  DetailsDemandeState({
    this.demande = null,
    this.isEmpty = true,
    this.isLoading = false,
    this.chatsUsers = null,
  });

  DetailsDemandeState copyWith({
    Demande? demande,
    bool? isEmpty,
    bool? isLoading,
    ChatUsersModel? chatsUsers,
  }) =>
      DetailsDemandeState(
        demande: demande ?? this.demande,
        isEmpty: isEmpty ?? this.isEmpty,
        isLoading: isLoading ?? this.isLoading,
        chatsUsers: chatsUsers ?? this.chatsUsers,
      );
}
