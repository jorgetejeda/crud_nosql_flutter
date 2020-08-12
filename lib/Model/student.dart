import 'package:flutter/foundation.dart';

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
