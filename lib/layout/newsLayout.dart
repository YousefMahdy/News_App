import 'package:News_App/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:News_App/modules/searchsScreen.dart';
import 'package:News_App/shared/components/components.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class NewsLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder:(context,state){
        NewsCubit cubit =NewsCubit.get(context);

        return Scaffold(
          appBar: AppBar(

            leading: IconButton(

                onPressed: (){
                 // AppCubit.get(context).changLang();
                AppCubit.get(context).changLang();
                //  print(cubit.getTexts('category_title1'));
                 //print(cubit.isEn);
                },
                icon:  Icon(
                    Icons.language_outlined

                )),
            title: Text(
                AppCubit.get(context).current_Title().toString()),



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
                    AppCubit.get(context).changDarkMode();
                    },
                  icon:  Icon(
                      Icons.brightness_4_outlined

                  ))
            ],
          ),
          body:cubit.screens[cubit.current_index],

          bottomNavigationBar: BottomNavigationBar(
           // items: cubit.navBarItem,
            // backgroundColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            elevation: 15,
             selectedItemColor: Colors.deepOrange,
             currentIndex: cubit.current_index,
            onTap: (index){

             cubit.changIndex(index);
             AppCubit.get(context).changIndex(index);

            },
            items: [
              BottomNavigationBarItem(
              icon: Icon(
                Icons.business_outlined,
              ),
              label:AppCubit.get(context).getTexts('category_name1').toString(),
            ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.sports_volleyball_outlined,
                ),
                label: AppCubit.get(context).getTexts('category_name2').toString(),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.health_and_safety_outlined,
                ),
                label: AppCubit.get(context).getTexts('category_name3').toString(),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.computer_outlined,
                ),
                label: AppCubit.get(context).getTexts('category_name4').toString(),
              ),],

          )
        );
      } ,

    );
  }
}
