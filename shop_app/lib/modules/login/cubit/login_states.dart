import 'package:shop_app/models/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialStates extends ShopLoginStates {}

class ShopLoginLoadingStates extends ShopLoginStates {}

class ShopLoginSuccessStates extends ShopLoginStates {
final ShopLoginModel loginModel;

  ShopLoginSuccessStates(this.loginModel);
}

class ShopLoginErrorStates extends ShopLoginStates {
  final String error;
  final ShopLoginModel loginModel;

  ShopLoginErrorStates(this.error, this.loginModel);

  
}

class ShopLoginChangePasswordVisibilityState extends ShopLoginStates {}
