import 'package:farm_project/core/cubits/auth/auth_cubit.dart';
import 'package:farm_project/core/cubits/auth/auth_states.dart';
import 'package:farm_project/core/resources/color_manager.dart';
import 'package:farm_project/core/resources/font_manager.dart';
import 'package:farm_project/core/resources/image_assets.dart';
import 'package:farm_project/core/utils/custom_extension_and_checkers.dart';
import 'package:farm_project/core/utils/snackbar_helper.dart';
import 'package:farm_project/src/presentation/home/home_screen.dart';
import 'package:farm_project/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key, this.isLogin = true});

  static const routeName = '/signin_screen';
  final bool isLogin;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (v) => true,
            );
            SnackBarHelper.showMySnackbar(context, 'تم تسجيل الدخول بنجاح');
            // Navigate to home screen here
          } else if (state is AuthFailure) {
            SnackBarHelper.showMySnackbar(context, state.error, warning: true);
          }
        },
        builder: (context, snapshot) {
          return SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: sizedH(context) * 0.03),
                  Image.asset(ImageAssets.signIn, scale: 6),
                  SizedBox(height: sizedH(context) * 0.04),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: sizedH(context) * 0.02,
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: sizedH(context) * 0.03),
                             DefaultTextFormField(
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                textAlign: TextAlign.right,
                                hintText: 'الاليميل',
                                fontSize: FontSize.s20,
                                isPasswordVisible: false,
                                suffixPressed: () {
                                  // prov.changeVisiblePassword();
                                },
                                validate: (v) {
                                  if (v!.isEmpty) {
                                    // if (prov.autoValidateMode) {
                                    return ' من فضلك ادخل الايميل';
                                    // }
                                  }
                                  return null;
                                },
                              ),
                              // InputPhoneNumberSection(
                              //   controller: emailController,
                              // ),
                             
                              // DefaultTextFormField(
                              //   controller: ,
                              //   type: TextInputType.number,
                              //   hintText: LocalKeys.kPhoneNumber.tr(),
                              //   validate: (v) {
                              //     if (prov.phoneNumberController.text.isEmpty) {
                              //       // if (prov.autoValidateMode) {
                              //       return LocalKeys.kPleaseEnterPhoneNumber.tr();
                              //       // }
                              //     }
                              //     return null;
                              //   },
                              //   onChange: (v) => prov.phoneNumberController.text = v,
                              // ),
                              SizedBox(height: sizedH(context) * 0.02),
                              DefaultTextFormField(
                                controller: passwordController,
                                type: TextInputType.visiblePassword,
                                textAlign: TextAlign.right,
                                hintText: 'ألرقم السري',
                                isPassword: true,
                                fontSize: FontSize.s20,
                                isPasswordVisible: false,
                                suffixPressed: () {
                                  // prov.changeVisiblePassword();
                                },
                                validate: (v) {
                                  if (v!.isEmpty) {
                                    // if (prov.autoValidateMode) {
                                    return 'من فضلك أدخل الرقم السري';
                                    // }
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: sizedH(context) * 0.04),
                              DefaultButton(
                                onTap: () async {
                                  if (formKey.currentState!.validate()) {
                                    AuthCubit().login(
                                      emailController.text,
                                      passwordController.text,
                                    );
                                  }
                                },
                                text: 'سجل الأن',
                                fontSize: FontSize.s18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
