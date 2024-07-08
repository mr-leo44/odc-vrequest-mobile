import '../../../business/model/User.dart';

class CompteProfilPageState {
  bool isLoading;
  User? user;


  CompteProfilPageState({
    this.isLoading = false,
    this.user = null,

  });

  CompteProfilPageState copyWith({
    bool? isLoading,
    User? user,

  }) =>
      CompteProfilPageState(
        isLoading: isLoading ?? this.isLoading,
        user: user ?? this.user,

      );
}