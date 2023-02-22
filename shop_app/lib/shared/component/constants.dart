import 'package:shop_app/modules/login/shop_login.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/network/local/chache_helper.dart';

//Sign out
void Signout(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context, ShopLogin());
    }
  });
}

//token
String? token = '';
