// import 'package:bloc_test/bloc_test.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:todo_app/core/error/error.dart';
//
// import 'package:todo_app/features/tasks/data/models/app_task.dart';
// import 'package:todo_app/features/tasks/data/repositories/tasks_repository.dart';
// import 'package:todo_app/features/tasks/view/viewModels/tasks/tasks_view_model.dart';
//
// class MockTaskRepository extends Mock implements TaskRepository {}
//
// void main() {
//   late MockTaskRepository mockRepository;
//   late TasksViewModel tasksViewModel;
//
//   final task1 = AppTask(id: '1', description: 'Task 1', isToday: true, isCompleted: false);
//   final task2 = AppTask(id: '2', description: 'Task 2', isToday: true, isCompleted: true);
//
//   setUp(() {
//     mockRepository = MockTaskRepository();
//     tasksViewModel = TasksViewModel(repository: mockRepository);
//   });
//
//   group('fetchTasks', () {
//     blocTest<TasksViewModel, TasksState>(
//       'emits TasksListState with all tasks when _showCompleted is true',
//       build: () {
//         when(() => mockRepository.getTasks()).thenReturn(Right([task1, task2]));
//         return tasksViewModel;
//       },
//       act: (cubit) => cubit.fetchTasks(),
//       expect:
//           () => [
//             isA<TasksListState>().having((s) => s.tasks, 'tasks', [task1, task2]),
//           ],
//     );
//
//     blocTest<TasksViewModel, TasksState>(
//       'emits TasksEmptyState when getTasks returns empty list',
//       build: () {
//         when(() => mockRepository.getTasks()).thenReturn(Right([]));
//         return tasksViewModel;
//       },
//       act: (cubit) => cubit.fetchTasks(),
//       expect: () => [isA<TasksEmptyState>()],
//     );
//
//     blocTest<TasksViewModel, TasksState>(
//       'emits AllTasksDoneState when _showCompleted is false and all tasks are completed',
//       build: () {
//         when(() => mockRepository.getTasks()).thenReturn(Right([task2]));
//         final viewModel = TasksViewModel(repository: mockRepository);
//         return viewModel;
//       },
//       act: (cubit) => cubit..toggleCompletedTasksVisibility()..fetchTasks(),
//       expect:
//           () => [
//             isA<TasksVisibilityState>().having((s) => s.showCompleted, 'showCompleted', false),
//             isA<AllTasksDoneState>(),
//           ],
//     );
//
//     blocTest<TasksViewModel, TasksState>(
//       'emits TasksListState with only incomplete tasks when _showCompleted is false and tasks exist',
//       build: () {
//         when(() => mockRepository.getTasks()).thenReturn(Right([task1, task2]));
//         final viewModel = TasksViewModel(repository: mockRepository);
//         return viewModel;
//       },
//       act: (cubit) => cubit..toggleCompletedTasksVisibility()..fetchTasks(),
//       expect:
//           () => [
//             isA<TasksVisibilityState>().having((s) => s.showCompleted, 'showCompleted', false),
//             isA<TasksListState>().having((s) => s.tasks, 'tasks', [task1]),
//           ],
//     );
//
//     blocTest<TasksViewModel, TasksState>(
//       'emits TasksErrorState when repository returns Left(Failure)',
//       build: () {
//         when(() => mockRepository.getTasks()).thenReturn(Left(Failure('Storage error')));
//         return tasksViewModel;
//       },
//       act: (cubit) => cubit.fetchTasks(),
//       expect: () => [isA<TasksErrorState>().having((s) => s.errorMessage, 'errorMessage', 'Storage error')],
//     );
//   });
//
//   group('changeTaskStatus', () {
//     final updatedTask = task1.copyWith(isCompleted: true);
//
//     blocTest<TasksViewModel, TasksState>(
//       'emits TaskStatusState when saveTask succeeds',
//       build: () {
//         when(() => mockRepository.saveTask(updatedTask)).thenAnswer((_) async => Right(updatedTask));
//         return tasksViewModel;
//       },
//       act: (cubit) => cubit.changeTaskStatus(task1),
//       expect: () => [isA<TaskStatusState>().having((s) => s.task, 'task', updatedTask)],
//     );
//
//     blocTest<TasksViewModel, TasksState>(
//       'emits TasksErrorState when saveTask fails',
//       build: () {
//         when(() => mockRepository.saveTask(updatedTask)).thenAnswer((_) async => Left(Failure('Write error')));
//         return tasksViewModel;
//       },
//       act: (cubit) => cubit.changeTaskStatus(task1),
//       expect: () => [isA<TasksErrorState>().having((s) => s.errorMessage, 'errorMessage', 'Write error')],
//     );
//   });
//
//   group('toggleCompletedTasksVisibility', () {
//     blocTest<TasksViewModel, TasksState>(
//       'toggles _showCompleted and emits TasksVisibilityState with new value',
//       build: () => tasksViewModel,
//       act: (cubit) => cubit.toggleCompletedTasksVisibility(),
//       expect: () => [isA<TasksVisibilityState>().having((s) => s.showCompleted, 'showCompleted', false)],
//     );
//   });
// }
