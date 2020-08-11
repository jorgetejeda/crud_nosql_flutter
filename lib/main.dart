import 'package:flutter/material.dart';
import 'database.helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DatabaseHelper databaseHelper = new DatabaseHelper();
  final _nameController = TextEditingController();
  final _courseController = TextEditingController();
  final _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sqllite CRUD'),
      ),
      body: ListView(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: new InputDecoration(labelText: 'Name'),
                    controller: _nameController,
                    validator: (val) =>
                        val.isNotEmpty ? null : 'Nombre no debe estar vacio',
                  ),
                  TextFormField(
                    decoration: new InputDecoration(labelText: 'Curso'),
                    controller: _courseController,
                    validator: (val) =>
                        val.isNotEmpty ? null : 'Curso no debe estar vacio',
                  ),
                  RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blueAccent,
                      child: Container(
                          width: width,
                          child: Text(
                            'Guardar',
                            textAlign: TextAlign.center,
                          )),
                      onPressed: () {
                        _submitStudent(context);
                      })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _submitStudent(BuildContext context) {}
}
