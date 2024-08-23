import 'package:odc_mobile_project/m_user/business/model/User.dart';

class OnboardingState {
  bool isLoading;
  User? auth;

  OnboardingState({
    this.isLoading = false,
    this.auth = null,
  });

  OnboardingState copyWith({
    bool? isLoading,
    User? auth,
  }) =>
      OnboardingState(
        isLoading: isLoading ?? this.isLoading,
        auth: auth ?? this.auth,
      );
}