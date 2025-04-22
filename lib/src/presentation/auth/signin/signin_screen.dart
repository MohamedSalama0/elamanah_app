import 'package:farm_project/core/resources/color_manager.dart';
import 'package:farm_project/core/resources/font_manager.dart';
import 'package:farm_project/core/resources/image_assets.dart';
import 'package:farm_project/core/utils/custom_extension_and_checkers.dart';
import 'package:farm_project/src/presentation/home/home_screen.dart';
import 'package:farm_project/widgets/common_widget.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key, this.isLogin = true});

  static const routeName = '/signin_screen';
  final bool isLogin;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
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
                      key: GlobalKey(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: sizedH(context) * 0.03),
                          InputPhoneNumberSection(
                            controller: TextEditingController(),
                          ),
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
                            controller: TextEditingController(),
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
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                                (v) => true,
                              );
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
      ),
    );
  }
}
