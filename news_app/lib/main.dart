import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/shared/appcubit/appcubit.dart';
import 'package:news_app/shared/appcubit/appstates.dart';
import 'package:news_app/shared/bloc_observer%20.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  runApp(NewsApp(isDark!));
}

class NewsApp extends StatelessWidget {
  //  NewsApp({super.key});

  final bool isDark;
  NewsApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..getBusiness()),
        BlocProvider(
          create: (BuildContext context) =>
              AppCubit()..changeAppMode(fromShared: isDark),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            //Light mode
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.red,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                titleSpacing: 20,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark),
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.redAccent,
                unselectedItemColor: Colors.grey,
                elevation: 20,
                backgroundColor: Colors.white,
              ),
            ),
            //Dark mode
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.red,
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme: AppBarTheme(
                titleSpacing: 20,
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('333739'),
                    statusBarIconBrightness: Brightness.light),
                backgroundColor: HexColor('333739'),
                elevation: 0,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.redAccent,
                unselectedItemColor: Colors.grey,
                elevation: 20,
                backgroundColor: HexColor('333739'),
              ),
              // textTheme:  TextTheme(
              //   bodyText1: TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.w500,
              //     // color: Colors.white,
              //   ),
              // ),
            ),
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: NewsLayout(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
