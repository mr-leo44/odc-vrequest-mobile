import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';

class DemandeListState {
  List<Demande> listDemandes;
  bool isLoading;

  DemandeListState({
    this.listDemandes=const [],
    this.isLoading=false,
  });

  DemandeListState copyWith({
    List<Demande>? listDemandes,
    bool? isLoading,
  }) =>
      DemandeListState(
        listDemandes: listDemandes ?? this.listDemandes,
        isLoading: isLoading ?? this.isLoading,
      );
}