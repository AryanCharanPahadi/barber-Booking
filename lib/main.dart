import 'package:barber_project/admin/admin_login.dart';
import 'package:barber_project/home_screen/home_screen.dart';
import 'package:barber_project/login_signup/random_page.dart';
import 'package:barber_project/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'booking/booking.dart';
import 'booking/booking_admin.dart';
import 'login_signup/forgot_password.dart';
import 'login_signup/login_page.dart';
import 'login_signup/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreenWrapper(),
    );
  }
}

class SplashScreenWrapper extends StatefulWidget {
  const SplashScreenWrapper({super.key});

  @override
  State<SplashScreenWrapper> createState() => _SplashScreenWrapperState();
}

class _SplashScreenWrapperState extends State<SplashScreenWrapper> {
  @override
  void initState() {
    super.initState();
    // After splash screen, navigate to the auth state check
    Future.delayed(const Duration(seconds: 2), () {
      // Check user authentication state after splash screen
      _checkAuthState();
    });
  }

  void _checkAuthState() async {
    User? user = FirebaseAuth.instance.currentUser;

    // Navigate to HomeScreen if the user is logged in, else show the LogIn screen
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RandomPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashScreen(), // Show splash screen during the delay
    );
  }
}
