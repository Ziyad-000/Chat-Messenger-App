import 'package:chat_messenger_app/features/auth/view/otp_view.dart';
import 'package:chat_messenger_app/features/auth/view/phone_auth.dart';
import 'package:chat_messenger_app/features/auth/view/splash_view.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String initialRoute = '/splach';
  static const String login = '/login';
  static const String phoneAuth = '/phone_auth';
  static const String otp = '/otp';
  static const String chat = '/chat';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(builder: (_) => SplashView());
      case phoneAuth:
        return MaterialPageRoute(builder: (_) => PhoneAuthView());
      case otp:
        final args = settings.arguments as Map<String, dynamic>;
        final verificationId = args['verificationId'] as String;
        final phoneNumber = args['phoneNumber'] as String;
        return MaterialPageRoute(
          builder: (_) =>
              OtpView(verificationId: verificationId, phoneNumber: phoneNumber),
        );
      // ...
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Page not found: ${settings.name}')),
          ),
        );
    }
  }
}
