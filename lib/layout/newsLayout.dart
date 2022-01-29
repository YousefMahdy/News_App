import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:News_App/modules/searchsScreen.dart';
import 'package:News_App/shared/components/components.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class NewsLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStetes>(
      listener: (context,state){},
      builder:(context,state){
        NewsCubit cubit =NewsCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text("news Screen",),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context,SearchScreen());
                  },
                  icon:  Icon(
                    Icons.search_outlined

                  )),
              IconButton(
                  onPressed: (){
                    cubit.changDarkMode(!cubit.isDark);
                    },
                  icon:  Icon(
                      Icons.brightness_4_outlined

                  ))
            ],
          ),
          body:cubit.screens[cubit.current_index],

          bottomNavigationBar: BottomNavigationBar(
            items: cubit.navBarItem,
            // backgroundColor: Colors.black,
            type: BottomNavigationBarType.fixed,

            elevation: 15,
             selectedItemColor: Colors.deepOrange,


             currentIndex: cubit.current_index,
            onTap: (index){
             cubit.changIndex(index);
            },

          )
        );
      } ,

    );
  }
}
