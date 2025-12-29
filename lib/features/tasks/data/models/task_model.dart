import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/task.dart';

class TaskModel extends Task {
  const TaskModel(
      {required super.id,
      required super.title,
      required super.description,
      required super.isDone,
      required super.createdAt});

  // From JSON (Firebase)
  factory TaskModel.fromJson(Map<String, dynamic> json, String id) {
    return TaskModel(
      id: id,
      title: json['title'] as String,
      description: json['description'] ?? "",
      isDone: json['isDone'] as bool,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  ///
  /// {
  ///   "id": "123456890",
  ///   "title": "Some title",
  ///   "isDone": fasle,
  ///   "createdAt": "2025-09-07"
  /// }
  ///
  ///

  // To JSON (Firebase)
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isDone': isDone,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory TaskModel.fromEntity(Task task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      isDone: task.isDone,
      createdAt: task.createdAt,
    );
  }
}
