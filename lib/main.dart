import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_cubit/cubit.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/log_in/log_in_screen.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

import 'shared/components/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  late Widget homeScreen;
  bool? isOnBoardingSkipped = CacheHelper.getData(key: 'onBoardingSkipped');
  token = CacheHelper.getData(key: 'token');
  isOnBoardingSkipped ??= false;
  if (isOnBoardingSkipped) {
    if (token != null) {
      homeScreen = HomeLayout();
    } else {
      homeScreen = LogInScreen();
    }
  } else {
    homeScreen = OnBoardingScreen();
  }
  runApp(MyApp(homeScreen));
}

class MyApp extends StatelessWidget {
  final Widget homeScreen;
  MyApp(this.homeScreen);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()..getHomeData()..getCategoriesData()..getFavorites()..getUserData())
      ],
      child: MaterialApp(
        home: homeScreen,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: defaultColor,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              titleTextStyle: TextStyle(color: Colors.black, fontSize: 24.0),
              elevation: 0.0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
              iconTheme: IconThemeData(color: defaultColor)),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              selectedItemColor: defaultColor,
              unselectedItemColor: Colors.black38,
              elevation: 30.0),
        ),
      ),
    );
  }
}
