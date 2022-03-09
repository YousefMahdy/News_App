

import 'package:dio/dio.dart';

class DioHelper{
  static late  Dio dio  ;

  static init () {
    dio = Dio(BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true

    ));
  }
    static Future < Response<dynamic>>getData({
     required String path,
      required Map<String,dynamic> query
    }) async {
     return await dio.get(path,queryParameters: query);

    }

   // void getHttp() async {
   //   try {
   //     var response = await Dio().get('http://www.google.com');
   //     print(response);
   //   } catch (e) {
   //     print(e);
   //   }
   // }
}