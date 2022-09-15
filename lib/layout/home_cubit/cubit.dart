import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/update_favorites_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomNavScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];
  bool bottomSheetShown = false;

  void changeBottomSheet(bool show){
    bottomSheetShown = show;
    emit(ChangeBottomSheetState());
  }

  void changeBottom(int index) {
    if(index != 3) {
      changeBottomSheet(false);
    }
    currentIndex = index;
    emit(HomeChangeBottomNavState());
  }

  HomeModel? homeModel;

  Map<int?, bool?> favorites = {};

  void getHomeData() {
    emit(HomeDataLoadingState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data!.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });

      print(token);

      emit(HomeDataSuccessState());
    }).catchError((error) {
      emit(HomeDataErrorState(error));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(url: CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(CategoriesSuccessState());
    }).catchError((error) {
      emit(CategoriesErrorState(error));
    });
  }
  UpdateFavoritesModel? updateFavoritesModel;

  void updateFavorites(int productId) {

    favorites[productId] = !favorites[productId]!;
    emit(ChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {'product_id': productId},
      token: token
    ).then((value){
      updateFavoritesModel = UpdateFavoritesModel.fromJson(value.data);
      if(!updateFavoritesModel!.status){
        favorites[productId] = !favorites[productId]!;
      }else{
        getFavorites();
      }
      emit(UpdateFavoritesSuccessState(updateFavoritesModel));
    }).catchError((error){
      print(error.toString());
      UpdateFavoritesErrorState(error.toString());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites(){
    DioHelper.getData(url: FAVORITES,token: token).then((value){
      emit(GetFavoritesSuccessState());
      favoritesModel =FavoritesModel.fromJson(value.data);
    }).catchError((error){
      emit(GetFavoritesErrorState(error.toString()));
    });
  }

  LogInModel? userModel;

  void getUserData(){
    emit(GetUserDataLoadingState());
    DioHelper.getData(url: PROFILE,token: token).then((value){
      userModel =LogInModel.fromJson(value.data);
      emit(GetUserDataSuccessState(userModel));
    }).catchError((error){
      emit(GetUserDataErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());

  }
  IconData rePasswordSuffix = Icons.visibility_outlined;
  bool isRePassword = true;
  void changeRePasswordVisibility() {
    isRePassword = !isRePassword;
    rePasswordSuffix = isRePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }
  LogInModel? updateUserDataModel;

  void updateUserData(
  {
  String? email,
  String? name,
  String? phone,
  String? password,
}
      ){
    emit(UpdateUserDataLoadingState());
    DioHelper.putData(url: UPDATE_PROFILE,data: {
      'email': email,
      'name':name,
      'phone':phone,
      'password': password
    },token: token).then((value){
      userModel =LogInModel.fromJson(value.data);
      if(userModel!.status){
        showToast(userModel!.message.toString(), ToastStates.SUCCESS);
      }else{
        showToast(userModel!.message.toString(), ToastStates.ERROR);
      }
      emit(UpdateUserDataSuccessState(userModel));
    }).catchError((error){
      emit(UpdateUserDataErrorState(error.toString()));
    });
  }

  LogInModel? updatePasswordModel;

  void updateUserPassword(
  {
  required String currentPassword,
  required String newPassword,
}
      ){
    emit(UpdateUserPasswordLoadingState());
    DioHelper.postData(url: CHANGE_PASSWORD, data: {
      'current_password': currentPassword,
      'new_password': newPassword
    },token: token).then((value){
      updatePasswordModel = LogInModel.fromJson(value.data);
      if(updatePasswordModel!.status){
        showToast(updatePasswordModel!.message.toString(), ToastStates.SUCCESS);
      }else{
        showToast(updatePasswordModel!.message.toString(), ToastStates.ERROR);
      }
      emit(UpdateUserPasswordSuccessState(updatePasswordModel));
    }).catchError((error){
      print(error.toString());
      emit(UpdateUserPasswordErrorState(error.toString()));
    });
  }
}
