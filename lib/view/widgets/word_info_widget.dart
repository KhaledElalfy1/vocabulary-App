import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:vocabulary_app/view/styles/colors.dart';

class WordInfoWidget extends StatelessWidget {
  const WordInfoWidget({
    super.key,
    this.onPressed,
    required this.text,
    required this.colorCode,
    required this.isArabic,
  });
  final String text;
  final int colorCode;
  final bool isArabic;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: Color(colorCode),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _wordLanguage(),
          const Gap(10),
          Expanded(child: _wordText()),
          if (onPressed != null)
            IconButton(
              onPressed: onPressed,
              icon: const Icon(
                Icons.delete,
                color: ColorManager.black,
                size: 30,
              ),
            ),
        ],
      ),
    );
  }

  Text _wordText() {
    return Text(
      text,
      style: const TextStyle(
        color: ColorManager.black,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  CircleAvatar _wordLanguage() {
    return CircleAvatar(
      backgroundColor: ColorManager.black,
      radius: 30,
      child: Text(
        isArabic ? 'ar' : 'en',
        style: TextStyle(
          color: Color(colorCode),
          fontSize: 25,
        ),
      ),
    );
  }
}
