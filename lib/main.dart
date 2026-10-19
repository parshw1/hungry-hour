import 'package:flutter/material.dart';
import 'package:hungry_hour/screens/login.dart';
import 'package:hungry_hour/screens/splash.dart';
import 'package:hungry_hour/screens/homepage.dart';
import 'package:hungry_hour/screens/orderhistory.dart';
import 'package:hungry_hour/screens/profile.dart';

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
        primarySwatch: Colors.grey,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/Login': (context) => const LoginPage(),
        '/home': (context) => const Homepage(),
        '/orderhistory': (context) => const OrderHistoryPage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}