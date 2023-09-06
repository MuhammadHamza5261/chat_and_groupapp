import 'package:flutter/material.dart';

import '../values/colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap ;
  final String title ;
  final Color? backgroundColor ;
  final int? borderRadius ;
  final Color? titleColor ;
  final int? titleSize ;
  final int? width ;
  final int? height ;
  final Color? borderColor ;
  const CustomButton({Key? key, required this.onTap, required this.title, this.backgroundColor, this.borderRadius, this.titleColor, this.titleSize, this.width, this.height, this.borderColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width ;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: width?.toDouble() ?? mediaWidth,
        height: height?.toDouble() ?? 56,
        decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.primary,
            border: Border.all(
              color: borderColor ?? Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(borderRadius?.toDouble() ?? 8)
        ),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: titleColor ?? AppColors.white,
              fontSize: titleSize?.toDouble(),
            ),
          ),
        ),
      ),
    );
  }
}
