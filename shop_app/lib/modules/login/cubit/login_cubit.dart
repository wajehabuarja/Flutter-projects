import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/cubit/login_states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialStates());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  late ShopLoginModel loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingStates());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then(
      (value) {
        // print(value.data);

        loginModel = ShopLoginModel.fromJson(value.data);
        // print(loginModel.status);
        // print(loginModel.message);
        // print(loginModel.data!.token);
        

        emit(ShopLoginSuccessStates(loginModel));
      },
    ).catchError(
      (error) {
        print(error);
        emit(ShopLoginErrorStates(error.toString(),loginModel));
      },
    );
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassSec = true;

  void changePasswordVisibility() {
    isPassSec = !isPassSec;
    suffix =
        isPassSec ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ShopLoginChangePasswordVisibilityState());
  }
}
