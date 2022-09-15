import 'package:flutter/material.dart';
import 'package:shop_app/modules/log_in/log_in_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

String? token;

void signOut(BuildContext context){
  CacheHelper.removeData(key: 'token').then((value){
    navigateToAndFinish(context, LogInScreen());
  });
}