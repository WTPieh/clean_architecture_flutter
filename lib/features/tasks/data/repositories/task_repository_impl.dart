import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_remote_datasource.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;

  const TaskRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Task>> getTasks() async {
    return await remoteDataSource.getTasks();
  }

  @override
  Future<Task> createTask(String title, String description, bool isDone) async {
    return await remoteDataSource.createTask(title, description, isDone);
  }

  @override
  Future<Task> updateTask(Task task) async {
    final taskModel = TaskModel.fromEntity(task);
    return await remoteDataSource.updateTask(taskModel);
  }

  @override
  Future<void> deleteTask(String id) async {
    return await remoteDataSource.deleteTask(id);
  }
}
