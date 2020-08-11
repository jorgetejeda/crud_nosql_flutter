import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper db = DatabaseHelper._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return database;
    _database = await initDB();
    return _database;
  }

  Future initDB() async {
    return await openDatabase(join(await getDatabasesPath(), "student.db"),
        version: 1,
        onCreate: (Database db, int version) async => await db.execute('''
              CREATE TABLE Student (
                id integer primary key AUTOINCREMENT, 
                name TEXT, 
                course TEXT)
              '''));
  }

  Future<int> insertStudent(Student student) async {
    final db = await database;
    return await db.insert("student", student.toMap());
  }

  Future<List<Student>> getStudentList() async {
    final List<Map<String, dynamic>> maps = await _database.query('student');
    return List.generate(
        maps.length,
        (index) => Student(
            id: maps[index]['id'],
            name: maps[index]['name'],
            course: maps[index]['course']));
  }

  Future<int> updateStudent(Student student) async =>
      await _database.update('student', student.toMap(),
          where: "id = ?", whereArgs: [student.id]);

  Future<void> deleteStudent(Student student) async => await _database
      .delete('student', where: "id = ?", whereArgs: [student.id]);
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
