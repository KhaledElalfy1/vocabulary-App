import 'package:flutter/material.dart';
import 'package:vocabulary_app/cubits/write_data_cubit/write_data_cubit.dart';
import 'package:vocabulary_app/view/styles/colors.dart';

class ArabicOrEnglishContainer extends StatelessWidget {
  const ArabicOrEnglishContainer(
      {super.key,
      required this.buildIsArabic,
      required this.isArabic,
      required this.colorCode});
  final bool buildIsArabic, isArabic;
  final int colorCode;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        WriteDataCubit.get(context).updateIsArabic(buildIsArabic);
      },
      child: Container(
        height: 60,
        width: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: ColorManager.white,
          ),
          shape: BoxShape.circle,
          color: buildIsArabic == isArabic
              ? ColorManager.white
              : Color(
                  colorCode,
                ),
        ),
        child: Text(
          buildIsArabic ? 'Ar' : 'En',
          style: TextStyle(
              color: !(buildIsArabic == isArabic)
                  ? ColorManager.white
                  : Color(
                      colorCode,
                    ),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
