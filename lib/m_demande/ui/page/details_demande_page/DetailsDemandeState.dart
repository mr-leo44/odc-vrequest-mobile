import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';

class DetailsDemandeState {
  Demande? demande;
  bool isEmpty;
  bool isLoading;

  DetailsDemandeState({
    this.demande = null,
    this.isEmpty = true,
    this.isLoading = false,
  });

  DetailsDemandeState copyWith({
    Demande? demande,
    bool? isEmpty,
    bool? isLoading,
  }) =>
      DetailsDemandeState(
        demande: demande ?? this.demande,
        isEmpty: isEmpty ?? this.isEmpty,
        isLoading: isLoading ?? this.isLoading,
      );
}
