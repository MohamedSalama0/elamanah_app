import 'package:farm_project/core/resources/font_manager.dart';
import 'package:farm_project/widgets/back_button_widget.dart';
import 'package:flutter/material.dart';
import '../core/resources/color_manager.dart';
import '../core/resources/styles_manager.dart';
import '../core/utils/custom_extension_and_checkers.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String? subTitle;
  final bool hasBackButton;
  final Widget? actionWidget;
  final double subTitleHight;
  final TextStyle? titleTextStyle;
  const AppBarWidget({
    super.key,
    required this.title,
    this.titleTextStyle,
    this.subTitle,
    this.actionWidget,
    this.subTitleHight = 2,
    this.hasBackButton = true,
  });

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('change dipendencies local');
    // print(context.locale.languageCode);
    // context.locale;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          top: sizedH(context) * 0.015,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: sizedH(context) * 0.08,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.hasBackButton) ...{
                      SizedBox(width: sizedW(context) * 0.02),
                      Container(
                        margin: const EdgeInsetsDirectional.only(
                          start: 8.0,
                        ),
                        child: const BackButtonWidget(),
                      )
                    } else ...{
                      const SizedBox.shrink(),
                    },
                    // widget.hasBackButton
                    //     ? SizedBox(width: sizedW(context) * 0.02)
                    //     : const SizedBox.shrink(),
                    // widget.hasBackButton
                    //     ? Container(
                    //         margin: const EdgeInsetsDirectional.only(
                    //             start: 8.0, top: 5),
                    //         child: const BackButtonWidget(),
                    //       )
                    //     : const SizedBox.shrink(),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            widget.title,
                            textAlign: TextAlign.center,
                            style: getBoldStyle(
                                color: kDarkBlue,
                                fontSize: FontSize.s18,
                                height: 1.2),
                          ),
                        ),
                      ),
                    ),
                    widget.hasBackButton
                        ? SizedBox(width: sizedW(context) * 0.10)
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              widget.subTitle == null
                  ? SizedBox(
                      height: sizedH(context) * 0.01,
                    )
                  : Container(
                      constraints: BoxConstraints(
                        maxWidth: sizedW(context) - sizedW(context) * 0.30,
                      ),
                      child: Text(
                        widget.subTitle!,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: getRegularStyle(color: kGrey)
                            .copyWith(height: widget.subTitleHight),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
