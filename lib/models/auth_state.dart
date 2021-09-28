import 'package:firebase_auth/firebase_auth.dart';

/*
  AuthState: ログイン中かどうか管理するState
 */
class AuthState {
  final User? user;

  AuthState(this.user);
}
