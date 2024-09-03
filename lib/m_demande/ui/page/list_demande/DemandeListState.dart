import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';

class DemandeListState {
  List<Demande> listDemandes;
  bool isLoading;
  bool isEmpty;
  int nbreDemande;

  DemandeListState({
    this.listDemandes=const [],
    this.isLoading=false,
    this.isEmpty=false,
    this.nbreDemande=0
  });

  DemandeListState copyWith({
    List<Demande>? listDemandes,
    bool? isLoading,
    bool? isEmpty,
    int? nbreDemande,
  }) =>
      DemandeListState(
        listDemandes: listDemandes ?? this.listDemandes,
        isLoading: isLoading ?? this.isLoading,
        isEmpty: isEmpty ?? this.isEmpty,
        nbreDemande: nbreDemande ?? this.nbreDemande,

      );
}