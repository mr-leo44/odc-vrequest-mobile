import 'package:odc_mobile_project/m_demande/business/model/DemandeRequest.dart';
import 'package:odc_mobile_project/m_demande/business/model/Personn.dart';
import 'package:odc_mobile_project/m_demande/business/model/Site.dart';

import '../../../../m_user/business/model/User.dart';

class DemandeState {
  List<Site> site;
  DemandeRequest? demandeRequest;
  bool isValid;
  bool isSubmit;
  bool isLoading;
  bool switchCarte;
  User? user;
  int page;
  List<Personn> passagers;

  DemandeState(
      {
        this.site = const [],
        this.passagers = const [],
      this.demandeRequest = null,
      this.isValid = false,
      this.isSubmit = false,
      this.isLoading = false,
      this.switchCarte = false,
      this.user = null,
      this.page = 1});

  DemandeState copyWith({
    List<Site>? site,
    List<Personn>? passagers,
    DemandeRequest? demandeRequest,
    bool? isValid,
    bool? isSubmit,
    bool? isLoading,
    bool? switchCarte,
    User? user,
    int? page
  }) =>
      DemandeState(
        site: site ?? this.site,
        passagers: passagers ?? this.passagers,
        demandeRequest: this.demandeRequest,
        isValid: isValid ?? this.isValid,
        isSubmit: isSubmit ?? this.isSubmit,
        isLoading: isLoading ?? this.isLoading,
        switchCarte: switchCarte ?? this.switchCarte,
        user: user ?? this.user,
        page: page ?? this.page,
      );
}
