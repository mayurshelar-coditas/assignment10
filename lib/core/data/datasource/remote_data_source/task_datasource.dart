import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:up_todo/core/data/models/task_model.dart';

class TaskDatasource {
  Future<void> addNewTask(TaskModel task) async {
    DocumentReference taskRef =
        // await FirebaseFirestore.instance.collection('Tasks').add({
        await FirebaseFirestore.instance.collection("Tasks").add({
      'title': task.title,
      'description': task.description,
      'date': task.date,
      'time': task.time,
      'flag': task.flag,
      'category': task.category,
      'color': task.color.toString(),
      'icon': task.icon,
    });

    print('New task added with task id: ${taskRef.id}');
  }

  Stream getListofTask() {
    return FirebaseFirestore.instance.collection("Tasks").snapshots();
  }

  Future<void> updateTask(TaskModel task, String id) async {
    print(id);
    try {
      await FirebaseFirestore.instance.collection('Tasks').doc(id).update({
        'title': task.title,
        'description': task.description,
        'category': task.category,
        'icon': task.icon,
        'flag': task.flag,
        'date': task.date,
        'time': task.time,
      });
      print('Document updated successfully');
    } catch (e) {
      print('Error updating document: $e');
    }
  }

  Future<void> delete(String id) async {
    print(id);
    try {
      await FirebaseFirestore.instance.collection('Tasks').doc(id).delete();
      print('Document deleted successfully');
    } catch (e) {
      print('Error deleting document: $e');
    }
  }
}
