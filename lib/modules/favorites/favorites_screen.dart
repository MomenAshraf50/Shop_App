import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_cubit/cubit.dart';
import 'package:shop_app/layout/home_cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      builder: (context,state) => ConditionalBuilder(
          condition: HomeCubit.get(context).homeModel!= null && HomeCubit.get(context).favoritesModel != null,
          builder:(context) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder:(context,index) => buildProductItem(HomeCubit.get(context).favoritesModel!.data[index].favoriteProduct,context),
                separatorBuilder:(context,index) => const SizedBox(height: 10,) ,
                itemCount: HomeCubit.get(context).favoritesModel!.data.length
            ),
          ),
          fallback:(context) => const Center(child: CircularProgressIndicator())),
      listener: (context,state){});
  }

}
