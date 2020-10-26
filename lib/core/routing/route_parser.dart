import 'package:flutter/material.dart';
import 'package:flutter_bool_app/core/routing/app_route.dart';
import 'dart:core';
import 'package:flutter_bool_app/core/routing/todo_route_configuration.dart';

class TodoRouteInfoParser extends RouteInformationParser<TodoRoutePath> {
  @override
  Future<TodoRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);
    if (uri.pathSegments.isEmpty) {
      return TodoRoutePath(pathName: '/');
    }
    var knownRoute = _matchUrlToRoute(uri) ?? null;
    if (knownRoute.route == null) {
      return TodoRoutePath();
    }
    if (knownRoute.params != null) {
      print(knownRoute.params);
    }
    print('known route ${knownRoute.route}');
    print(knownRoute.route.entries.first.value);
    switch (knownRoute.route.entries.first.value) {
      case '/addTodo':
        return TodoRoutePath(pathName: knownRoute.route.entries.first.value);
      case '/todos':
        return TodoRoutePath(pathName: knownRoute.route.entries.first.value);
      default:
        return TodoRoutePath();
    }
  }

  @override
  RouteInformation restoreRouteInformation(TodoRoutePath configuration) {
    print('restored config ${configuration.pathName}');
    if (configuration.isUnknown) {
      return RouteInformation(location: '/NotFound');
    }

    if (configuration.isHomePage) {
      return RouteInformation(location: '/');
    }

    if (configuration.isTodosPage) {
      return RouteInformation(location: '/todos');
    }

    if (configuration.isAddTodoPage) {
      return RouteInformation(location: '/addTodo');
    }

    return null;
  }

  MatchedRoute _matchUrlToRoute(Uri uri) {
    var routeParams = {};

    // Try and match the URL to a route.
    var matchedRoute = routes.firstWhere((route) {
      var pathSegments =
          route.entries.first.value.toString().split('/').sublist(1);
      print('pathSegments $pathSegments');
      print('uriSegments ${uri.pathSegments}');

      // If there are different numbers of segments, then the route does not match the URL.
      if (pathSegments.length != uri.pathSegments.length) {
        return false;
      }

      // If each segment in the url matches the corresponding route path,
      // then the route is matched.
      bool match = pathSegments.every((segment) {
        int index = pathSegments.indexOf(segment);
        return segment == uri.pathSegments[index];
      });

      if (match && uri.hasQuery) {
        uri.queryParameters.forEach((key, value) {
          print('key: $key  and Value $value');
          routeParams.addAll({'$key': '$value'});
        });
      }

      return match;
    }, orElse: () {
      return null;
    });

    return MatchedRoute(route: matchedRoute, params: routeParams);
  }
}

class MatchedRoute {
  final Map<String, String> route;
  final Map<dynamic, dynamic> params;

  MatchedRoute({this.route, this.params});
}
