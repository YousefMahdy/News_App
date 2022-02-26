import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:News_App/shared/components/components.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';

class TechnologyScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder:  (context,state){
        List<dynamic> technologyArticles=NewsCubit.get(context).technologyArticles;
        return articleBuilder(technologyArticles);

      },

    );

  }
}
