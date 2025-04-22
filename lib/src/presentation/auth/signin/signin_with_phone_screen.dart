import 'package:farm_project/core/utils/custom_extension_and_checkers.dart';
import 'package:farm_project/widgets/appbar_widget.dart';
import 'package:farm_project/widgets/common_widget.dart';
import 'package:flutter/material.dart';

class SignInWithPhoneView extends StatefulWidget {
  const SignInWithPhoneView({super.key});
  static const routeName = '/signin_with_phone_view';

  @override
  State<SignInWithPhoneView> createState() => _SignInWithPhoneViewState();
}

class _SignInWithPhoneViewState extends State<SignInWithPhoneView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(title: 'تسجيل الدخول بالهاتف'),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                height: sizedH(context) * 0.70,
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
                        hintText: 'ألرقم السري',
                        isPassword: true,
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
                          // await prov.signInWithPhoneAndPassword(context);
                        },
                        text: 'سجل الأن',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
