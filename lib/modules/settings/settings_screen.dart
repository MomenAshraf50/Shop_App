import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_cubit/cubit.dart';
import 'package:shop_app/layout/home_cubit/states.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  var passwordFormKey = GlobalKey<FormState>();
  var dataFormKey = GlobalKey<FormState>();

  SettingsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var currentPasswordController = TextEditingController();
    var newPasswordController = TextEditingController();
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state) {
        if( state is UpdateUserPasswordSuccessState){
          if(state.model!.status){
            Navigator.pop(context);
            HomeCubit.get(context).changeBottomSheet(false);
          }
        }
        if(state is HomeChangeBottomNavState){
          Navigator.pop(context);
          HomeCubit.get(context).changeBottomSheet(false);
        }
      },
      builder: (context,state) {


        LogInModel? model = HomeCubit.get(context).userModel;
        if(model!=null){
          nameController.text = model.data!.name.toString();
          phoneController.text = model.data!.phone.toString();
          emailController.text = model.data!.email.toString();
        }

        return ConditionalBuilder(
        condition: HomeCubit.get(context).userModel != null&& state is! UpdateUserDataLoadingState ,
        builder: (context) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: dataFormKey,
              child: Column(
                children: [
                  defaultTextFormField(
                    controller: nameController,
                    label: 'Name',
                    validator: (value){
                      if(value!.isEmpty){
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    prefix:Icons.person,
                    inputType: TextInputType.name,
                  ),
                  const SizedBox(height: 20,),
                  defaultTextFormField(
                    controller: emailController,
                    label: "Email",
                    validator: (value){
                      if(value!.isEmpty){
                        return 'email must not be empty';
                      }
                      return null;
                    },
                    prefix:Icons.mail,
                    inputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20,),
                  defaultTextFormField(
                    controller: phoneController,
                    label: 'Phone',
                    validator: (value){
                      if(value!.isEmpty){
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    prefix:Icons.phone,
                    inputType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20,),
                  defaultButton(text: 'Update Data', onPressed: (){
                    if(dataFormKey.currentState!.validate()){
                      HomeCubit.get(context).updateUserData(
                        name: nameController.text,
                        phone: phoneController.text,
                        email: emailController.text,
                      );
                    }
                  }),
                  const SizedBox(height: 20,),
                  defaultButton(text: 'LOG OUT', onPressed: (){
                    signOut(context);
                  }),
                  const SizedBox(height: 20,),
                  defaultButton(text: 'Change Password', onPressed: (){
                    HomeLayout.scaffoldKey.currentState!.showBottomSheet((context)=> Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: passwordFormKey,
                        child: Column(
                          children: [
                            defaultTextFormField(
                                controller: currentPasswordController,
                                label: 'Current Password',
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your current password';
                                  }
                                  return null;
                                },
                                prefix: Icons.lock_outline,
                                inputType: TextInputType.visiblePassword,
                                isPassword: HomeCubit.get(context).isPassword,
                                suffix: HomeCubit.get(context).suffix,
                                onPressed: () {
                                  HomeCubit.get(context).changePasswordVisibility();
                                }),
                            const SizedBox(
                              height: 20.0,
                            ),
                            defaultTextFormField(
                                controller: newPasswordController,
                                label: 'New Password',
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your new password';
                                  }
                                  return null;
                                },
                                prefix: Icons.lock_outline,
                                inputType: TextInputType.visiblePassword,
                                isPassword: HomeCubit.get(context).isRePassword,
                                suffix: HomeCubit.get(context).rePasswordSuffix,
                                onPressed: () {
                                  HomeCubit.get(context).changeRePasswordVisibility();
                                }),
                            const SizedBox(height: 20,),
                            defaultButton(text: 'Change', onPressed: (){
                              if(passwordFormKey.currentState!.validate()){
                                HomeCubit.get(context).updateUserPassword(
                                  currentPassword: currentPasswordController.text,
                                  newPassword: newPasswordController.text,);
                              }
                            })
                          ],
                        ),
                      ),

                    ),
                    elevation: 50).closed.then((value){
                      HomeCubit.get(context).changeBottomSheet(false);
                    });
                    HomeCubit.get(context).changeBottomSheet(true);
                  })
                ],
              ),
            ),
          ),
        ),
        fallback: (context) => const Center(child: CircularProgressIndicator())
      );
      },
    );
  }
}
