import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/resources/color_manager.dart';
import '../core/resources/font_manager.dart';
import '../core/resources/styles_manager.dart';
import '../core/utils/custom_extension_and_checkers.dart';

class DefaultTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final Function(String?)? onSaved;
  final ValueChanged<String>? onChange;
  final GestureTapCallback? onTap;
  final String? initialValue;
  final bool isPassword;
  final String hintText;
  final Color? backgroundColor;
  final double height;
  final double? borderRadius;
  final bool isPasswordVisible;
  final FormFieldValidator<String>? validate;

  final Widget? suffix;
  final Widget? prefixIcon;
  final VoidCallback? suffixPressed;
  final bool isClickable;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign? textAlign;
  final int lines;
  final int? maxLength;
  final double? fontSize;
  final Color? textColor;
  final Color? hintTextColor;
  final Color? enabledBorderColor;
  final FocusNode? focusNode;
  const DefaultTextFormField({
    super.key,
    required this.controller,
    required this.type,
    required this.validate,
    this.onSaved,
    this.inputFormatters,
    this.readOnly = false,
    this.maxLength,
    this.enabledBorderColor,
    this.textAlign,
    this.focusNode,
    this.borderRadius,
    this.textColor,
    this.backgroundColor,
    this.hintText = '',
    this.initialValue,
    this.prefixIcon,
    this.height = 1,
    this.isClickable = true,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.lines = 1,
    this.onChange,
    this.hintTextColor,
    this.onTap,
    this.fontSize,
    this.suffix,
    this.suffixPressed,
  });

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizedW(context) * 0.02),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        initialValue: initialValue,
        controller: controller,
        onFieldSubmitted: (value) {
          if (onSaved != null) {
            onSaved!(value);
          }
        },
        inputFormatters: inputFormatters,
        keyboardType: type,
        readOnly: readOnly,
        focusNode: focusNode,
        // textAlign: textAlign == null
        //     ? EasyLocalization.of(context)?.currentLocale!.languageCode == 'ar'
        //         ? TextAlign.start
        //         : TextAlign.end
        //     : textAlign!,
        obscureText: isPassword ? !isPasswordVisible : false,
        enabled: isClickable,
        maxLength: maxLength,
        onChanged: onChange,
        // onSaved: (v) => onSaved == null ? null : {onSaved!(v)},
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onTap: onTap,
        maxLines: lines,
        textAlign: textAlign ?? TextAlign.start,
        validator: validate,
        style: getRegularStyle(
          color: textColor ?? kDarkBlue,
          fontSize: fontSize ?? FontSize.s16,
          height: height,
        ),
        decoration: InputDecoration(
          alignLabelWithHint: true,
          hintTextDirection: ui.TextDirection.rtl,
          counterText: '',
          prefixIcon: prefixIcon,
          hintText: hintText,
          suffixIcon:
              isPassword
                  ? IconButton(
                    icon:
                        isPasswordVisible
                            ? const Icon(Icons.visibility, color: kLightBlue)
                            : const Icon(Icons.visibility_off, color: kGrey),
                    onPressed: suffixPressed,
                  )
                  : suffix,
          hintStyle: getRegularStyle(
            color: hintTextColor ?? kGrey,
            fontSize: FontSize.s16,
          ),
          filled: true,
          fillColor: backgroundColor ?? kTextFieldBackColor,
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              width: 2.0,
              color: enabledBorderColor ?? Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: kBlue.withValues(alpha: 0.5)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}

class InputPhoneNumberSection extends StatelessWidget {
  InputPhoneNumberSection({
    super.key,
    required this.controller,
    this.readOnly = false,
    this.countryCodeValue = '',
  });
  final TextEditingController controller;
  final bool readOnly;
  final String countryCodeValue;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 2,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: sizedW(context) * 0.00),
            child: DefaultTextFormField(
              controller: controller,
              readOnly: readOnly,
              textColor: readOnly ? kGrey : null,
              hintText: 'رقم الهاتف',
              textAlign: TextAlign.right,
              type: TextInputType.phone,

              onSaved: (String? value) {
                if (value!.isEmpty) return;
                controller.text = '$countryCodeValue$value';
                print(controller.text);
              },
              validate: (value) {
                if (value!.isEmpty || value.length < 11) {
                  return 'من فضلك ادخل رقم الهاتف';
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }
}

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    required this.onTap,
    required this.text,
    this.buttonColor,
    this.iconWidth,
    this.style,
    this.iconData,
    this.textColor,
    this.fontSize,
    this.height,
    this.width,
  });

  final Function onTap;
  final String text;
  final double? height;
  final double? width;
  final double? fontSize;
  final IconData? iconData;
  final TextStyle? style;
  final Color? buttonColor;
  final Color? textColor;
  final double? iconWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? sizedH(context) * 0.060,
      width: width ?? sizedW(context) * 0.85,
      decoration: BoxDecoration(
        color: buttonColor ?? kLightBlue,
        borderRadius: BorderRadius.circular(18),
      ),
      child: TextButton(
        onPressed: () {
          onTap();
        },
        child:
            iconData == null
                ? Text(
                  text,
                  style:
                      style ??
                      getMediumStyle(
                        color: textColor ?? kWhite,
                        fontSize: fontSize ?? 13,
                      ),
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(width: sizedW(context) * 0.10),
                    Icon(iconData!, size: iconWidth ?? sizedW(context) * 0.04),
                    SizedBox(width: sizedW(context) * 0.03),
                    Text(
                      text,
                      style:
                          style ??
                          getMediumStyle(
                            color: textColor ?? kWhite,
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
      ),
    );
  }
}
