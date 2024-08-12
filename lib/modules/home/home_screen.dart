import 'package:ai_text_extracter/modules/saved_cards/saved_cards_screen.dart';
import 'package:ai_text_extracter/modules/text_extracter/view/extract_text_view.dart';
import 'package:flutter/material.dart';

final ValueNotifier<int> currentSelectedPage = ValueNotifier<int>(0);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentSelectedPage,
      builder: (BuildContext context, int value, Widget? child) {
        return Scaffold(
          appBar: AppBar(title: const Text("Text Recognizer")),
          body: currentSelectedPage.value == 0
              ? const ExtractTextView()
              : const SavedCardView(),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int value) {
              currentSelectedPage.value = value;
            },
            currentIndex: currentSelectedPage.value,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.document_scanner), label: 'Scan cards'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.save), label: 'Saved cards'),
            ],
          ),
        );
      },
    );
  }
}
