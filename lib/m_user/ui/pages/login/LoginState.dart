class LoginState {
  bool isLoading;

  LoginState({
    this.isLoading=false,
    //chargement
  });

  LoginState copyWith({
    bool? isLoading,
  }) =>
      LoginState(
        isLoading: isLoading ?? this.isLoading,
      );
}
