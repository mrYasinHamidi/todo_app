import 'package:flutter_bloc/flutter_bloc.dart';

part 'tasks_state.dart';

class TasksViewModel extends Cubit<TasksState> {
  TasksViewModel() : super(const TasksInitialState());
}
