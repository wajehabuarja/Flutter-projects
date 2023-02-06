import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'science',
    ),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) getSports();
    if (index == 2) getScience();
    emit(NewsBottomNavState());
  }

  List<Widget> screens = const [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  //business
  List<dynamic> business = [];

  void getBusiness() {
    emit(NewGetBusniessLoadingState());
//   https://newsapi.org/v2/top-headlines?q=
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '74205e539b644468bebe19d8879c4a41',
      },
    ).then((value) {
      business = value.data['articles'];
      // print(business[0]['title']);
      emit(NewGetBusniessSuccessState());
    }).catchError((error) {
      print('$error.toString()');
      emit(NewGetBusniessErrorState(error.toString()));
    });
  }

  //sports
  List<dynamic> sports = [];

  void getSports() {
    emit(NewGetSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '74205e539b644468bebe19d8879c4a41',
        },
      ).then((value) {
        sports = value.data['articles'];
        // print(sports[0]['title']);
        log(sports[0]['title']);
        emit(NewGetSportsSuccessState());
      }).catchError((error) {
        print('$error.toString()');
        emit(NewGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewGetSportsSuccessState());
    }
  }

  //science
  List<dynamic> science = [];

  void getScience() {
    emit(NewGetScienceLoadingState());

    if (science.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '74205e539b644468bebe19d8879c4a41',
        },
      ).then((value) {
        science = value.data['articles'];
        // print(science[0]['title']);
        emit(NewGetScienceSuccessState());
      }).catchError((error) {
        print('$error.toString()');
        emit(NewGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewGetScienceSuccessState());
    }
  }

//search
  List<dynamic> search = [];

  void getSearch(value) {
    emit(NewGetScienceLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': '74205e539b644468bebe19d8879c4a41',
      },
    ).then((value) {
      search = value.data['articles'];
      // print(search[0]['title']);
      emit(NewGetSearchSuccessState());
    }).catchError((error) {
      print('$error.toString()');
      emit(NewGetSearchErrorState(error.toString()));
    });
  }
}
