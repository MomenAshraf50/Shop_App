abstract class SearchStates{}
class SearchInitialState extends SearchStates{}
class SearchSuccessState extends SearchStates{}
class SearchErrorState extends SearchStates{
  String? error;

  SearchErrorState(this.error);
}
class SearchLoadingState extends SearchStates{}