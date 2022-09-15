import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_cubit/cubit.dart';
import 'package:shop_app/layout/home_cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/styles/colors.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder:(context,state) => ConditionalBuilder(
          condition:HomeCubit.get(context).homeModel != null && HomeCubit.get(context).categoriesModel != null,
          builder: (context)=> ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder:(context,index)=> categoriesItemBuilder(HomeCubit.get(context).categoriesModel!.data[index]),
            separatorBuilder: (context,index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: defaultColor,
              ),
            ),
            itemCount: HomeCubit.get(context).categoriesModel!.data.length,
          ),
          fallback:(context) => const Center(child: CircularProgressIndicator())),
    );
  }

  Widget categoriesItemBuilder(CategoriesData data) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image:NetworkImage('${data.image}'),
          fit: BoxFit.cover,
          width: 80,
          height: 80,
        ),
        const SizedBox(width: 20,),
        Text(
          '${data.name}',
          style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20
          ),
        ),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios)
      ],
    ),
  );
}
