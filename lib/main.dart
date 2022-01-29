import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:News_App/layout/newsLayout.dart';
import 'package:News_App/shared/bloc_Observer.dart';
import 'package:News_App/shared/network/local/cache_helper.dart';
import 'package:News_App/shared/network/remote/dio_Helper.dart';
import 'package:News_App/shared/styles/themes.dart';
import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //make all run befor runApp

  DioHelper.init();
  await CasheHelper.init();
  late var isDark = CasheHelper.getBool(key: 'isDark');
 // print ("from shared $isDark");

  // var len = foo?.length ?? 0;
  BlocOverrides.runZoned(() {
      runApp(MyApp(isDark ?? false));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  bool isDark = false;
  MyApp(this.isDark);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()
      // ..changDarkMode(isDark)
       ..getBusinessData()
       ..getSportsData()
       ..getHealthData(),

      child: BlocConsumer<NewsCubit, NewsStetes>(
          listener: (context, state) {},
          builder: (context, state) {
            NewsCubit cubit = NewsCubit.get(context);
            return MaterialApp(
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home: Directionality(
                  textDirection: TextDirection.rtl, child: NewsLayout()),
            );
          }),
    );
  }
}
