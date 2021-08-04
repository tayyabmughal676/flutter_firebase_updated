import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase/models/DataModel.dart';

class ProviderViewModel extends ChangeNotifier {
  CollectionReference _fbData = FirebaseFirestore.instance.collection("data");

  WriteBatch batch = FirebaseFirestore.instance.batch();

  addDataToFirestore(String? name, String? title) {
    DataModel dataModel = DataModel(name: name, title: title);
    print("DataModel: ${dataModel.name},");

    _fbData
        .add(dataModel.toJSONMap())
        .then((value) => print("value is: ${value.toString()}"))
        .catchError((onError) => print("${onError.toString()}"))
        .whenComplete(() => print("Completed"));

    batch.commit();

    // _fbData
    //     .add(dataModel.toJSONMap())
    //     .then((value) => print(value))
    //     .catchError((onError) => print(onError.toString()))
    //     .whenComplete(() {
    //   print("Completed");
    // });

    notifyListeners();
  }

  removeDataFromFirestore(String? id) {
    DocumentReference refRun =
        FirebaseFirestore.instance.collection("data").doc(id);

    FirebaseFirestore.instance
        .runTransaction((transaction) async {
          DocumentSnapshot snapshot = await transaction.get(refRun);

          if (!snapshot.exists) {
            throw Exception('Data not exist');
          }
          transaction.delete(refRun);
        })
        .then((value) => print("value: $value"))
        .catchError((error) => print("Failed to update user followers: $error"))
        .whenComplete(() => print("Completed"));

    // _fbData
    //     .doc(id)
    //     .delete()
    //     .then((value) => print("Item Deleted"))
    //     .catchError(
    //         (onError) => print("Failed to delete item ${onError.toString()}"))
    //     .whenComplete(() => print("Completed"));

    notifyListeners();
  }

  Future<void> updateDataFromFirestore(
      String? id, String? name, String? title) async {
    DocumentReference refRun =
        FirebaseFirestore.instance.collection("data").doc(id);

    DataModel dataModel = DataModel(name: name, title: title);
    print("DataModel: ${dataModel.name},");

    FirebaseFirestore.instance
        .runTransaction((transaction) async {
          DocumentSnapshot snapshot = await transaction.get(refRun);

          if (!snapshot.exists) {
            throw Exception('Data not exist');
          }
          transaction.update(refRun, dataModel.toJSONMap());
        })
        .then((value) => print("value: $value"))
        .catchError((error) => print("Failed to update user followers: $error"))
        .whenComplete(() => print("Completed"));

    // _fbData
    //     .doc(id)
    //     .update(dataModel.toJSONMap())
    //     .then((value) => print("Updated: ${dataModel.name}"))
    //     .catchError((onError) => print("Error: ${onError.toString()}"))
    //     .whenComplete(() => print("Completed"));

    notifyListeners();
  }
}
