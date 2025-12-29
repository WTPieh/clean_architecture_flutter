import 'package:clean_architecture_flutter/features/tasks/presentation/provider/tasks_provider.dart';
import 'package:clean_architecture_flutter/shared/extensions/spaced_column.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(builder: (context, provider, widget) {
      if (provider.isLoading) {
        return const CircularProgressIndicator();
      }
      if (provider.error != null) {
        return Text(provider.error!);
      }
      if (provider.tasks == null) {
        return const Text("Loading");
      } else if (provider.tasks!.isEmpty) {
        return const Text("No Tasks to render");
      }
      return Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: provider.tasks?.length,
            itemBuilder: (context, index) {
              return Text(provider.tasks![index].title);
            },
          ),
          FilledButton(
              onPressed: () => _createTaskDialog(context, provider),
              child: const Text("Create New Task"))
        ],
      );
    });
  }
}

void _createTaskDialog(BuildContext context, TaskProvider provider) {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  var isDone = false;
  showDialog(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (context, setDialogState) {
        return AlertDialog(
          title: const Text("Create Task"),
          content: Column(
            children: [
              Container(
                child: [
                  [
                    const Text("Task Name"),
                    TextField(
                      controller: titleController,
                    ),
                  ].spacedColumn(spacing: 0),
                  [
                    const Text("Task Description"),
                    TextField(
                      controller: descriptionController,
                    ),
                  ].spacedColumn(spacing: 0),
                  [
                    const Text("Completed?"),
                    Switch(
                        value: isDone,
                        onChanged: (value) =>
                            setDialogState(() => isDone = value))
                  ].spacedColumn(spacing: 0),
                ].spacedColumn(spacing: 32),
              ),
              [
                FilledButton(
                    onPressed: Navigator.of(ctx).pop,
                    child: const Text("Cancel")),
                FilledButton(
                    onPressed: () async {
                      var title = titleController.text;
                      var description = descriptionController.text;
                      await provider.createTask(title,
                          description: description, isDone: isDone);
                      Navigator.pop(context);
                    },
                    child: const Text("Create Task"))
              ].spacedRow(spacing: 16),
            ],
          ),
        );
      },
    ),
  );
}
