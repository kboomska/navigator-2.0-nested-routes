import 'package:flutter/material.dart';

import 'package:navigation_2_0_nested_routers/model/book.dart';
import 'package:navigation_2_0_nested_routers/router/book_route_path.dart';
import 'package:navigation_2_0_nested_routers/util/fade_animation_page.dart';
import 'package:navigation_2_0_nested_routers/widget/book_lists_screen.dart';
import 'package:navigation_2_0_nested_routers/widget/books_app_state.dart';
import 'package:navigation_2_0_nested_routers/widget/bool_details_screen.dart';
import 'package:navigation_2_0_nested_routers/widget/settings_screen.dart';

class InnerRouterDelegate extends RouterDelegate<BookRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  BooksAppState get appState => _appState;
  BooksAppState _appState;
  set appState(BooksAppState value) {
    if (value == _appState) {
      return;
    }
    _appState = value;
    notifyListeners();
  }

  InnerRouterDelegate(this._appState);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (appState.selectedIndex == 0) ...[
          FadeAnimationPage(
            child: BooksListScreen(
              books: appState.books,
              onTapped: _handleBookTapped,
            ),
            key: const ValueKey('BooksListPage'),
          ),
          if (appState.selectedBook != null)
            MaterialPage(
              key: ValueKey(appState.selectedBook),
              child: BookDetailsScreen(book: appState.selectedBook!),
            ),
        ] else
          const FadeAnimationPage(
            child: SettingsScreen(),
            key: ValueKey('SettingsPage'),
          ),
      ],
      onPopPage: (route, result) {
        appState.selectedBook = null;
        notifyListeners();
        return route.didPop(result);
      },
    );
  }

  @override
  Future<void> setNewRoutePath(BookRoutePath configuration) async {
    // This is not required for inner router delegate because it does not
    // parse route
    assert(false);
  }

  void _handleBookTapped(Book book) {
    appState.selectedBook = book;
    notifyListeners();
  }
}
