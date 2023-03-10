import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/search_states.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates> {
  ShopSearchCubit() : super(ShopSearchInitialStates());

  static ShopSearchCubit get(context) => BlocProvider.of(context);

  SearchModel searchModel = SearchModel.empty();

  void Search(String text) {
    emit(ShopSearchLoadingStates());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(ShopSearchSuccessStates());
    }).catchError(
      (error) {
        print(error.toString());
        emit(ShopSearchErrorStates());
      },
    );
  }
}
