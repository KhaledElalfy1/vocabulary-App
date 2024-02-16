import 'package:flutter/material.dart';
import 'package:vocabulary_app/constants.dart';
import 'package:vocabulary_app/cubits/write_data_cubit/write_data_cubit.dart';
import 'package:vocabulary_app/view/styles/colors.dart';

class ColorDesign extends StatelessWidget {
  const ColorDesign(
      {super.key, required this.index, required this.selectedColor});
  final int index, selectedColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        WriteDataCubit.get(context)
            .updateColorCode(Constants.colorsCode[index]);
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: selectedColor == Constants.colorsCode[index]
              ? Border.all(color: ColorManager.white, width: 2)
              : null,
          color: Color(
            Constants.colorsCode[index],
          ),
        ),
        alignment: Alignment.center,
        child: selectedColor == Constants.colorsCode[index]
            ? const Icon(
                Icons.done,
                color: ColorManager.white,
              )
            : null,
      ),
    );
  }
}
