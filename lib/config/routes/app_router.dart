import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wasalny/features/splash/presentaion/screens/splash_screen.dart';
import 'package:wasalny/features/user/presentaion/cubit/user/user_cubit.dart';

import '../../core/utils/app_strings.dart';
import '../../features/maps/presentation/cubit/maps/maps_cubit.dart';
import '../../features/maps/presentation/screens/home_screen.dart';
import '../../features/maps/presentation/screens/search_screen.dart';
import '../../features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import '../../features/on_boarding/presentation/screens/on_boarding_screen.dart';
import '../../features/user/presentaion/cubit/phone_auth/phone_auth_cubit.dart';
import '../../injection.dart' as di;
import '../../features/user/presentaion/screens/otp_screen.dart';
import '../../features/user/presentaion/screens/profile.dart';
import '../../features/user/presentaion/screens/login_screen.dart';
import 'app_routes.dart';

class AppRouter {
  static PhoneAuthCubit phoneAuthCubit = di.instance<PhoneAuthCubit>();
  static UserCubit userCubit = di.instance<UserCubit>();
  static MapsCubit mapsCubit = di.instance<MapsCubit>();

  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashScreenRoute:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider<PhoneAuthCubit>.value(
                      value: phoneAuthCubit,
                    ),
                    BlocProvider<UserCubit>.value(
                      value: userCubit,
                    ),
                  ],
                  child: SplashScreen(),
                ));

      case Routes.searchScreenRoute:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider<MapsCubit>.value(
                    value: mapsCubit,
                  ),
                ], child: SearchScreen()));

      case Routes.onBoardingScreenRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<OnBoardingCubit>(
                create: (BuildContext context) => OnBoardingCubit(),
                child: OnBoardingScreen()));

      case Routes.homeScreenRoute:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider<PhoneAuthCubit>.value(value: phoneAuthCubit),
                  BlocProvider<UserCubit>.value(value: userCubit),
                  BlocProvider<MapsCubit>.value(
                    value: mapsCubit..getCurrentPlaceAddress(),
                  ),
                ], child: HomeScreen()));

      case Routes.profileScreenRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<UserCubit>.value(
                  value: userCubit,
                  child: ProfileScreen(),
                ));

      case Routes.loginScreenRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit,
            child: LoginScreen(),
          ),
        );

      case Routes.otpScreenRoute:
        final phoneNumber = routeSettings.arguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit,
            child: OtpScreen(phoneNumber: phoneNumber),
          ),
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
