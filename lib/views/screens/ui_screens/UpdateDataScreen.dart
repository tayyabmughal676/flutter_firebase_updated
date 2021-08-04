import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/DataModel.dart';
import 'package:flutter_firebase/viewmodels/services/ProviderViewModel.dart';
import 'package:provider/provider.dart';

class UpdateDataScreen extends StatefulWidget {
  const UpdateDataScreen({Key? key}) : super(key: key);

  @override
  _UpdateDataScreenState createState() => _UpdateDataScreenState();
}

class _UpdateDataScreenState extends State<UpdateDataScreen> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerTitle = TextEditingController();

  String updateName = '';
  String updateTitle = '';
  String updateByID = '';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DataModel;

    print("Current Item: ${args.id}");

    updateByID = args.id!;
    _controllerName.text = args.name!;
    _controllerTitle.text = args.title!;

    return Scaffold(
      appBar: AppBar(
        title: Text("Update Data"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                controller: _controllerName,
                onChanged: (value) {
                  updateName = value.toString();
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Name',
                    hintText: 'Enter Name'),
              ),
              SizedBox(
                height: 12.0,
              ),
              TextFormField(
                controller: _controllerTitle,
                onChanged: (value) {
                  updateTitle = value.toString();
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Name',
                    hintText: 'Enter Name'),
              ),
              SizedBox(
                height: 12.0,
              ),
              Consumer<ProviderViewModel>(
                builder: (context, provider, child) {
                  return OutlinedButton(
                      onPressed: () {
                        provider.updateDataFromFirestore(
                            updateByID, updateName, updateTitle);
                      },
                      child: Text("Update"));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
