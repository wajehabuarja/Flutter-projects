abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}

class NewGetBusniessLoadingState extends NewsStates {}

class NewGetBusniessSuccessState extends NewsStates {}

class NewGetBusniessErrorState extends NewsStates {
  final String error;
  NewGetBusniessErrorState(this.error);
}

