import '../entities/task.dart';
import '../repositories/task_repository.dart';

class GetTasksUseCase {
  final TaskRepository repository;

  const GetTasksUseCase(this.repository);

  Future<List<Task>> execute() async {
    return await repository.getTasks();
  }
}
