import 'package:odc_mobile_project/m_demande/business/model/Site.dart';

class GlobalMapState {
  bool isSelectDepart;
  bool isSelectDestination;
  bool carte;
  Site? lieuDepart;
  Site? destnation;

  GlobalMapState({
   this.isSelectDepart = false,
    this.isSelectDestination = false,
    this.carte = false,
    this.lieuDepart = null,

    this.destnation = null,
  });

  GlobalMapState copyWith({
    bool? isSelectDepart,
    Site? lieuDepart,
    bool? carte,
    Site? destnation,
  }) =>
      GlobalMapState(
        isSelectDepart: isSelectDepart ?? this.isSelectDepart,
        isSelectDestination: isSelectDestination ?? this.isSelectDestination,
        carte: carte ?? this.carte,
        lieuDepart: lieuDepart ?? this.lieuDepart,
        destnation: destnation ?? this.destnation,
      );
}
