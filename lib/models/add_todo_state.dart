class AddTodoState {
  final String body;
  final Object? error;
  final bool hasSubmitted;
  late final bool canSubmit = body.isNotEmpty;

  AddTodoState(this.body, this.error, this.hasSubmitted);
}
