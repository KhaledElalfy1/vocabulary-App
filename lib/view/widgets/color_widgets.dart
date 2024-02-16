import 'package:flutter/material.dart';
import 'package:vocabulary_app/constants.dart';
import 'package:vocabulary_app/view/widgets/item_color_design.dart';

class ColorsWidget extends StatelessWidget {
  const ColorsWidget({super.key, required this.activeColor});
  final int activeColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: Constants.colorsCode.length,
        itemBuilder: (context, index) =>
            ColorDesign(index: index, selectedColor: activeColor),
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      ),
    );
  }
}
