import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';

class DemandeTraiteState {
  List<Demande> listDemandes;
  bool isLoading;
  bool isEmpty;

  DemandeTraiteState({
    this.listDemandes=const [],
    this.isLoading=false,
    this.isEmpty=false
  });

  DemandeTraiteState copyWith({
    List<Demande>? listDemandes,
    bool? isLoading,
    bool? isEmpty
  }) =>
      DemandeTraiteState(
          listDemandes: listDemandes ?? this.listDemandes,
          isLoading: isLoading ?? this.isLoading,
          isEmpty: isEmpty ?? this.isEmpty
      );
}