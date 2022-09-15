import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_cubit/cubit.dart';
import 'package:shop_app/layout/home_cubit/states.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class HomeLayout extends StatelessWidget {
  static var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){

      },
      builder: (context,state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            title: const Text('EShop'),
            actions: [
              IconButton(onPressed: (){
                navigateTo(context, SearchScreen());
              }, icon:const Icon(Icons.search))
            ],
        ),
          body: cubit.bottomNavScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap:(index){
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.category),label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Wish List'),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
          ]),
      );
      },
    );
  }
}
