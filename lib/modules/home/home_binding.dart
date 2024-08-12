import 'package:ai_text_extracter/modules/home/home_controller.dart';
import 'package:ai_text_extracter/modules/saved_cards/saved_cards_controller.dart';
import 'package:ai_text_extracter/modules/text_extracter/text_extracter_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => TextExtractorController(), fenix: true);
    Get.lazyPut(() => SavedCardsController(), fenix: true);
  }
}
