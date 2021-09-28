import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_app/models/sort_state.dart';
import 'package:riverpod_todo_app/models/todo.dart';
import 'package:riverpod_todo_app/providers/todos_provider.dart';

class SortNotifier extends StateNotifier<SortState> {
  SortNotifier() : super(SortState(false));

  void setAsAsc() => state = SortState(false);
  void setAsDesc() => state = SortState(true);
}

final sortStateProvider = StateNotifierProvider<SortNotifier, SortState>((ref) {
  return SortNotifier();
});

final sortedTodosProvider = Provider<AsyncValue<List<Todo>>>((ref) {
  final asyncTodos = ref.watch(todosProvider);
  final sortState = ref.watch(sortStateProvider);

  return asyncTodos.map(
    data: (value) {
      final List<Todo> todos = [...value.data!.value];
      return sortState.isDesc
          ? AsyncValue.data(todos..sort((a, b) => a.date.compareTo(b.date)))
          : AsyncValue.data(todos..sort((a, b) => b.date.compareTo(a.date)));
    },
    loading: (value) => value,
    error: (value) => value,
  );
});
