import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:News_App/shared/components/components.dart';

import '../layout/cubit/cubit.dart';
import '../layout/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStetes>(
      listener: (context, stste) {},
      builder: (context, stste) {
        List<dynamic> searches = NewsCubit.get(context).searchArticles;
        return Scaffold(
          appBar: AppBar(
            title: Text("search"),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                    controler: searchController,
                    validat: (s) {},
                    keyboardType: TextInputType.text,
                    labelText: "search",
                    prefexIcon: Icons.search_outlined,
                    onChange: (value) {
                      NewsCubit.get(context).getSearchData(value);
                    }),
              ),
              Expanded(
                  child: articleBuilder(searches,isSearch: true)),

            ],
          ),
        );
      },
    );
  }
}
