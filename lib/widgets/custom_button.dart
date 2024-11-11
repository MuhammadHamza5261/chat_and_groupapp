import 'package:flutter/material.dart';
import '../styles/app_colors.dart';
import '../styles/font_styles.dart';
import '../styles/sizes.dart';

class CustomButton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? minHeight;
  final double? minWidth;
  final Widget? child;
  final String? text;
  final VoidCallback? onPressed;
  final OutlinedBorder? shape;
  final double? elevation;
  final double? borderRadius;
  final Color? buttonColor;
  final Color? splashColor;
  final Color? shadowColor;
  final Gradient? gradientColor;
  final BorderRadiusGeometry? gradientBorderRadius;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onLongPress;
  final bool? disable;

  const CustomButton({
    this.height,
    this.width,
    this.minHeight,
    this.minWidth,
    this.child,
    this.text,
    this.onPressed,
    this.shape,
    this.elevation,
    this.borderRadius,
    this.buttonColor,
    this.splashColor,
    this.shadowColor,
    this.gradientColor,
    this.gradientBorderRadius,
    this.padding,
    this.onLongPress,
    this.disable,
    Key? key,
  })  : assert(text != null || child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    ElevatedButton.styleFrom();

    return ElevatedButton(
      onPressed: disable != null ? () {} : onPressed,
      style: ElevatedButton.styleFrom(
        padding: padding ?? EdgeInsets.zero,
        shape: shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Sizes.buttonR24),
            ),
        elevation: elevation ?? 0,
        backgroundColor: buttonColor,
        foregroundColor: splashColor,
        shadowColor: shadowColor,
        minimumSize: Size(
          minWidth ?? Sizes.buttonWidth60,
          minHeight ?? Sizes.buttonHeight40,
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Container(
        alignment: Alignment.center,
        height: height ?? Sizes.buttonHeight48,
        width: width ?? Sizes.buttonWidth220,
        decoration: buttonColor == null
            ? BoxDecoration(
          borderRadius: gradientBorderRadius ??
              BorderRadius.circular(Sizes.buttonR24),
          gradient: disable != null
              ? AppColors.disableIngredientColor
              : gradientColor ?? AppColors.primaryIngredientColor,
        )
            : null,
        child: child ??
            Text(
              text ?? '',
              style: TextStyle(
                color: buttonColor == null ? Colors.white : null,
                fontWeight: FontStyles.fontWeightSemiBold,
              ),
            ),
      ),
    );
  }
}