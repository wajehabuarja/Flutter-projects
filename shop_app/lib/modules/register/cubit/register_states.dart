import 'package:shop_app/models/login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialStates extends ShopRegisterStates {}

class ShopRegisterLoadingStates extends ShopRegisterStates {}

class ShopRegisterSuccessStates extends ShopRegisterStates {
  final ShopLoginModel RegisterModel;

  ShopRegisterSuccessStates(this.RegisterModel);
}

class ShopRegisterErrorStates extends ShopRegisterStates {
  final String error;
  final ShopLoginModel RegisterModel;

  ShopRegisterErrorStates(this.error, this.RegisterModel);
}

class ShopRegisterChangePasswordRegVisibilityState extends ShopRegisterStates {}
