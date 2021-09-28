import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_app/models/sign_in_state.dart';
import 'package:riverpod_todo_app/pages/home_page.dart';
import 'package:riverpod_todo_app/providers/auth_state_provider.dart';
import 'package:riverpod_todo_app/providers/sign_in_state_provider.dart';

class SignInPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final SignInState _state = watch(signInStateProvider);

    // ログイン中の場合は、HomeWidgetへ遷移させたいのでProviderListenerを用いる。
    return ProviderListener(
      onChange: (context, User? user) {
        // ログイン中の場合はHomeWidgetへ遷移する
        if (user != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
      },
      provider: userProvider,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              initialValue: _state.email,
              onChanged: (value) =>
                  context.read(signInStateProvider.notifier).setEmail(value),
            ),
            TextFormField(
              initialValue: _state.password,
              onChanged: (value) =>
                  context.read(signInStateProvider.notifier).setPassword(value),
            ),
            ElevatedButton(
              onPressed: () =>
                  context.read(signInStateProvider.notifier).signIn(),
              child: Text('Sign In'),
            ),
            if (_state.error != null)
              Text(
                _state.error.toString(),
                style: TextStyle(color: Colors.redAccent),
              ),
          ],
        ),
      ),
    );
  }
}
