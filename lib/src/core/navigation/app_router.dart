import 'package:flutter/material.dart';

import '../../presentation/features/catDetails/cat_details_screen.dart';
import '../../presentation/features/catsList/cats_list_screen.dart';
import '../../presentation/features/splashscreen/splash_screen.dart';
import '../core.dart';

class AppRouter {
  static RouteFactory get generatedRoutes => (RouteSettings settings) {
        ModalRoute? route;

        // ignore: unused_local_variable
        var argumentsMap = settings.arguments as Map<String, dynamic>?;

        switch (settings.name) {
          case NamedRoute.initial:
            route = MaterialPageRoute(
              builder: (_) => const SplashScreen(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
            break;
            case NamedRoute.catsList:
            route = MaterialPageRoute(
              builder: (_) => const CatsListScreen(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
            break;
          case NamedRoute.catDetails:
            route = MaterialPageRoute(
              builder: (_) => CatDetailsScreen(
                cat: argumentsMap!['catDetails'],
              ),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
            break;
        }

        return route;
      };
}
