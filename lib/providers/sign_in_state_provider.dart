import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_app/models/sign_in_state.dart';
import 'package:riverpod_todo_app/providers/auth_state_provider.dart';

class SignInNotifier extends StateNotifier<SignInState> {
  SignInNotifier(this.read) : super(SignInState('', '', null));

  // 他のProviderを呼び出すために、Providerからreadを受け取る。
  final Reader read;

  void setEmail(String value) =>
      state = SignInState(value, state.password, state.error);

  void setPassword(String value) =>
      state = SignInState(state.email, value, state.error);

  // authStateProviderのsignInメソッドにSignInStateの値をセットして実行
  Future<void> signIn() async {
    try {
      await read(authStateProvider.notifier).signIn(
        state.email,
        state.password,
      );
    } catch (e) {
      state = SignInState(state.email, state.password, e);
    }
  }
}

final signInStateProvider =
    StateNotifierProvider.autoDispose<SignInNotifier, SignInState>((ref) {
  // 他のProviderを呼び出すために、StateNotifierへreadを渡す。
  return SignInNotifier(ref.read);
});
