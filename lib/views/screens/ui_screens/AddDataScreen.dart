import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/DataModel.dart';
import 'package:flutter_firebase/viewmodels/services/ProviderViewModel.dart';
import 'package:provider/provider.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({Key? key}) : super(key: key);

  @override
  _AddDataScreenState createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  // Future<void> submitValues() async {
  //   Map<String, dynamic> demoData = {"Name": name, "Title": title};
  //   _fbData
  //       .add(demoData)
  //       .then((value) => print("Added"))
  //       .catchError((onError) => print("Error: ${onError.toString()}"));
  //
  //   print("Name is: $name, Title is: $title");
  // }

  // Future<void> getValues() async {
  //   _fbData.get().then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       print("Original name is: ${doc['Name']}");
  //       print(doc['Title']);
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final myDataModel = Provider.of<DataModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Consumer<DataModel>(
              builder: (context, provider, child) {
                return TextField(
                  onChanged: (value) {
                    provider.name = value.toString();
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Name',
                      hintText: 'Enter Name'),
                );
              },
            ),
            SizedBox(
              height: 12.0,
            ),
            Consumer<DataModel>(
              builder: (context, provider, child) {
                return TextFormField(
                  onChanged: (value) {
                    provider.title = value.toString();
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Title',
                      hintText: 'Enter Title'),
                );
              },
            ),
            SizedBox(
              height: 12.0,
            ),
            Consumer<ProviderViewModel>(
              builder: (context, provider, child) {
                return OutlinedButton(
                  onPressed: () {
                    provider.addDataToFirestore(
                        myDataModel.name, myDataModel.title);
                    m();
                  },
                  child: Text("Submit"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget m() {
  return Center(
    child: CircularProgressIndicator(),
  );
}
