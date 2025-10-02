import 'package:chat_messenger_app/features/auth/view/splash_view.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String initialRoute = '/splach';
  static const String login = '/login';
  static const String chat = '/chat';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(builder: (_) => SplashView());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('صفحة غير موجودة: ${settings.name}')),
          ),
        );
    }
  }
}
