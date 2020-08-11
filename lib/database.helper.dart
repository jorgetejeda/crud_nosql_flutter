import 'dart:async';
import 'dart:ffi';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Database _database;

  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(
          join(await getDatabasesPath(), "student.db"),
          version: 1,
          onCreate: (Database db, int version) async => await db.execute(
              "CREATE TABLE student (id INTEGER PRIMARYKEY autoincrement, name TEXT, course TEXT)"));
    }
  }

  Future<int> insertStudent(Student student) async {
    await openDb();
    return await _database.insert("student", student.toMap());
  }

  Future<List<Student>> getStudentList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('student');
    return List.generate(
        maps.length,
        (index) => Student(
            id: maps[index]['id'],
            name: maps[index]['name'],
            course: maps[index]['course']));
  }

  Future<int> updateStudent(Student student) async {
    await openDb();
    return await _database.update('student', student.toMap(),
        where: "id = ?", whereArgs: [student.id]);
  }

  Future<void> deleteStudent(Student student) async {
    await openDb();
    await _database.delete('student', where: "id = ?", whereArgs: [student.id]);
  }
}

class Student {
  int id;
  String name;
  String course;

  Student({@required this.name, @required this.course, this.id});
  Map<String, dynamic> toMap() => {
        'name': name,
        'course': course,
      };
}
