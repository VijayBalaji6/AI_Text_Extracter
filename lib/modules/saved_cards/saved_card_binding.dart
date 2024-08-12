import 'package:ai_text_extracter/modules/saved_cards/saved_cards_controller.dart';
import 'package:get/instance_manager.dart';

class SavedCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SavedCardsController());
  }
}
