import 'package:flutter/material.dart';
import 'package:wasalny/presentation/screens/login_screen.dart';
import 'package:wasalny/presentation/screens/otp_screen.dart';

import 'constants/strings.dart';
import 'presentation/screens/main_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
    case otpScreen:
        return MaterialPageRoute(builder: (_) => OtpScreen());
    }
  }
}
