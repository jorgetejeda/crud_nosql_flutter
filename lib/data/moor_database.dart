import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

class Students extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get course => text().withLength(min: 1, max: 50)();
}

@UseMoor(tables: [Students])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super((FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
          logStatements: true,
        )));

  @override
  int get schemaVersion => 1;

  Future<List<Student>> getAllStudent() => select(students).get();
  Future insertStudent(Student student) => into(students).insert(student);
  Future updateStudent(Student student) => update(students).replace(student);
  Future deleteStudent(Student student) => delete(students).delete(student);
}
