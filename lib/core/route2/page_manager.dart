import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bool_app/core/route2/app2state.dart';
import 'package:flutter_bool_app/core/route2/view_routes.dart';
import 'package:flutter_bool_app/screens/add_todo_screen.dart';
import 'package:flutter_bool_app/screens/todo_detials.dart';
import 'package:flutter_bool_app/screens/todos_screen.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class PageManager extends App2State {
  static PageManager of(BuildContext context) =>
      Provider.of<PageManager>(context, listen: false);

  List<Page> _pages = [
    MaterialPage(
      name: ViewRoutes.home,
      key: ValueKey<String>('home'),
      child: MyHomePage(),
    ),
  ];
  List<Page> get pages => List.unmodifiable(_pages);

  List<RouteSettings> _configuration = [];

  get configuration => _configuration ?? [RouteSettings(name: ViewRoutes.home)];

  void didPop(Page page) {
    print('calleddd pooooooooooooop');
    _pages.remove(page);
    notifyListeners();
  }

  Future<void> setNewRoutePath(List<RouteSettings> configuration) async {
    if (configuration == null) return;
    //print('setNew config ${configuration?.single?.name}');
    if (configuration.isEmpty) {
      // Don't do anything if the route is invalid.
      return;
    }
    var routeName = configuration?.single?.name ?? ViewRoutes.unknown;
    print('set routname $routeName');
    if (routeName == ViewRoutes.unknown) {
      if (_pages.last.name == configuration.single.name) _pages.removeLast();
      _pages.add(MaterialPage(
        key: ValueKey<String>('unknown'),
        name: ViewRoutes.unknown,
        child: Scaffold(
          body: Center(
            child: Text('Not Found'),
          ),
        ),
      ));
    } else if (routeName == ViewRoutes.home) {
      _pages.clear();
      _pages.add(
        MaterialPage(
          name: ViewRoutes.home,
          key: ValueKey<String>('home'),
          child: MyHomePage(),
        ),
      );
    } else if (routeName == ViewRoutes.todos) {
      if (_pages.last.name == configuration.single.name) _pages.removeLast();
      _pages.add(
        MaterialPage(
          name: ViewRoutes.todos,
          key: ValueKey<String>('todos'),
          child: TodosScreen(),
        ),
      );
    } else if (routeName == ViewRoutes.addTodo) {
      if (_pages.last.name == configuration.single.name) _pages.removeLast();

      _pages.add(
        MaterialPage(
          name: ViewRoutes.addTodo,
          key: ValueKey<String>('addTodo'),
          child: AddTodoScreen(),
        ),
      );
    } else if (routeName == ViewRoutes.todo) {
      if (_pages.last.name == configuration.single.name) _pages.removeLast();
      if (configuration.single.arguments == null) return null;
      var arguments = configuration.single.arguments as Map<String, dynamic>;
      int id = int.tryParse(arguments.entries.first.value);
      print('id $id');
      _pages.add(
        MaterialPage(
          name: ViewRoutes.todo,
          key: ValueKey<String>('addTodo'),
          child: TodoDetails(
            todoId: id,
          ),
        ),
      );
    } else {
      _pages.add(
        MaterialPage(
          key: ValueKey<String>('unknown'),
          name: ViewRoutes.unknown,
          child: Scaffold(
            body: Center(
              child: Text('Not Found'),
            ),
          ),
        ),
      );
    }
    print('number of pages ${_pages.length}');
    notifyListeners();
    _configuration = List.of(configuration);
    print('saved configuration $_configuration');
    return;
  }

  goBack() {
    _pages.removeLast();
    notifyListeners();
  }

  goHome() {
    _pages.clear();
    setNewRoutePath([RouteSettings(name: ViewRoutes.home)]);
  }

  openTodos() {
    setNewRoutePath([RouteSettings(name: ViewRoutes.todos)]);
  }

  openTodoDetails(int id) {
    setNewRoutePath([
      RouteSettings(name: ViewRoutes.todo, arguments: {'id': '$id'})
    ]);
  }

  openAddTodo() {
    setNewRoutePath([RouteSettings(name: ViewRoutes.addTodo)]);
  }
}
