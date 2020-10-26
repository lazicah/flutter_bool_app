import 'package:flutter/material.dart';
import 'package:flutter_bool_app/core/routing/todo_route_configuration.dart';
import 'package:flutter_bool_app/core/todo_model.dart';
import 'package:flutter_bool_app/main.dart';
import 'package:flutter_bool_app/screens/add_todo_screen.dart';
import 'package:flutter_bool_app/screens/todos_screen.dart';
import 'package:provider/provider.dart';

class TodoAppState extends ChangeNotifier {
  static TodoAppState of(BuildContext context) {
    return Provider.of<TodoAppState>(context, listen: false);
  }

  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  List<Page> _pages = [
    MaterialPage(
      name: '/',
      child: MyHomePage(),
    ),
  ];
  List<Page> get pages => List.unmodifiable(_pages);

  TodoRoutePath get currentPath {
    print('last page ${_pages.last.name}');
    switch (_pages.last.name) {
      case '/addTodo':
        return TodoRoutePath(pathName: _pages.last.name);
      case '/todos':
        return TodoRoutePath(pathName: _pages.last.name);
      case '/':
        return TodoRoutePath(pathName: _pages.last.name);
      default:
        return TodoRoutePath();
    }
  }

  /// This is where we handle new route information and manage the pages list
  Future<void> setNewRoutePath(TodoRoutePath configuration) async {
    print('passed config ${configuration.pathName}');
    if (configuration.isUnknown) {
      if (_pages.last.name == configuration.pathName) _pages.removeLast();
      _pages.add(
        MaterialPage(
          key: ValueKey<String>('Unknown'),
          name: '/NotFound',
          child: Scaffold(
            body: Center(
              child: Text('Not Found'),
            ),
          ),
        ),
      );
    } else if (configuration.isHomePage) {
      _pages.clear();
      _pages.add(
        MaterialPage(
          child: MyHomePage(),
          name: '/',
          key: ValueKey<String>('Home'),
        ),
      );
    } else if (configuration.isAddTodoPage) {
      if (_pages.last.name == configuration.pathName) _pages.removeLast();
      _pages.add(
        MaterialPage(
          child: AddTodoScreen(),
          name: '/addTodo',
          key: ValueKey<String>('AddTodo'),
        ),
      );
    } else if (configuration.isTodosPage) {
      if (_pages.last.name == configuration.pathName) _pages.removeLast();
      _pages.add(
        MaterialPage(
          child: TodosScreen(),
          name: '/todos',
          key: ValueKey<String>('Todos'),
        ),
      );
    }
    notifyListeners();
    print('PAges ${_pages.length}');
    return;
  }

  didPop(Page page) {
    print('popped ${page.name}');
    _pages.remove(page);
    notifyListeners();
  }

  goBack() {
    _pages.removeLast();
  }

  openTodos() {
    setNewRoutePath(TodoRoutePath(pathName: '/todos'));
  }

  openAddTodo() {
    setNewRoutePath(TodoRoutePath(pathName: '/addTodo'));
  }

  goHome() {
    _pages.clear();
    setNewRoutePath(TodoRoutePath(pathName: '/'));
  }

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
