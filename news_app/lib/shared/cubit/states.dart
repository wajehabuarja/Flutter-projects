abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}

//
class NewGetBusniessLoadingState extends NewsStates {}

class NewGetBusniessSuccessState extends NewsStates {}

class NewGetBusniessErrorState extends NewsStates {
  final String error;
  NewGetBusniessErrorState(this.error);
}

//
class NewGetSportsLoadingState extends NewsStates {}

class NewGetSportsSuccessState extends NewsStates {}

class NewGetSportsErrorState extends NewsStates {
  final String error;
  NewGetSportsErrorState(this.error);
}

//
class NewGetScienceLoadingState extends NewsStates {}

class NewGetScienceSuccessState extends NewsStates {}

class NewGetScienceErrorState extends NewsStates {
  final String error;
  NewGetScienceErrorState(this.error);
}

//Search
class NewGetSearchLoadingState extends NewsStates {}

class NewGetSearchSuccessState extends NewsStates {}

class NewGetSearchErrorState extends NewsStates {
  final String error;
  NewGetSearchErrorState(this.error);
}
