import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_model.dart';

abstract class TaskRemoteDataSource {
  Future<List<TaskModel>> getTasks();
  Future<TaskModel> createTask(String title, String description, bool isDone);
  Future<TaskModel> updateTask(TaskModel task);
  Future<void> deleteTask(String id);
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final FirebaseFirestore firestore;

  const TaskRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<TaskModel>> getTasks() async {
    try {
      final snapshot = await firestore
          .collection('tasks')
          .orderBy('createdAt', descending: true)
          .get();

      final data = snapshot.docs
          .map((doc) => TaskModel.fromJson(doc.data(), doc.id))
          .toList();
      print(data);

      return snapshot.docs
          .map((doc) => TaskModel.fromJson(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print("Get Tasks: ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<TaskModel> createTask(
      String title, String description, bool isDone) async {
    try {
      final colRef = firestore.collection("tasks");
      final docRef = colRef.doc();
      final id = docRef.id;

      await docRef.set({
        'id': id,
        'title': title,
        'description': description,
        'isDone': false,
        'createdAt': Timestamp.now()
      });

      final doc = await docRef.get();
      return TaskModel.fromJson(doc.data()!, id);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<TaskModel> updateTask(TaskModel task) async {
    await firestore.collection('tasks').doc(task.id).update(task.toJson());

    final doc = await firestore.collection('tasks').doc(task.id).get();
    return TaskModel.fromJson(doc.data()!, doc.id);
  }

  @override
  Future<void> deleteTask(String id) async {
    await firestore.collection('tasks').doc(id).delete();
  }
}
