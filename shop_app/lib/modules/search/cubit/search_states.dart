abstract class ShopSearchStates {}

class ShopSearchInitialStates extends ShopSearchStates {}

class ShopSearchLoadingStates extends ShopSearchStates {}

class ShopSearchSuccessStates extends ShopSearchStates {
  // final ShopLoginModel RegisterModel;

  // ShopSearchSuccessStates(this.RegisterModel);
}

class ShopSearchErrorStates extends ShopSearchStates {
  // final String error;
  // final ShopLoginModel RegisterModel;

  // ShopSearchSuccessStatesErrorStates(this.error, this.RegisterModel);
}