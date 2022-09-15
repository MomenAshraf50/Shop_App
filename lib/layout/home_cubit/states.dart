import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/update_favorites_model.dart';

abstract class HomeStates{}

class HomeInitialState extends HomeStates{}
class HomeChangeBottomNavState extends HomeStates{}

class HomeDataSuccessState extends HomeStates{}
class HomeDataErrorState extends HomeStates{
  final String? error;

  HomeDataErrorState(this.error);
}
class HomeDataLoadingState extends HomeStates{}

class CategoriesSuccessState extends HomeStates{}
class CategoriesErrorState extends HomeStates{
  final String? error;

  CategoriesErrorState(this.error);
}

class ChangeFavoritesState extends HomeStates{}
class UpdateFavoritesSuccessState extends HomeStates{
  UpdateFavoritesModel? model;

  UpdateFavoritesSuccessState(this.model);
}
class UpdateFavoritesErrorState extends HomeStates{
  final String? error;

  UpdateFavoritesErrorState(this.error);
}

class GetFavoritesSuccessState extends HomeStates{}
class GetFavoritesErrorState extends HomeStates{
  String? error;

  GetFavoritesErrorState(this.error);
}
class GetUserDataSuccessState extends HomeStates{
  final LogInModel? model;

  GetUserDataSuccessState(this.model);
}
class GetUserDataLoadingState extends HomeStates{}
class GetUserDataErrorState extends HomeStates{
  String? error;

  GetUserDataErrorState(this.error);
}

class ChangePasswordVisibilityState extends HomeStates{}

class UpdateUserDataSuccessState extends HomeStates{
  final LogInModel? model;

  UpdateUserDataSuccessState(this.model);
}
class UpdateUserDataLoadingState extends HomeStates{}
class UpdateUserDataErrorState extends HomeStates{
  String? error;

  UpdateUserDataErrorState(this.error);
}
class ChangeBottomSheetState extends HomeStates{}

class UpdateUserPasswordSuccessState extends HomeStates{
  final LogInModel? model;

  UpdateUserPasswordSuccessState(this.model);}
class UpdateUserPasswordLoadingState extends HomeStates{}
class UpdateUserPasswordErrorState extends HomeStates{
  String? error;

  UpdateUserPasswordErrorState(this.error);
}