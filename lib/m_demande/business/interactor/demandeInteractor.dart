import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:odc_mobile_project/m_demande/business/interactor/demande/AnnulerDamandeUseCase.dart';
import 'package:odc_mobile_project/m_demande/business/interactor/demande/CreerDemandeUseCase.dart';
import 'package:odc_mobile_project/m_demande/business/interactor/demande/GetDemandeUseCase.dart';
import 'package:odc_mobile_project/m_demande/business/interactor/demande/ListeDemandeUseCase.dart';
import 'package:odc_mobile_project/m_demande/business/interactor/site/ListSiteUseCase.dart';
import 'package:odc_mobile_project/m_demande/business/service/DemandeNetworkService.dart';
import 'package:odc_mobile_project/m_user/business/service/userLocalService.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'demande/GetAllDemandeUseCase.dart';
import 'demande/GetDemandeTraiteUseCase.dart';
import 'demande/LastDemandeUseCase.dart';
import 'demande/NombreDemandeUseCase.dart';

part 'demandeInteractor.g.dart';

class DemandeInteractor {
  AnnulerDemandeUseCase annulerDemandeUseCase;
  CreerDemandeUseCase creerDemandeUseCase;
  GetDemandeUseCase getDemandeUseCase;
  ListDemandeUseCase listDemandeUseCase;
  ListSiteUseCase listSiteUseCase;
  NombreDemandeUseCase nombreDemandeUseCase;
  LastDemandeUseCase lastDemandeUseCase;
  GetAllDemandeUseCase getAllDemandeUseCase;
  GetDemandeTraiteUseCase getDemandeTraiteUseCase;

  DemandeInteractor._(this.annulerDemandeUseCase, this.creerDemandeUseCase,
      this.getDemandeUseCase, this.listDemandeUseCase, this.listSiteUseCase, this.nombreDemandeUseCase,
      this.lastDemandeUseCase, this.getAllDemandeUseCase, this.getDemandeTraiteUseCase);

  static build(DemandeNetworkService network, UserLocalService local) {
    return DemandeInteractor._(
        AnnulerDemandeUseCase(network, local),
        CreerDemandeUseCase(network, local),
        GetDemandeUseCase(network, local),
        ListDemandeUseCase(network, local),
        ListSiteUseCase(network, local),
        NombreDemandeUseCase(network,local),
        LastDemandeUseCase(network,local),
        GetAllDemandeUseCase(network,local),
        GetDemandeTraiteUseCase(network,local)
    );
  }
}
@Riverpod(keepAlive: true)
DemandeInteractor demandeInteractor(Ref ref) {
  throw Exception("Non implementé");
}
