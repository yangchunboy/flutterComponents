import 'package:app/pages/tools/toolsPage.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/home/HomePage.dart';
import 'package:app/pages/login/loginPage.dart';
import 'package:app/pages/search/SearchPage.dart';
import 'package:app/pages/delete/DeletePage.dart';
import 'package:app/pages/refresh/RefreshPage.dart';


class Router {
  static Map routes = {
    '/': (params) => HomePage(),
    '/search': (params) => SearchPage(),
    '/tools': (params) => ToolsPage(),
    '/login': (params) => LoginPage(),
    '/delete': (params) => DeletePage(),
    '/refresh': (params) => RefreshPage()
  };

  static onGenerateRoute(RouteSettings settings) {
          // If you push the PassArguments route
    if (routes[settings.name] != null) {
      // Cast the arguments to the correct type: ScreenArguments.
      final params = settings.arguments as Map<String, dynamic>;
      // print(params);

      // Then, extract the required data from the arguments and
      // pass the data to the correct screen.
      return MaterialPageRoute(
        builder: (context) {
          return routes[settings.name](params);
        },
      );
    }
  }
}
