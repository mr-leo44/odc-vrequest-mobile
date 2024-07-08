import '../../../business/model/User.dart';

class LoginState {
  bool isLoading;
  User? user;

  LoginState({
    this.isLoading=false,
    this.user = null
    //chargement
  });

  LoginState copyWith({
    bool? isLoading,
    User? user

  }) =>
      LoginState(
          isLoading: isLoading ?? this.isLoading,
          user: user ?? this.user
      );
}
