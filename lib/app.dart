import 'package:flutter/material.dart';

import 'config/routes/app_router.dart';
import 'config/routes/app_routes.dart';
import 'config/styles/app_theme.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute:  Routes.splashScreenRoute ,
      theme: appTheme(),
    );
  }
}
