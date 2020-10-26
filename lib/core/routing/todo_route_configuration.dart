import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class TodoRoutePath extends Equatable {
  final Object arguments;
  final String pathName;

  TodoRoutePath({this.pathName, this.arguments});

  bool get isHomePage => pathName == '/';

  bool get isAddTodoPage => pathName == '/addTodo';

  bool get isTodosPage => pathName == '/todos';

  bool get isTodoPage => pathName == '/todo';

  bool get isUnknown => pathName == null;

  @override
  List<Object> get props => [arguments, pathName];
}
