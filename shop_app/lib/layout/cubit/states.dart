import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/login_model.dart';

// ignore: camel_case_types
abstract class shopStates {}

class ShopInitialState extends shopStates {}

class ShopChangeBottomNavState extends shopStates {}

class ShopLoadingHomeDataState extends shopStates {}

//home
class ShopSuccessHomeDataState extends shopStates {}

class ShopErrorHomeDataState extends shopStates {}

//cattagories
class ShopSuccessCategoriesDataState extends shopStates {}

class ShopErrorCategoriesDataState extends shopStates {}

//Favorites
class ShopChangeFavoritesDataState extends shopStates {}

class ShopSuccessFavoritesDataState extends shopStates {
  final ChangeFavoritesModel model;

  ShopSuccessFavoritesDataState(this.model);
}

class ShopErrorFavoritesDataState extends shopStates {}

//Get Favorites
class ShopLoadingGetFavoritesState extends shopStates {}

class ShopSuccessGetFavoritesState extends shopStates {}

class ShopErrorGetFavoritesState extends shopStates {}

//Get UserData
class ShopLoadingGetUserDataState extends shopStates {}

class ShopSuccessGetUserDataState extends shopStates {
  final ShopLoginModel loginModel;

  ShopSuccessGetUserDataState(this.loginModel);
}

class ShopErrorGetUserDataState extends shopStates {}

//Update UserData
class ShopLoadingUpdateUserDataState extends shopStates {}

class ShopSuccessUpdateUserDataState extends shopStates {
  final ShopLoginModel loginModel;

  ShopSuccessUpdateUserDataState(this.loginModel);
}

class ShopErrorUpdateUserDataState extends shopStates {}
