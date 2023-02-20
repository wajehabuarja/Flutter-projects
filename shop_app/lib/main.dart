import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/on_boarding.dart';
import 'package:shop_app/modules/login/shop_login.dart';
import 'package:shop_app/shared/bloc_observer%20.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

void main() {
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(const ShopApp());
}

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      // themeMode: ,
      home: ShopLogin(),
      debugShowCheckedModeBanner: false,
    );
  }
}
