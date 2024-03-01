import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

//class CrudMethods {
// Future<void> addData(blogData) async{
//  CollectionReference blogs = Firestore.instance.collection('blogs');
// Firestore.instance.collection("blog").add(blogData).catchError(e){
//  print(e);
//  });
// }


class CrudMethods {
  final CollectionReference _blogsCollectionReference =
      FirebaseFirestore.instance.collection('blogs');

  Future<void> addData(Map<String, dynamic> blogData) async {
    try {
      await _blogsCollectionReference.add(blogData);
      print('Data added successfully');
    } catch (e) {
      print('Error adding data: $e');
    }
  }

  getData()  async{
    return await FirebaseFirestore.instance.collection('blogs').getDocuments();
  }
}
