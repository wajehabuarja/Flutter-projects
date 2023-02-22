import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/on_boarding/on_boarding.dart';
import 'package:shop_app/modules/login/shop_login.dart';
import 'package:shop_app/shared/bloc_observer%20.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/local/chache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);

  if (onBoarding != null) {
    if (token != null) {
      widget = HomeLayout();
    } else {
      widget = ShopLogin();
    }
  } else {
    widget = OnBoardingScreen();
  }

  runApp(ShopApp(
    StartWidget: widget,
  ));
}

class ShopApp extends StatelessWidget {
  // final bool? onBoarding;
  final Widget? StartWidget;
  ShopApp({this.StartWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavorites(),
        ),
      ],
      child: MaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        // themeMode: ,
        home: StartWidget,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
