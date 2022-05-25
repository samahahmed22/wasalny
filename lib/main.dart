import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasalny/styles/themes.dart';
import 'app_router.dart';
import 'bloc_observer.dart';
import '/shared/variables.dart';
import '/shared/constants.dart';
import 'helpers/cache_helper.dart';

late String initialRoute;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();
  
  // userId = CacheHelper.getData(key: 'userId');
  // if (userId != null) {
  //   initialRoute = homeScreen;
  // } else {
  //   initialRoute = onBoardingScreen;
  // }
  // print('>>>>>>>>>>>>>>>>>>>>>>>>>>>');
  // print(userId);

  FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user == null) {
      initialRoute = onBoardingScreen;
    } else {
      userId = user.uid;
      initialRoute = firstScreen;
    }
  });

  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
      initialRoute: initialRoute,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}
