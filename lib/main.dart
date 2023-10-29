import 'package:flutter/material.dart';

import 'package:navigation_2_0_nested_routers/router/book_route_information_parser.dart';
import 'package:navigation_2_0_nested_routers/router/book_router_delegate.dart';

void main() {
  runApp(const NestedRouterDemo());
}

class NestedRouterDemo extends StatefulWidget {
  const NestedRouterDemo({super.key});

  @override
  State<NestedRouterDemo> createState() => _NestedRouterDemoState();
}

class _NestedRouterDemoState extends State<NestedRouterDemo> {
  final BookRouterDelegate _routerDelegate = BookRouterDelegate();
  final BookRouteInformationParser _routeInformationParser =
      BookRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Books App',
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}
