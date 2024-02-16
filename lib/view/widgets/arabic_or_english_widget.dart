import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:vocabulary_app/view/widgets/arabic_or_english_container.dart';

class ArabicOrEnglishWidget extends StatelessWidget {
  const ArabicOrEnglishWidget(
      {super.key, required this.colorCode, required this.isArabic});
  final int colorCode;
  final bool isArabic;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ArabicOrEnglishContainer(buildIsArabic: true,isArabic: isArabic, colorCode: colorCode,),
        const Gap(5),
        ArabicOrEnglishContainer(buildIsArabic: false,isArabic: isArabic, colorCode: colorCode,),
      ],
    );
  }
}
