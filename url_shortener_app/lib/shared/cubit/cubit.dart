import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_shortener_app/Links.dart';
import 'package:url_shortener_app/modules/history.dart';
import 'package:url_shortener_app/modules/home.dart';
import 'package:url_shortener_app/shared/cubit/states.dart';

class Appcubit extends Cubit<AppStates> {
  Appcubit() : super(AppInitialState());
  static Appcubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = const [
    BottomNavigationBarItem(
      icon: Icon(
        Ionicons.home_outline,
        color: Colors.black,
      ),
      label: 'Home',
      activeIcon: Icon(
        Ionicons.home,
        color: Colors.black,
      ),
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.history,
        color: Colors.black,
      ),
      label: 'History',
    ),
  ];

  List<Widget> screens = [
    Home(
      links: [],
    ),
    History(
      links: [],
    ),
  ];

  List<String> titles = const [
    'Url Shortener App',
    'History',
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(BottomNavState());
  }

  void copyToClipboard(String url) async {
    final data = ClipboardData(text: url);
    await Clipboard.setData(data);
    emit(CopyToClipboardState());
  }

  List<Links> links = [];
}
