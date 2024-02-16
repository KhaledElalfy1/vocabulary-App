import 'package:flutter/material.dart';
import 'package:vocabulary_app/view/styles/colors.dart';
import 'package:vocabulary_app/view/widgets/filter_dialog.dart';

class LanguageFilterButton extends StatelessWidget {
  const LanguageFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => const FilterDialog(),
        );
      },
      child: const CircleAvatar(
        backgroundColor: ColorManager.white,
        radius: 21,
        child: Icon(
          Icons.filter_list,
          color: ColorManager.black,
        ),
      ),
    );
  }
}
