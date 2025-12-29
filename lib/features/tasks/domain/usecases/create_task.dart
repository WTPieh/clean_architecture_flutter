import 'package:clean_architecture_flutter/core/erorrs/failures.dart';

import '../entities/task.dart';
import '../repositories/task_repository.dart';

class CreateTaskUseCase {
  final TaskRepository repository;

  const CreateTaskUseCase(this.repository);

  Future<Task> execute(String title, String description, bool isDone) async {
    if (title.trim().isEmpty) {
      throw const ValidationError("Title cannot be empty.");
    }

    if (title.length > 100) {
      throw const ValidationError("Title too long (max 100 characters)");
    }

    return await repository.createTask(title, description, isDone);
  }
}
