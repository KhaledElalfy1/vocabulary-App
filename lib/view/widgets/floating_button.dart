import 'package:flutter/material.dart';
import 'package:vocabulary_app/view/styles/colors.dart';
import 'package:vocabulary_app/view/widgets/add_word_dialog.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: ColorManager.white,
      shape: const CircleBorder(),
      onPressed: () => showDialog(
        context: context,
        builder: (context) => const AddWordDialog(),
      ),
      child: const Icon(
        Icons.add,
        color: ColorManager.black,
      ),
    );
  }
}
