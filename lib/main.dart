import 'package:flutter/material.dart';
import 'Model/student.dart';
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
  final _nameController = TextEditingController();
  final _courseController = TextEditingController();
  final _formKey = new GlobalKey<FormState>();
  Student student;
  int updateIndex;
  List<Student> studentList;

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
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    decoration: new InputDecoration(labelText: 'Nombre'),
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
                      }),
                  FutureBuilder(
                    future: DatabaseHelper.db.getStudentList(),
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                        studentList = snapShot.data;
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                studentList == null ? 0 : studentList.length,
                            itemBuilder: (BuildContext context, int index) {
                              Student st = studentList[index];
                              return Card(
                                child: Row(
                                  children: [
                                    Container(
                                      width: width * 0.6,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Nombre: ${st.name}',
                                              style: TextStyle(fontSize: 15)),
                                          Text('Curso: ${st.course}',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54)),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.blueAccent,
                                        ),
                                        onPressed: () {
                                          _nameController.text = st.name;
                                          _courseController.text = st.course;
                                          student = st;
                                          updateIndex = index;
                                        }),
                                    IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          DatabaseHelper.db
                                              .deleteStudent(st.id);

                                          setState(() {
                                            studentList.removeAt(index);
                                          });
                                        })
                                  ],
                                ),
                              );
                            });
                      }
                      return new CircularProgressIndicator();
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _submitStudent(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      if (student == null) {
        Student st = new Student(
            name: _nameController.text, course: _courseController.text);
        await DatabaseHelper.db
            .insertStudent(st)
            .then((id) => {
                  _nameController.clear(),
                  _courseController.clear(),
                  print('Se ha agregado el estudiante ${id}')
                })
            .catchError((onError) => {print(onError)});
      } else {
        student.name = _nameController.text;
        student.course = _courseController.text;
        await DatabaseHelper.db.updateStudent(student).then((id) => {
              setState(() {
                studentList[updateIndex].name = _nameController.text;
                studentList[updateIndex].course = _courseController.text;
              }),
              _nameController.clear(),
              _courseController.clear(),
              student = null,
            });
      }
    }
  }
}
