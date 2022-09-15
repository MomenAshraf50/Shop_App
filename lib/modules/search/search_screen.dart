import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/search_cubit/cubit.dart';
import 'package:shop_app/modules/search/search_cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state) {},
        builder: (context,state)=> Scaffold(
          appBar: AppBar(
            title: const Text('Search',style: TextStyle(fontSize: 24),),
          ),
          body:Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  defaultTextFormField(
                    controller: searchController,
                    label: 'Search',
                    prefix: Icons.search,
                    inputType: TextInputType.text,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter text to search';
                      }
                      return null;
                    },
                    onSubmitted: (search){
                      SearchCubit.get(context).getSearchProducts(search);
                    },
                  ),
                  const SizedBox(height: 10,),
                  if(state is SearchLoadingState) const LinearProgressIndicator(),
                  const SizedBox(height: 10,),
                  if(state is SearchSuccessState) Expanded(
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder:(context,index) => buildProductItem(SearchCubit.get(context).searchModel!.data[index],context,isSearch: true),
                        separatorBuilder:(context,index) => const SizedBox(height: 10,) ,
                        itemCount: SearchCubit.get(context).searchModel!.data.length
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
