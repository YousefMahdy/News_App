import 'package:News_App/layout/cubit/cubit.dart';
import 'package:News_App/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../lang/lang.dart';
import '../network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = CasheHelper.getBool(key: 'isDark') ?? false;
  int current_index = 0;
  void changDarkMode() {
    isDark = !isDark;
    print('value  is $isDark');
    CasheHelper.setBool(key: "isDark", value: isDark).then((value) {
      print('value to insert $value');
      print('value  is $isDark');
      print(CasheHelper.getBool(key: 'isDark'));
      emit(ChangeDarkModeState());
    }).catchError((e) {
      //print(e.toString());
    });
  }

  Map<String, String> textsAr = {
    //"category_title":["أخبارالاعمال","رياضـة","صحـه","تكنولوجيا"],
    // "category_name":["أخبارالاعمال","رياضـة","صحـه","تكنولوجيا"],
    "category_title1": "اعمال",
    "category_title2": "رياضـة",
    "category_title3": "صحـه",
    "category_title4": "تكنولوجيا",
    "category_name1": "اعمال",
    "category_name2": "رياضـة",
    "category_name3": "صحـه",
    "category_name4": "تكنولوجيا",
    "search": "بحـث"
  };
  Map<String, String> textsEn = {
    // "category_title":["Business","Sports","Health","Technology"],
    // "category_name":["Business","Sports","Health","Technology"],

    "category_title1": "Business",
    "category_title2": "Sports",
    "category_title3": "Health",
    "category_title4": "Technology",
    "category_name1": "Business",
    "category_name2": "Sports",
    "category_name3": "Health",
    "category_name4": "Technology",
    "search": "Search"
  };

  bool isEn = CasheHelper.getBool(key: 'isEn') ?? true;
  //category[0]="";
  changIndex(index) {
    current_index = index;
    //  print(getTexts("category_title"));
    emit(ChangBottomNavigatorBar());
  }

  void changLang() {
    isEn = !isEn;
    //print(titles.length) ;
    CasheHelper.setBool(key: "isEn", value: isEn).then((value) {
      print('value to insert is $isEn   ');
      // current_Title();
      emit(ChangeLangState());
    }).catchError((e) {
      print(e);
    });
  }

  String current_Title() {
    List<String> titles = [
      getTexts('category_title1'),
      getTexts('category_title2'),
      getTexts('category_title3'),
      getTexts('category_title4')
    ];
    return titles[current_index];
  }

  String getTexts(String txt) {
    if (isEn == true) return textsEn[txt]!;
    return textsAr[txt]!;
  }
}
