import 'package:odc_mobile_project/m_demande/business/model/Site.dart';

class MapState {
  bool isSelectDepart;
  bool isSelectDestination;
  bool carte;
  int mouvement;
  Site? lieuDepart;
  Site? destnation;

  MapState({
   this.isSelectDepart = false,
    this.isSelectDestination = false,
    this.carte = false,
    this.lieuDepart = null,
    this.mouvement =1,
    this.destnation = null,
  });

  MapState copyWith({
    bool? isSelectDepart,
    bool? isSelectDestination,
    Site? lieuDepart,
    bool? carte,
    int? mouvement,
    Site? destnation,
  }) =>
      MapState(
        isSelectDepart: isSelectDepart ?? this.isSelectDepart,
        isSelectDestination: isSelectDestination ?? this.isSelectDestination,
        carte: carte ?? this.carte,
        mouvement: mouvement ?? this.mouvement,
        lieuDepart: lieuDepart ?? this.lieuDepart,
        destnation: destnation ?? this.destnation,
      );
}
