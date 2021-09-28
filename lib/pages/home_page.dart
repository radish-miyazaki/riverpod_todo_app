import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_app/models/todo.dart';
import 'package:riverpod_todo_app/pages/add_todo_page.dart';
import 'package:riverpod_todo_app/pages/sign_in_page.dart';
import 'package:riverpod_todo_app/providers/auth_state_provider.dart';
import 'package:riverpod_todo_app/providers/todos_provider.dart';
import 'package:riverpod_todo_app/widgets/sort_button_widget.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final asyncTodos = watch(todosProvider);

    return ProviderListener(
      onChange: (context, User? user) {
        if (user == null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => SignInPage()),
          );
        }
      },
      provider: userProvider,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Todo App"),
          actions: [
            IconButton(
                onPressed: () =>
                    context.read(authStateProvider.notifier).signOut(),
                icon: Icon(Icons.logout))
          ],
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: SortButtonWidget(),
                ),
                Expanded(
                  child: asyncTodos.when(
                    data: (todos) {
                      return ListView.builder(
                        itemCount: todos.length,
                        itemBuilder: (context, index) {
                          final Todo todo = todos[index];

                          return ListTile(
                            title: Text(todo.body),
                            subtitle: Text(todo.id),
                            trailing: Text(todo.date.toString()),
                          );
                        },
                      );
                    },
                    loading: () {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    error: (e, _) {
                      return Center(
                        child: Text(e.toString()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => AddTodoPage(),
            ),
          ),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
