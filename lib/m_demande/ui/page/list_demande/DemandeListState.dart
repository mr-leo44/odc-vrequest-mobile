import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';

class DemandeListState {
  List<Demande> listDemandes;
  bool isLoading;
  bool isEmpty;

  DemandeListState({
    this.listDemandes=const [],
    this.isLoading=false,
    this.isEmpty=false
  });

  DemandeListState copyWith({
    List<Demande>? listDemandes,
    bool? isLoading,
    bool? isEmpty
  }) =>
      DemandeListState(
        listDemandes: listDemandes ?? this.listDemandes,
        isLoading: isLoading ?? this.isLoading,
        isEmpty: isEmpty ?? this.isEmpty
      );
}