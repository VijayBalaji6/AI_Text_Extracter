import 'package:ai_text_extracter/modules/text_extracter/text_extracter_controller.dart';
import 'package:get/instance_manager.dart';

class TextExtractorBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => TextExtractorController(), permanent: true);
  }
}
