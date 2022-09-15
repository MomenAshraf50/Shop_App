import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/search_cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit():super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void getSearchProducts(String search){
    emit(SearchLoadingState());

    DioHelper.postData(url: SEARCH_PRODUCTS, data:{'text':search},token: token).then((value){
      searchModel = SearchModel.fromJson(value.data);
      print(searchModel!.data[0].name);
      emit(SearchSuccessState());
    }).catchError((error){
      emit(SearchErrorState(error.toString()));
    });
  }
}