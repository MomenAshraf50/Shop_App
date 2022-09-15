import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_cubit/cubit.dart';
import 'package:shop_app/layout/home_cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if(state is UpdateFavoritesSuccessState){
          if(state.model!.status){
            showToast(state.model!.message, ToastStates.SUCCESS);
          }else{
            showToast(state.model!.message, ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: HomeCubit.get(context).homeModel != null && HomeCubit.get(context).categoriesModel != null,
          builder: (context) =>
              productsBuilder(HomeCubit.get(context).homeModel,HomeCubit.get(context).categoriesModel,context),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel? model,CategoriesModel? categoriesModel,BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model!.data!.banners
                  .map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 200.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                enlargeCenterPage: true,
                aspectRatio: 2,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              height: 80,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder:(context,index)=>buildCategoryItem(categoriesModel!.data[index]),
                separatorBuilder: (context,index) =>const SizedBox(width: 10,),
                itemCount: categoriesModel!.data.length),
            ),
            const SizedBox(height: 20,),
            const Text(
              'New Products',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 20,),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1/1.65,
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: List.generate(
                model.data!.products.length,
                (index) => buildProductItem(model.data!.products[index],context)
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget buildProductItem(HomeProducts products,BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10,),
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children:[
              Image(
                image: NetworkImage('${products.image}'),
                width: double.infinity,
                height: 150,
              ),
              if(products.discount !=0 ) Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                color: Colors.red,
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10
                  ),
                ),
              )
            ]
          ),
          const SizedBox(height: 10,),
          Expanded(
            child: Text(
              '${products.name}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,

            ),
          ),
          const SizedBox(height: 8,),
          Row(
            children: [
              Text(
                '${products.price.round()}',
                style: const TextStyle(
                  fontSize: 12,
                  color: defaultColor
                ),
              ),
              const SizedBox(width: 5,),
              if(products.discount != 0) Text(
                '${products.oldPrice.round()}',
                style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: (){
                  HomeCubit.get(context).updateFavorites(products.id!);
                },
                icon: HomeCubit.get(context).favorites[products.id]!? const Icon(Icons.favorite,color: defaultColor,):const Icon(Icons.favorite_border),
              )],
          ),
        ],
      ),
    ),
  );

  Widget buildCategoryItem(CategoriesData? categoriesData) => Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage('${categoriesData!.image}'),
        fit: BoxFit.cover,
        width: 80,
        height: 80,
      ),
      Container(
        color: Colors.black.withOpacity(0.6),
        width: 80,
        child: Text(
          categoriesData.name!.toUpperCase(),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              color: Colors.white
          ),
        ),
      )
    ],
  );
}
