import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  DocumentReference refRun =
      FirebaseFirestore.instance.collection('data').doc("BWtClYS4su7GlTWpLsqc");

  CollectionReference refBatch = FirebaseFirestore.instance.collection('batch');

  @override
  void initState() {
    // runTrans();
    runBatch();
    super.initState();
  }

  Future<void> runBatch() async {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    Map<String, dynamic> data = {"name": "batch write"};

    refBatch.add(data).whenComplete(() => print("Completed"));

    refBatch.get().then((querySnapshot) {
      querySnapshot.docs.forEach((document) {
        // batch.delete(document.reference);
        // batch.set(document.reference, data);
      });
    });

    batch.commit();
  }

  Future<void> runTrans() async {
    FirebaseFirestore.instance
        .runTransaction((transaction) async {
          DocumentSnapshot snapshot = await transaction.get(refRun);

          if (!snapshot.exists) {
            throw Exception('Data not exist');
          }

          // String nameRun = snapshot.data()!['Name'] + "Run";
          String nameRun = snapshot['Name'] + "Run";
          String titleRun = snapshot['Title'] + "Run";

          transaction.update(refRun, {'Name': nameRun, 'Title': titleRun});

          print("nameRun: $nameRun, titleRun: $titleRun");
        })
        .then((value) => print("value: $value"))
        .catchError((error) => print("Failed to update user followers: $error"))
        .whenComplete(() => print("Completed"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transactions"),
      ),
      body: Container(
        child: Center(
          child: Text("Transaction"),
        ),
      ),
    );
  }
}
