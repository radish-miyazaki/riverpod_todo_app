import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_app/models/add_todo_state.dart';

class AddTodoNotifier extends StateNotifier<AddTodoState> {
  AddTodoNotifier() : super(AddTodoState('', null, false));

  void setBody(String value) =>
      state = AddTodoState(value, state.error, state.hasSubmitted);

  Future<void> submit() async {
    try {
      await FirebaseFirestore.instance.collection("todos").add({
        'body': state.body,
        'date': Timestamp.now(),
      });
      state = AddTodoState(state.body, state.error, true);
    } catch (e, _) {
      state = AddTodoState(state.body, e, state.hasSubmitted);
    }
  }
}

final addTodoStateProvider =
    StateNotifierProvider.autoDispose<AddTodoNotifier, AddTodoState>((ref) {
  return AddTodoNotifier();
});

final hasSubmittedProvider = Provider.autoDispose((ref) {
  return ref.watch(addTodoStateProvider).hasSubmitted;
});
