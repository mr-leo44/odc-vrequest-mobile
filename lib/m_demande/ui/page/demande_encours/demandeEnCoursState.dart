import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';

import '../../../../m_user/business/model/User.dart';

class DemandeEnCoursState {
  int nbrDemande;
  User? user;
  List<Demande> demande;
  bool isLoading;
  bool isEmpty;
  bool visible;

  DemandeEnCoursState(
      {this.isLoading = false,
      this.isEmpty = false,
      this.visible = false,
      this.nbrDemande = 0,
      this.user = null,
      this.demande = const []});

  DemandeEnCoursState copyWith(
          {int? nbrDemande,
          User? user,
          List<Demande>? demande,
          bool? isLoading,
          bool? visible,
          bool,
          isEmpty}) =>
      DemandeEnCoursState(
          nbrDemande: nbrDemande ?? this.nbrDemande,
          user: user ?? this.user,
          demande: demande ?? this.demande,
          isLoading: isLoading ?? this.isLoading,
          visible: visible ?? this.visible,
          isEmpty: isEmpty ?? this.isEmpty);
}
