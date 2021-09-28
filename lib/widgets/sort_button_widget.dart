import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_app/models/sort_state.dart';
import 'package:riverpod_todo_app/providers/sort_state_provider.dart';

class SortButtonWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final SortState sortState = watch(sortStateProvider);

    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () =>
                context.read(sortStateProvider.notifier).setAsAsc(),
            style: OutlinedButton.styleFrom(
              backgroundColor: sortState.isDesc == false
                  ? Theme.of(context).primaryColor.withOpacity(0.5)
                  : null,
            ),
            child: Text('asc'),
          ),
        ),
        Expanded(
          child: OutlinedButton(
            onPressed: () =>
                context.read(sortStateProvider.notifier).setAsDesc(),
            child: Text('desc'),
            style: OutlinedButton.styleFrom(
              backgroundColor: sortState.isDesc == true
                  ? Theme.of(context).primaryColor.withOpacity(0.5)
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
