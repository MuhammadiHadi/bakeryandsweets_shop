import 'package:bakeryandsweets_shop/styles/colors.dart';
import 'package:flutter/material.dart';

class ParimaryButton extends StatelessWidget {
  final String? title;
  final Color? color;
  final VoidCallback? OnPressad;

  ParimaryButton({this.title, this.color, this.OnPressad});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: OnPressad,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0), color: color),
        height: MediaQuery.of(context).size.height * 0.058,
        width: double.infinity,
        child: Center(
          child: Text(
            title!,
            style: TextStyle(
                color: AppColors.Primarywhite, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
