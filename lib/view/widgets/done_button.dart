import 'package:flutter/material.dart';
import 'package:vocabulary_app/view/styles/colors.dart';

class DoneButton extends StatelessWidget {
  const DoneButton({super.key, required this.colorCode, required this.onTap});
  final int colorCode;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: 80,
          height: 50,
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'Done',
            style: TextStyle(
                color: Color(colorCode),
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
