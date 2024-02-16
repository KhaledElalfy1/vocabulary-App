import 'package:flutter/material.dart';
import 'package:vocabulary_app/view/styles/colors.dart';

class UpdateWordButton extends StatelessWidget {
  const UpdateWordButton({super.key, required this.colorCode, this.onTap});
  final int colorCode;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 65,
        height: 35,
        decoration: BoxDecoration(
          color: Color(
            colorCode,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.add,
          color: ColorManager.black,
        ),
      ),
    );
  }
}
