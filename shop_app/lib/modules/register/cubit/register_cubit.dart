import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/register/cubit/register_states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialStates());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  late ShopLoginModel RegisterModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(ShopRegisterLoadingStates());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then(
      (value) {
        // print(value.data);

        RegisterModel = ShopLoginModel.fromJson(value.data);
        print(RegisterModel.status);
        print(RegisterModel.message);
        print(RegisterModel.data!.token);

        emit(ShopRegisterSuccessStates(RegisterModel));
      },
    ).catchError(
      (error) {
        print(error);
        emit(ShopRegisterErrorStates(error.toString(), RegisterModel));
      },
    );
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassSec = true;

  void changePasswordVisibility() {
    isPassSec = !isPassSec;
    suffix =
        isPassSec ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ShopRegisterChangePasswordRegVisibilityState());
  }
}
