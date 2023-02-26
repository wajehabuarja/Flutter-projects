import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/login/cubit/login_cubit.dart';
import 'package:shop_app/modules/login/shop_login.dart';
import 'package:shop_app/modules/register/cubit/register_cubit.dart';
import 'package:shop_app/modules/register/cubit/register_states.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/local/chache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ShopRegister extends StatelessWidget {
  ShopRegister({super.key});

  var fromkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessStates) {
            if (state.RegisterModel.status == true) {
              // print(state.loginModel.message);
              // print(state.loginModel.data!.token);
              showToast(
                text: "${state.RegisterModel.message}",
                state: TostStates.SUCCESS,
              );

              CacheHelper.saveData(
                key: 'token',
                value: state.RegisterModel.data!.token,
              ).then((value) {
                token = state.RegisterModel.data!.token;
                navigateAndFinish(context, const HomeLayout());
              });
            }
          } else if (state is ShopRegisterErrorStates) {
            // print(state.loginModel.message);
            showToast(
              text: "${state.RegisterModel.message}",
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
                          'Register',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Register now to browse our hot offers',
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
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter your Name';
                            }
                            return null;
                          },
                          label: 'User Name',
                          prefix: Icons.person,
                        ),
                        const SizedBox(
                          height: 15,
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
                          suffix: ShopRegisterCubit.get(context).suffix,
                          suffixPressed: () {
                            ShopRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          isPassSec: ShopRegisterCubit.get(context).isPassSec,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter your Phone';
                            }
                            return null;
                          },
                          label: 'Phone Number',
                          prefix: Icons.phone,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: ConditionalBuilder(
                            condition: state is! ShopRegisterLoadingStates,
                            builder: (context) => defaultButton(
                              function: () {
                                if (fromkey.currentState != null &&
                                    fromkey.currentState!.validate()) {
                                  ShopRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                } else {
                                  print('Register error');
                                }
                              },
                              text: 'Register',
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
                            const Text('have an account?'),
                            defaultTextButton(
                                function: () {
                                  navigateAndFinish(
                                    context,
                                    ShopLogin(),
                                  );
                                },
                                text: 'Login'),
                          ],
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
