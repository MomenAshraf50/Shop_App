import 'package:shop_app/models/login_model.dart';

abstract class LogInStates{}
class LogInInitialState extends LogInStates{}
class LogInSuccessState extends LogInStates{
  final LogInModel? model;
  LogInSuccessState(this.model);
}
class LogInLoadingState extends LogInStates{}
class LogInErrorState extends LogInStates{
  final String? error;
  LogInErrorState(this.error);
}
class ChangePasswordVisibilityState extends LogInStates{}
