import 'package:flutter/material.dart';
import 'package:rentcar/pages/loginpage.dart'; // Sesuaikan import Anda

// 1. Buat variabel global ini di luar class MyApp
// Ini berguna agar bisa dipanggil dari ProfilePage
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. Bungkus MaterialApp dengan ValueListenableBuilder
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Rental Car App',

          // 3. Atur Tema Terang (Light)
          theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFF8FAFC),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // 4. Atur Tema Gelap (Dark)
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: const Color(0xFF1E3C72),
            scaffoldBackgroundColor: const Color(
              0xFF121212,
            ), // Warna background gelap
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.white),
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Penyesuaian warna kartu di mode gelap
            cardColor: const Color(0xFF1E1E1E),
          ),

          // 5. Gunakan mode yang sedang aktif
          themeMode: currentMode,

          home: const LoginPage(), // Atau halaman awal Anda
        );
      },
    );
  }
}
