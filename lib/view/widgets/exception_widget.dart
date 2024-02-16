import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:vocabulary_app/view/styles/colors.dart';

class ExceptionWidget extends StatelessWidget {
  const ExceptionWidget({
    super.key, required this.imagePath, required this.message,
  });
  final String imagePath, message;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          height: 350,
        ),
        const Gap(10),
         Text(
          message,
          style:  const TextStyle(
            color: ColorManager.white,
            fontSize: 25,
          ),
        ),
      ],
    );
  }
}
