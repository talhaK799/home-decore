import 'package:f2_base_project/ui/screens/auth_signup/login/login_screen.dart';
import 'package:f2_base_project/ui/screens/auth_signup/signup/signup_screen.dart';
import 'package:f2_base_project/ui/screens/cart-and-payment-section/cart_screen.dart';
import 'package:f2_base_project/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'ui/screens/root/root_screen.dart';

class Rooter {
  static Route<dynamic> generateRoute(RouteSettings sitting) {
    switch (sitting.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case 'loginScreen':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case 'signupScreen':
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case 'homeScreen':
        return MaterialPageRoute(builder: (_) => RootScreen());
      case 'rootScreen':
        return MaterialPageRoute(builder: (_) => RootScreen());
      case 'productsScreen':
        return MaterialPageRoute(builder: (_) => RootScreen(selectedPage: 1));
      case 'myBookingScreen':
        return MaterialPageRoute(builder: (_) => RootScreen(selectedPage: 2));
      case 'cartScreen':
        return MaterialPageRoute(builder: (_) => CartScreen());
      
      
      case 'categoryDetailScreen':
        return MaterialPageRoute(builder: (_) => RootScreen());
        default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text("No route available ${sitting.name}"),
                  ),
                ));
    }
  }
}
