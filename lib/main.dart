import 'package:flutter/material.dart';
import 'package:hungry_hour/screens/login.dart';
import 'package:hungry_hour/screens/splash.dart';
import 'package:hungry_hour/screens/homepage.dart';
import 'package:hungry_hour/screens/orderhistory.dart';
import 'package:hungry_hour/screens/profile.dart';
import 'package:hungry_hour/screens/forgotpassword.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crave-Food Delivery',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF8EBD8),
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontFamily: 'GoogleFonts.roboto',
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/Login': (context) => const LoginPage(),
        '/home': (context) => const Homepage(),
        '/orderhistory': (context) => const OrderHistoryPage(),
        '/profile': (context) => const ProfilePage(),
        '/forgot_password': (context) => const ForgotPassword(),
      },
    );
  }
}