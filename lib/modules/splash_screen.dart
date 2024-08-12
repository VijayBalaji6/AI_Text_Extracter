import 'package:ai_text_extracter/modules/home/home_screen.dart';
import 'package:ai_text_extracter/modules/saved_cards/saved_card_binding.dart';
import 'package:ai_text_extracter/modules/text_extracter/text_extracter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(
      () => TextExtractorController(),
      fenix: false,
    );
    Get.lazyPut(
      () => SavedCardBinding(),
    );
    Future.delayed(const Duration(seconds: 3), (() async {
      Get.off((() => const HomeScreen()));
    }));
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
