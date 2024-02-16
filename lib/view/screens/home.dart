import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:vocabulary_app/view/widgets/floating_button.dart';
import 'package:vocabulary_app/view/widgets/show_language_filter_button.dart';
import 'package:vocabulary_app/view/widgets/selected_language_from_filter.dart';
import 'package:vocabulary_app/view/widgets/words_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: const CustomFloatingActionButton(),
        appBar: AppBar(),
        body: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LanguageFromFilter(),
                  LanguageFilterButton(),
                ],
              ),
              Gap(10),
              Expanded(child: WordsWidget()),
            ],
          ),
        ));
  }
}
