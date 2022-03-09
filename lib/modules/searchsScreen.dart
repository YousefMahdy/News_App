import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:News_App/shared/components/components.dart';

import '../layout/cubit/cubit.dart';
import '../layout/cubit/states.dart';
import '../shared/cubit/cubit.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<dynamic> searches = NewsCubit.get(context).searchArticles;
        return Directionality(
          textDirection: AppCubit.get(context).isEn?TextDirection.ltr: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: Text(AppCubit.get(context).getTexts("search").toString()),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultFormField(
                      controler: searchController,
                      validat: (s) {},
                      keyboardType: TextInputType.text,
                      labelText: AppCubit.get(context).getTexts('search').toString(),
                      prefexIcon: Icons.search_outlined,
                      onChange: (value) {
                        NewsCubit.get(context).getSearchData(value);
                      }),
                ),
                Expanded(
                    child: articleBuilder(searches,isSearch: true)),

              ],
            ),
          ),
        );
      },
    );
  }
}
