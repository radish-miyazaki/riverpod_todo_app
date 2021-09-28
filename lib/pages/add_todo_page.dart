import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_app/models/add_todo_state.dart';
import 'package:riverpod_todo_app/providers/form_state_provider.dart';

class AddTodoPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final AddTodoState formState = watch(addTodoStateProvider);

    return ProviderListener(
      onChange: (context, bool hasSubmitted) {
        if (hasSubmitted) {
          Navigator.of(context).pop();
        }
      },
      provider: hasSubmittedProvider,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                initialValue: formState.body,
                onChanged: (value) =>
                    context.read(addTodoStateProvider.notifier).setBody(value),
              ),
              ElevatedButton(
                onPressed: formState.canSubmit
                    ? () => context.read(addTodoStateProvider.notifier).submit()
                    : null,
                child: Text('submit'),
                style: ElevatedButton.styleFrom(
                  primary: formState.canSubmit
                      ? Theme.of(context).primaryColor.withOpacity(0.5)
                      : null,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
