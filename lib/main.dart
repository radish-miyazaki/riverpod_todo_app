import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_app/pages/home_page.dart';
import 'package:riverpod_todo_app/pages/sign_in_page.dart';
import 'package:riverpod_todo_app/providers/auth_state_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final User? _user = watch(userProvider);

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _user == null ? SignInPage() : HomePage(),
    );
  }
}
