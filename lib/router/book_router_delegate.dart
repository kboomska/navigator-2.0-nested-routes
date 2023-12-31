import 'package:flutter/material.dart';

import 'package:navigation_2_0_nested_routers/router/book_route_path.dart';
import 'package:navigation_2_0_nested_routers/widget/app_shell.dart';
import 'package:navigation_2_0_nested_routers/widget/books_app_state.dart';

class BookRouterDelegate extends RouterDelegate<BookRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  BooksAppState appState = BooksAppState();

  BookRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    appState.addListener(notifyListeners);
  }

  @override
  BookRoutePath get currentConfiguration {
    if (appState.selectedIndex == 1) {
      return BooksSettingsPath();
    } else {
      if (appState.selectedBook == null) {
        return BooksListPath();
      } else {
        return BooksDetailsPath(appState.getSelectedBookById());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          child: AppShell(appState: appState),
        ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        if (appState.selectedBook != null) {
          appState.selectedBook = null;
        }
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(BookRoutePath configuration) async {
    if (configuration is BooksListPath) {
      appState.selectedIndex = 0;
      appState.selectedBook = null;
    } else if (configuration is BooksSettingsPath) {
      appState.selectedIndex = 1;
    } else if (configuration is BooksDetailsPath && configuration.id != null) {
      appState.setSelectedBookById(configuration.id!);
    }
  }
}
