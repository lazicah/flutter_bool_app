import 'package:flutter/material.dart';
import 'package:flutter_bool_app/screens/add_todo_screen.dart';
import 'package:flutter_bool_app/screens/todo_detials.dart';
import 'package:flutter_bool_app/screens/todos_screen.dart';

import '../../main.dart';

var routes = [
  {
    'path': '/',
  },
  {
    'path': '/addTodo',
  },
  {
    'path': '/todos',
  },
  {
    'path': '/todos/:todoId',
  },
  {
    'path': '/NotFound',
  },
];
