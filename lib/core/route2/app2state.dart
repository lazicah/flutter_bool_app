import 'package:flutter/cupertino.dart';

import '../todo_model.dart';

class App2State extends ChangeNotifier {
  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  addTodo(Todo newTodo) {
    _todos.add(newTodo);
    notifyListeners();
  }

  deleteTodo(Todo todo) {
    _todos.removeWhere((element) => element.id == todo.id);
    notifyListeners();
  }

  Todo todoById(int id) {
    bool hasId = false;
    _todos.forEach((element) {
      if (element.id == id) {
        hasId = true;
        return;
      }
    });
    if (hasId) {
      return _todos.singleWhere((element) => element.id == id);
    }
    return null;
  }
}
