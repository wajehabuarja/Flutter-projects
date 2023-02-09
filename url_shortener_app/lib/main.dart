import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_shortener_app/layout/HomeLayout.dart';
import 'package:url_shortener_app/shared/bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const UrlShortenerApp());
}

class UrlShortenerApp extends StatelessWidget {
  const UrlShortenerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(selectedItemColor: Colors.black),
        brightness: Brightness.light,
        primaryColor: Colors.redAccent,
        scaffoldBackgroundColor: Color.fromARGB(255, 253, 239, 239),
        appBarTheme: const AppBarTheme(
          titleSpacing: 20,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.black,
              statusBarIconBrightness: Brightness.light),
          backgroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      themeMode: ThemeMode.light,
      home: const HomeLayout(),
      debugShowCheckedModeBanner: false,
    );
  }
}
