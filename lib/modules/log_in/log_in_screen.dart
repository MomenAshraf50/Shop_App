import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/log_in/cubit/cubit.dart';
import 'package:shop_app/modules/log_in/cubit/states.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class LogInScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController= TextEditingController();
    TextEditingController passwordController= TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => LogInCubit(),
      child: BlocConsumer<LogInCubit,LogInStates>(
        listener: (context,state){
          if(state is LogInSuccessState){
            if(state.model!.status){
              CacheHelper.saveData(key: 'token', value: state.model!.data?.token).then((value){
                navigateToAndFinish(context, HomeLayout());
                token = state.model!.data!.token.toString();
                showToast(state.model!.message.toString(), ToastStates.SUCCESS);
              });
            }else{
              showToast(state.model!.message.toString(), ToastStates.ERROR);
            }
          }
        },
        builder: (context,state) => Scaffold(
          appBar: AppBar(),
          body: ConditionalBuilder(
            condition: state is! LogInLoadingState,
            builder:(context) => Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'LOGIN',
                          style:Theme.of(context).textTheme.headline4?.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style:Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFormField(
                            controller: emailController,
                            label: 'Email',
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            prefix: Icons.email_outlined,
                            inputType: TextInputType.emailAddress
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defaultTextFormField(
                            controller: passwordController,
                            label: 'Password',
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            onSubmitted: (value){
                              if(formKey.currentState!.validate()){
                                LogInCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);
                              }
                            },
                            prefix: Icons.lock_outline,
                            inputType: TextInputType.visiblePassword,
                            isPassword: LogInCubit.get(context).isPassword,
                            suffix:LogInCubit.get(context).suffix,
                            onPressed: (){
                              LogInCubit.get(context).changePasswordVisibility();
                            }
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultButton(text: 'Log In', onPressed: (){
                          if(formKey.currentState!.validate()){
                            LogInCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);
                          }
                        }),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            const Text('Don\'t have an account?'),
                            TextButton(onPressed: (){
                              navigateTo(context, RegisterScreen());
                            }, child: const Text('Register Now'))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            fallback:(context) => const Center(child: CircularProgressIndicator()),

          ),
        ),
      ),
    );
  }
}
