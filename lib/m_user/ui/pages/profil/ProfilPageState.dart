import '../../../business/model/User.dart';

class ProfilPageState {
  bool isLoading;
  User? user;


  ProfilPageState({
    this.isLoading = false,
    this.user = null,

  });

  ProfilPageState copyWith({
    bool? isLoading,
    User? user,

  }) =>
      ProfilPageState(
        isLoading: isLoading ?? this.isLoading,
        user: user ?? this.user,

      );
}