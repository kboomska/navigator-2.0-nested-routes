import 'package:flutter/material.dart';

import 'package:navigation_2_0_nested_routers/router/book_route_path.dart';

class BookRouteInformationParser extends RouteInformationParser<BookRoutePath> {
  @override
  Future<BookRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '');

    if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'settings') {
      return BooksSettingsPath();
    } else {
      if (uri.pathSegments.length >= 2) {
        if (uri.pathSegments[0] == 'book') {
          return BooksDetailsPath(int.tryParse(uri.pathSegments[1]));
        }
      }
      return BooksListPath();
    }
  }

  @override
  RouteInformation restoreRouteInformation(BookRoutePath configuration) {
    if (configuration is BooksListPath) {
      return const RouteInformation(location: '/home');
    }
    if (configuration is BooksSettingsPath) {
      return const RouteInformation(location: '/settings');
    }
    if (configuration is BooksDetailsPath) {
      return RouteInformation(location: '/book/${configuration.id}');
    }
    return const RouteInformation();
  }
}
