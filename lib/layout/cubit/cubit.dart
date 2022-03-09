import 'package:News_App/modules/technologyScreen/technologyScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:News_App/layout/cubit/states.dart';
import 'package:News_App/shared/network/remote/dio_Helper.dart';
import '../../modules/HealthScreen/HealthScreen.dart';
import '../../modules/businessScreen/businessScreen.dart';
import '../../modules/sportsScreen/sportScreen.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int current_index = 0;

  List<Widget> screens = [
    BusinessScreen(),
    SportScreen(),
    HealthScreen(),
    TechnologyScreen()
  ];

  changIndex(index) {
    current_index = index;
    emit(ChangBottomNavigatorBar());
  }

  List<dynamic> businessArticles = [];
  List<dynamic> sportArticles = [];
  List<dynamic> healthArticles = [];
  List<dynamic> technologyArticles = [];
  List<dynamic> searchArticles = [];

  void getBusinessData() {
    DioHelper.getData(path: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '382db3640cc840e788ca380193b096cf'
    }).then((value) {
      // print(value.data['articles'][0]['title']);
      businessArticles = value.data['articles'];
      // print(businessArticles[0]["author"]);
      emit(NewsGetBusinessSuccessState());
    }).catchError((e) {
      print(e);
      emit(NewsGetBusinessErrorState());
    });
  }

  void getSportsData() {
    DioHelper.getData(path: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'sports',
      'apiKey': '382db3640cc840e788ca380193b096cf'
    }).then((value) {
      //print(value.data['articles'][0]['title']);
      sportArticles = value.data['articles'];

      emit(NewsGetSportsSuccessState());
    }).catchError((e) {
      // print(' error $e ');
      emit(NewsGetSportsErrorState());
    });
  }

  void getHealthData() {
    DioHelper.getData(path: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'health',
      'apiKey': '382db3640cc840e788ca380193b096cf'
    }).then((value) {
      healthArticles = value.data['articles'];

      emit(NewsGetHealthSuccessState());
    }).catchError((e) {
      // print(e);
      emit(NewsGetHealthErrorState());
    });
  }

  void getTechnologyData() {
    DioHelper.getData(path: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'technology',
      'apiKey': '382db3640cc840e788ca380193b096cf'
    }).then((value) {
      technologyArticles = value.data['articles'];

      emit(NewsGetTechnologySuccessState());
    }).catchError((e) {
      // print(e);
      emit(NewsGetTechnologyErrorState());
    });
  }

  void getSearchData(String value) {
    DioHelper.getData(path: 'v2/everything', query: {
      'q': '$value',
      'apiKey': '382db3640cc840e788ca380193b096cf'
    }).then((value) {
      searchArticles = value.data['articles'];

      emit(NewsGetSearchSuccessState());
    }).catchError((e) {
      emit(NewsGetSearchErrorState());
      print(e);
    });
  }
}
