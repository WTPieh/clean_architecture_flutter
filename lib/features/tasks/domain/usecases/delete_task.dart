import '../repositories/task_repository.dart';

class DeleteTaskUseCase {
  final TaskRepository repository;

  const DeleteTaskUseCase(this.repository);

  Future<void> execute(String id) async {
    return await repository.deleteTask(id);
  }
}
