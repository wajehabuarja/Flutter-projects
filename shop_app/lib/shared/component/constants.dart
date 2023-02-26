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


//https://web.postman.co/workspace/My-Workspace~83f8c74b-a002-4a2a-8334-a455778e68d1/folder/25827463-2185d459-2348-4075-867c-e4dcec4cc7f8?ctx=documentation