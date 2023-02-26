import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/login/cubit/login_cubit.dart';
import 'package:shop_app/modules/login/cubit/login_states.dart';
import 'package:shop_app/modules/register/shop_register.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/local/chache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ShopLogin extends StatelessWidget {
  ShopLogin({super.key});
  
  var fromkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) async {
          if (state is ShopLoginSuccessStates) {
            if (state.loginModel.status == true) {
              // print(state.loginModel.message);
              // print(state.loginModel.data!.token);
              showToast(
                text: "${state.loginModel.message}",
                state: TostStates.SUCCESS,
              );

              await CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                token = state.loginModel.data!.token;
                navigateAndFinish(context, const HomeLayout());
              });
            }
          } else if (state is ShopLoginErrorStates) {
            // print(state.loginModel.message);
            showToast(
              text: "${state.loginModel.message}",
              state: TostStates.ERROR,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: Form(
                    key: fromkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Column(
                          children: const [
                            Icon(
                              Ionicons.cart_sharp,
                              size: 100,
                              color: defaultColor,
                            ),
                            Text(
                              'Shop App',
                              style: TextStyle(
                                color: defaultColor,
                                fontSize: 35,
                                fontWeight: FontWeight.w900,
                              ),
                            )
                          ],
                        )),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: GoogleFonts.markaziText(
                            textStyle: const TextStyle(
                              color: Color.fromARGB(255, 117, 117, 117),
                              fontSize: 22,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter your Email';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Password is too short';
                            }
                            return null;
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          suffix: ShopLoginCubit.get(context).suffix,
                          suffixPressed: () {
                            ShopLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          isPassSec: ShopLoginCubit.get(context).isPassSec,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: ConditionalBuilder(
                            condition: state is! ShopLoginLoadingStates,
                            builder: (context) => defaultButton(
                              function: () {
                                if (fromkey.currentState != null &&
                                    fromkey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                } else {
                                  print('login error');
                                }
                              },
                              text: 'Login',
                              isUpperCase: true,
                            ),
                            fallback: (context) =>
                                const CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?'),
                            defaultTextButton(
                                function: () {
                                  navigateAndFinish(
                                    context,
                                    ShopRegister(),
                                  );
                                },
                                text: 'register'),
                          ],
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
