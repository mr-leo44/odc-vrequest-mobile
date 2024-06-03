class LoginState {
  bool isLoading;

  LoginState({
    this.isLoading=false,
  });

  LoginState copyWith({
    bool? isLoading,
  }) =>
      LoginState(
        isLoading: isLoading ?? this.isLoading,
      );
}
