import 'package:flutter/cupertino.dart';
import 'package:flutter_bool_app/core/app_state.dart';
import 'package:flutter_bool_app/core/routing/todo_route_configuration.dart';
import 'package:provider/provider.dart';

class TodoRouterDelegate extends RouterDelegate<TodoRoutePath>
    with PopNavigatorRouterDelegateMixin<TodoRoutePath>, ChangeNotifier {
  final TodoAppState appState = TodoAppState();

  TodoRouterDelegate() {
    appState.addListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoAppState>.value(
      value: appState,
      child: Consumer<TodoAppState>(
        builder: (context, pageManager, child) {
          return Navigator(
            key: navigatorKey,
            onPopPage: _onPopPage,
            pages: List.of(pageManager.pages),
          );
        },
      ),
    );
  }

  @override
  TodoRoutePath get currentConfiguration => appState.currentPath;

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(TodoRoutePath configuration) {
    appState.setNewRoutePath(configuration);
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    Page page = route.settings;
    print('about to Pop ${page.name}');
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }

    /// Notify the PageManager that page was popped
    //appState.didPop(route.settings);

    return true;
  }
}
