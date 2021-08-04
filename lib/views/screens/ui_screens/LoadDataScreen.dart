import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/DataModel.dart';
import 'package:flutter_firebase/routes/MyRoutes.dart';
import 'package:flutter_firebase/viewmodels/services/ProviderViewModel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('data').snapshots();

  late DataModel myModel;
  late ProviderViewModel myProviderViewModel;

  @override
  Widget build(BuildContext context) {
    myModel = Provider.of<DataModel>(context, listen: false);
    myProviderViewModel =
        Provider.of<ProviderViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Data Loading..."),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: StreamBuilder(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  String id = document.id;
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;

                  // print("Firestore: ${document.id}");

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        print("Current: $id");
                        Navigator.pushNamed(
                            context, MyRoutes.updateDataScreenRoute,
                            arguments: DataModel(
                                id: id,
                                name: data['Name'],
                                title: data['Title']));
                      },
                      child: Container(
                        height: 75.0,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Center(
                                child: Text(
                                  "${data['Name']}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              SizedBox(width: 20.0),
                              Center(
                                child: Text(
                                  "${data['Title']}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    // provider.removeDataFromFirestore(id);
                                    showAlertDialog(context, id);
                                  },
                                  child: Icon(
                                    Icons.auto_delete_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                  // );
                }).toList(),
              );
            }),
      ),
    );
  }

  showAlertDialog(BuildContext context, String id) {
    // Create button
    Widget okButton = OutlinedButton(
      child: Text("Yes"),
      onPressed: () {
        Navigator.of(context).pop();
        myProviderViewModel.removeDataFromFirestore(id);
      },
    );

    Widget noButton = OutlinedButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Are you sure?"),
      content: Text("You are going to delete current item!"),
      actions: [okButton, noButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
