// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps
class Student extends DataClass implements Insertable<Student> {
  final int id;
  final String name;
  final String course;
  Student({@required this.id, @required this.name, @required this.course});
  factory Student.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Student(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      course:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}course']),
    );
  }
  factory Student.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Student(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      course: serializer.fromJson<String>(json['course']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'course': serializer.toJson<String>(course),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Student>>(bool nullToAbsent) {
    return StudentsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      course:
          course == null && nullToAbsent ? const Value.absent() : Value(course),
    ) as T;
  }

  Student copyWith({int id, String name, String course}) => Student(
        id: id ?? this.id,
        name: name ?? this.name,
        course: course ?? this.course,
      );
  @override
  String toString() {
    return (StringBuffer('Student(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('course: $course')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(name.hashCode, course.hashCode)));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Student &&
          other.id == id &&
          other.name == name &&
          other.course == course);
}

class StudentsCompanion extends UpdateCompanion<Student> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> course;
  const StudentsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.course = const Value.absent(),
  });
  StudentsCompanion copyWith(
      {Value<int> id, Value<String> name, Value<String> course}) {
    return StudentsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      course: course ?? this.course,
    );
  }
}

class $StudentsTable extends Students with TableInfo<$StudentsTable, Student> {
  final GeneratedDatabase _db;
  final String _alias;
  $StudentsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _courseMeta = const VerificationMeta('course');
  GeneratedTextColumn _course;
  @override
  GeneratedTextColumn get course => _course ??= _constructCourse();
  GeneratedTextColumn _constructCourse() {
    return GeneratedTextColumn('course', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, course];
  @override
  $StudentsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'students';
  @override
  final String actualTableName = 'students';
  @override
  VerificationContext validateIntegrity(StudentsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.course.present) {
      context.handle(
          _courseMeta, course.isAcceptableValue(d.course.value, _courseMeta));
    } else if (course.isRequired && isInserting) {
      context.missing(_courseMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Student map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Student.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(StudentsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.course.present) {
      map['course'] = Variable<String, StringType>(d.course.value);
    }
    return map;
  }

  @override
  $StudentsTable createAlias(String alias) {
    return $StudentsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(const SqlTypeSystem.withDefaults(), e);
  $StudentsTable _students;
  $StudentsTable get students => _students ??= $StudentsTable(this);
  @override
  List<TableInfo> get allTables => [students];
}
