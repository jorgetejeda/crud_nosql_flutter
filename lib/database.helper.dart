import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import 'Model/student.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper db = DatabaseHelper._();
  static Database _database;

  Future<Database> get database async {
    _database ??= await initDB();
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
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('student');
    return List.generate(
        maps.length,
        (index) => Student(
            id: maps[index]['id'],
            name: maps[index]['name'],
            course: maps[index]['course']));
  }

  Future<int> updateStudent(Student student) async {
    final db = await database;
    return await db.update('student', student.toMap(),
        where: "id = ?", whereArgs: [student.id]);
  }

  Future<void> deleteStudent(int id) async {
    final db = await database;
    return await db.delete('student', where: "id = ?", whereArgs: [id]);
  }
}
