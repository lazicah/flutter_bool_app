import 'package:flutter/cupertino.dart';
import 'package:flutter_bool_app/core/route2/view_routes.dart';

class Route2InfoParser extends RouteInformationParser<List<RouteSettings>> {
  @override
  Future<List<RouteSettings>> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);
    var arguments = <String, dynamic>{};
    print('segments ${uri.pathSegments}');
    if (uri.pathSegments.isEmpty) {
      return [RouteSettings(name: ViewRoutes.home)];
    }
    if (uri.hasQuery) {
      uri.queryParameters.forEach((key, value) {
        arguments.addAll({'$key': '$value'});
      });
    }
    switch (uri.pathSegments[0]) {
      case 'todos':
        return [RouteSettings(name: ViewRoutes.todos)];
      case 'addTodo':
        return [RouteSettings(name: ViewRoutes.addTodo)];
      case 'todo':
        return [RouteSettings(name: ViewRoutes.todo, arguments: arguments)];
      default:
        return [RouteSettings(name: ViewRoutes.unknown)];
    }
  }

  @override
  RouteInformation restoreRouteInformation(List<RouteSettings> configuration) {
    print('restore config ${configuration}');
    if (configuration.isEmpty || configuration?.single?.name == '/') {
      // Don't do anything if the route is invalid.
      return RouteInformation(location: ViewRoutes.home);
    }
    var routeName = configuration?.single?.name ?? '';

    switch (routeName) {
      case ViewRoutes.todos:
        return RouteInformation(location: ViewRoutes.todos);
      case ViewRoutes.addTodo:
        return RouteInformation(location: ViewRoutes.addTodo);
      case ViewRoutes.todo:
        if (configuration.single.arguments == null) break;
        var arguments = configuration.single.arguments as Map<String, dynamic>;
        int id = int.tryParse(arguments.entries.first.value);
        return RouteInformation(location: '${ViewRoutes.todo}?id=$id');
      default:
        return RouteInformation(location: ViewRoutes.unknown);
    }
  }
}
