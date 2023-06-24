import 'package:flutter/material.dart';

import '../../presentation/features/catsList/cats_list_screen.dart';
import '../core.dart';

class AppRouter {
  static RouteFactory get generatedRoutes => (RouteSettings settings) {
        ModalRoute? route;

        // ignore: unused_local_variable
        var argumentsMap = settings.arguments as Map<String, dynamic>?;

        switch (settings.name) {
          case NamedRoute.catAppHome:
            route = MaterialPageRoute(
              builder: (_) => const CatsListScreen(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
            break;
        }

        return route;
      };
}
