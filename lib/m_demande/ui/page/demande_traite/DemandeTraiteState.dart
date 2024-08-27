import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';

class DemandeTraiteState {
  List<Demande> listDemandes;
  bool isLoading;
  bool isEmpty;
  int nbreDemande;

  DemandeTraiteState(
      {this.listDemandes = const [],
      this.isLoading = false,
      this.isEmpty = false,
      this.nbreDemande = 0});

  DemandeTraiteState copyWith({
    List<Demande>? listDemandes,
    bool? isLoading,
    bool? isEmpty,
    int? nbreDemande,
  }) =>
      DemandeTraiteState(
        listDemandes: listDemandes ?? this.listDemandes,
        isLoading: isLoading ?? this.isLoading,
        isEmpty: isEmpty ?? this.isEmpty,
        nbreDemande: nbreDemande ?? this.nbreDemande,
      );
}
