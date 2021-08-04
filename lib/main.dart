import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/DataModel.dart';
import 'package:flutter_firebase/routes/MyRoutes.dart';
import 'package:flutter_firebase/viewmodels/services/ProviderViewModel.dart';
import 'package:flutter_firebase/views/screens/TransactionScreen.dart';
import 'package:flutter_firebase/views/screens/main_screens/StartScreen.dart';
import 'package:flutter_firebase/views/screens/ui_screens/AddDataScreen.dart';
import 'package:flutter_firebase/views/screens/ui_screens/LoadDataScreen.dart';
import 'package:flutter_firebase/views/screens/ui_screens/UpdateDataScreen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<DataModel>(create: (context) => DataModel()),
    ChangeNotifierProvider<ProviderViewModel>(
        create: (context) => ProviderViewModel())
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      routes: {
        '/': (context) => StartScreen(),
        MyRoutes.loadDataScreenRoute: (context) => HomeScreen(),
        MyRoutes.addDataScreenRoute: (context) => AddDataScreen(),
        MyRoutes.updateDataScreenRoute: (context) => UpdateDataScreen(),
        MyRoutes.transcationDataScreenRoute: (context) => TransactionScreen()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CollectionReference _fbData = FirebaseFirestore.instance.collection("data");

  String name = "";
  String title = "";

  Future<void> submitValues() async {
    Map<String, dynamic> demoData = {"Name": name, "Title": title};

    _fbData
        .add(demoData)
        .then((value) => print("Added"))
        .catchError((onError) => print("Error: ${onError.toString()}"));

    print("Name is: $name, Title is: $title");
  }

  Future<void> getValues() async {
    _fbData.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print("Original name is: ${doc['Name']}");
        print(doc['Title']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) {
                name = value.toString();
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Name',
                  hintText: 'Enter Name'),
            ),
            SizedBox(
              height: 12.0,
            ),
            TextField(
              onChanged: (value) {
                title = value.toString();
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Title',
                  hintText: 'Enter Title'),
            ),
            SizedBox(
              height: 12.0,
            ),
            OutlinedButton(
              onPressed: () {
                submitValues();
              },
              child: Text("Submit"),
            ),
            SizedBox(
              height: 12.0,
            ),
            OutlinedButton(
                onPressed: () {
                  getValues();
                  print("Loading...");
                },
                child: Text("Load Data"))
          ],
        ),
      ),
    );
  }
}
