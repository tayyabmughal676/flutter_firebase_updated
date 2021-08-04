import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class DataModel extends ChangeNotifier {
  String? id;
  String? name;
  String? title;

  DataModel({this.id, this.name, this.title});

  DataModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        title = json['title'];

  Map<String, dynamic> toJSONMap() => {"Name": name, "Title": title};

// CollectionReference _fbData = FirebaseFirestore.instance.collection("data");
// addDataToFirestore() {
//   Map<String, dynamic> addData = {
//     "Name": name,
//     "Title": title,
//   };
//
//   _fbData
//       .add(addData)
//       .then((value) => print(value))
//       .catchError((onError) => print(onError.toString()))
//       .whenComplete(() {
//     print("Completed");
//   });
//
//   notifyListeners();
// }
//
// removeDataFromFirestore(String? id) {
//   _fbData
//       .doc(id)
//       .delete()
//       .then((value) => print("Item Deleted"))
//       .catchError(
//           (onError) => print("Failed to delete item ${onError.toString()}"))
//       .whenComplete(() => print("Completed"));
//
//   notifyListeners();
// }
//
// updateDataFromFirestore(String? id, String? name, String? title) {
//   Map<String, dynamic> updateData = {
//     "Name": name,
//     "Title": title,
//   };
//   _fbData
//       .doc(id)
//       .update(updateData)
//       .then((value) => print("Updated: $updateData"))
//       .catchError((onError) => print("Error: ${onError.toString()}"));
//   notifyListeners();
// }
}
