import 'package:News_App/shared/bloc_Observer.dart';
import 'package:News_App/shared/network/local/cache_helper.dart';
import 'package:News_App/shared/network/remote/dio_Helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout/cubit/cubit.dart';
import 'layout/newsLayout.dart';
import 'shared/cubit/cubit.dart';
import 'shared/cubit/states.dart';
import 'shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //make all run befor runApp

  DioHelper.init();
  await CasheHelper.init();
  late var isDark = CasheHelper.getBool(key: 'isDark');
  print(isDark );
  late var isEn = CasheHelper.getBool(key: 'isEn');
  // print ("from shared $isDark");
  BlocOverrides.runZoned(
    () {
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  bool isDark = false;
  MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (BuildContext context) => AppCubit()
        //   ..changDarkMode(isDark)
      ),
      BlocProvider(
      create: (BuildContext context) => NewsCubit()
        ..getBusinessData()
        ..getSportsData()
        ..getHealthData()
        ..getTechnologyData())
    ],
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            AppCubit cubit = AppCubit.get(context);
            return MaterialApp(
              theme: lightTheme,
              darkTheme: darkTheme,

              themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
              debugShowCheckedModeBanner: false,

              home: Directionality(
                  textDirection:cubit.isEn?TextDirection.ltr: TextDirection.rtl, child: NewsLayout()),
            );
          }),
    );
  }
}
