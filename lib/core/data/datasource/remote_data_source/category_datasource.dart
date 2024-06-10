import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:up_todo/core/data/models/category_model.dart';

class CategoryDatasource {
  
  Stream getListofCategories() {
    return FirebaseFirestore.instance.collection("Categories").snapshots();
  }

  Future<void> addNewTask(CategoryModel category) async {
   DocumentReference taskRef =
        await FirebaseFirestore.instance.collection("Categories").add({
          'name' : category.name, 
          'color' : category.color, 
          'icon' : category.icon,
    });

    print('New task added with task id: ${taskRef.id}');
  }

}
