import 'package:shop_app/models/login_model.dart';

abstract class RegisterStates{}
class RegisterInitialState extends RegisterStates{}
class RegisterSuccessState extends RegisterStates{
  final LogInModel? model;
  RegisterSuccessState(this.model);
}
class RegisterLoadingState extends RegisterStates{}
class RegisterErrorState extends RegisterStates{
  final String? error;
  RegisterErrorState(this.error);
}
class RegisterChangePasswordVisibilityState extends RegisterStates{}
