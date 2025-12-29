import 'package:clean_architecture_flutter/core/erorrs/failures.dart';
import 'package:clean_architecture_flutter/features/tasks/domain/usecases/create_task.dart';
import 'package:clean_architecture_flutter/features/tasks/domain/usecases/get_tasks.dart';
import 'package:flutter/foundation.dart';
import '../../domain/entities/task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task>? _tasks = [];
  List<Task>? get tasks => _tasks;
  final GetTasksUseCase _getTasks;
  final CreateTaskUseCase _createTask;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  TaskProvider(this._getTasks, this._createTask) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    _error = null;
    _isLoading = true;
    notifyListeners();

    try {
      _tasks = await _getTasks.execute();
      notifyListeners();
    } catch (e) {
      if (e is ServerFailure) {
        _error = e.message;
      } else {
        _error = "Unexpected Error, try again.";
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createTask(String title,
      {String description = "", bool isDone = false}) async {
    _error = null;
    notifyListeners();

    try {
      final task = await _createTask.execute(title, description, isDone);

      _tasks?.add(task);
    } catch (e) {
      if (e is Failure) {
        _error = e.message;
      } else {
        _error = "There was an unexpected errror: ${e.toString()}";
      }
    } finally {
      notifyListeners();
    }
  }
}
