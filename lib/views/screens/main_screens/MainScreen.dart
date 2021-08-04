import 'package:flutter/material.dart';
import 'package:flutter_firebase/routes/MyRoutes.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello, Firestore"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Let's do Something Different!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(
              height: 12.0,
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, MyRoutes.addDataScreenRoute);
              },
              child: Text("Add Data"),
            ),
            SizedBox(
              height: 12.0,
            ),
            OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, MyRoutes.loadDataScreenRoute);
                },
                child: Text("Load Data")),
            SizedBox(
              height: 12.0,
            ),
            OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, MyRoutes.transcationDataScreenRoute);
                },
                child: Text("Transaction"))
          ],
        ),
      ),
    );
  }
}
