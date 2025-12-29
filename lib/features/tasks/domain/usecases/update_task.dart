import '../entities/task.dart';
import '../repositories/task_repository.dart';

class UpdateTaskUseCase {
  final TaskRepository repository;

  const UpdateTaskUseCase(this.repository);

  Future<Task> execute(Task task) async {
    return await repository.updateTask(task);
  }
}
