import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';

import '../../../../m_user/business/model/User.dart';

class DemandeEnCoursState {
  int nbrDemande;
  User? user;
  List<Demande> demande;
  List<Demande> listDemandesSearch;
  bool isLoading;
  bool isEmpty;
  bool visible;
  bool notFound;

  DemandeEnCoursState({
    this.isLoading = false,
    this.isEmpty = false,
    this.visible = false,
    this.notFound = false,
    this.nbrDemande = 0,
    this.user = null,
    this.demande = const [],
    this.listDemandesSearch = const [],
  });

  DemandeEnCoursState copyWith(
          {int? nbrDemande,
          User? user,
          List<Demande>? demande,
          List<Demande>? listDemandesSearch,
          bool? isLoading,
          bool? visible,
          bool? notFound,
          bool,
          isEmpty}) =>
      DemandeEnCoursState(
          nbrDemande: nbrDemande ?? this.nbrDemande,
          user: user ?? this.user,
          demande: demande ?? this.demande,
          listDemandesSearch: listDemandesSearch ?? this.listDemandesSearch,
          isLoading: isLoading ?? this.isLoading,
          visible: visible ?? this.visible,
          notFound: notFound ?? this.notFound,
          isEmpty: isEmpty ?? this.isEmpty);
}
