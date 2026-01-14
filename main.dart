import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/auth/auth.dart';
import 'package:socialmedia/auth/login_or_register.dart';
import 'package:socialmedia/pages/home_page.dart';
import 'package:socialmedia/pages/profile_page.dart';
import 'package:socialmedia/pages/setting_page.dart';
import 'package:socialmedia/pages/users_page.dart';
import 'package:socialmedia/theme/dark_mode.dart';
import 'package:socialmedia/theme/light_mode.dart';
import 'package:socialmedia/theme/theme_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,

      // ✅ FIX: use provider
      themeMode: themeProvider.themeMode,

      routes: {
        '/login_or_register': (context) => const LoginOrRegister(),
        '/home_page': (context) => HomePage(),
        '/profile_page': (context) => ProfilePage(),
        '/user_page': (context) => const UsersPage(),
        '/setting_page': (context) => const SettingsPage(),
      },
    );
  }
}

