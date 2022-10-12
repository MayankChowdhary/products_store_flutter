import 'package:android_lyrics_player/utils/constants/ScreenArguments.dart';
import 'package:flutter/material.dart';

import '../../ui/screens/homescreen_screen/home_screen.dart';
import '../../utils/constants/strings.dart';
import '../../core/exceptions/route_exception.dart';

class AppRouter {
  AppRouter();

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments as ScreenArguments;

    switch (settings.name) {
      case Strings.homeScreenRoute:
        return MaterialPageRoute(
            builder: (_) => ProductListScreen(
                ));
      default:
        throw const RouteException('Route not found!');
    }
  }
}
