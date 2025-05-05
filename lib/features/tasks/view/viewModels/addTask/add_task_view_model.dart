import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/tasks/data/repositories/tasks_repository.dart';

part 'add_task_state.dart';

class AddTaskViewModel extends Cubit<AddTaskState> {
  final TaskRepository _repository;

  AddTaskViewModel({required TaskRepository repository}) : _repository = repository, super(AddTaskInitialState());

}
