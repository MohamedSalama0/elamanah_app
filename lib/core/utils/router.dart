import 'package:farm_project/src/presentation/auth/signin/signin_screen.dart';
import 'package:farm_project/src/presentation/splash/splash_screen.dart';
import 'package:flutter/material.dart';
class RoutesHelper {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();
  static Route generateRoute(
    RouteSettings settings,
  ) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) {
        switch (settings.name) {
          case SignInScreen.routeName:
            return const SignInScreen();
          default:
            return const SplashScreen();
        }
      },
    );
  }
}

// void pushNamedAndRemoveUntil(  context, route, {arguments}) {
//   Navigator.of(context).pushNamedAndRemoveUntil(route, ModalRoute.withName('/'),
//       arguments: arguments);
// }

void pushNamedAndRemoveUntil(context, route, {arguments}) {
  Navigator.pushNamedAndRemoveUntil(
    context,
    route,
    arguments: arguments,
    (Route<dynamic> route) => false,
  );
}

void pushNamed(context, route, {arguments, bool rootNavigator = true}) {
  Navigator.of(context, rootNavigator: rootNavigator).pushNamed(
    route,
    arguments: arguments,
  );

}
   Future<void> push(BuildContext context, Widget widget) {
    return Navigator.push(context, MaterialPageRoute(builder: (_)=>widget));
  }