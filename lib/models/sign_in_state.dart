/*
  SignInState: ログインに必要なデータを管理するState
 */
class SignInState {
  final String email;
  final String password;
  final Object? error;

  SignInState(this.email, this.password, this.error);
}
