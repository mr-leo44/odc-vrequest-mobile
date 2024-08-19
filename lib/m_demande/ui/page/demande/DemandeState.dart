import 'package:odc_mobile_project/m_demande/business/model/DemandeRequest.dart';
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

  DemandeState(
      {this.site = const [],
      this.demandeRequest = null,
      this.isValid = false,
      this.isSubmit = false,
      this.isLoading = false,
      this.switchCarte = false,
      this.user = null});

  DemandeState copyWith({
    List<Site>? site,
    DemandeRequest? demandeRequest,
    bool? isValid,
    bool? isSubmit,
    bool? isLoading,
    bool? switchCarte,
    User? user,
  }) =>
      DemandeState(
        site: site ?? this.site,
        demandeRequest: this.demandeRequest,
        isValid: isValid ?? this.isValid,
        isSubmit: isSubmit ?? this.isSubmit,
        isLoading: isLoading ?? this.isLoading,
        switchCarte: switchCarte ?? this.switchCarte,
        user: user ?? this.user,
      );
}
