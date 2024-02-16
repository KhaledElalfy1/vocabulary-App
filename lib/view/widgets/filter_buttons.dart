import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vocabulary_app/view/styles/colors.dart';

class FilterButtons extends StatelessWidget {
  const FilterButtons(
      {super.key,
      required this.labels,
      required this.onTaps,
      required this.isSelected});
  final List<String> labels;
  final List<VoidCallback> onTaps;
  final List<bool> isSelected;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: labels.length,
        separatorBuilder: (context, index) => const SizedBox(width: 5),
        itemBuilder: (context, index) => InkWell(
          onTap: onTaps[index],
          child: Container(
            padding: const EdgeInsets.all(12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected[index]
                  ? ColorManager.white
                  : ColorManager.transparent,
              border: Border.all(
                color: ColorManager.white,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(
                16,
              ),
            ),
            child: Text(
              labels[index],
              style: TextStyle(
                color:
                    isSelected[index] ? ColorManager.black : ColorManager.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
