import 'package:ai_text_extracter/modules/home/home_binding.dart';
import 'package:ai_text_extracter/modules/home/home_screen.dart';
import 'package:ai_text_extracter/modules/saved_cards/saved_card_binding.dart';
import 'package:ai_text_extracter/modules/saved_cards/saved_cards_screen.dart';
import 'package:ai_text_extracter/modules/splash_screen.dart';
import 'package:ai_text_extracter/modules/text_extracter/text_extracter_binding.dart';
import 'package:ai_text_extracter/modules/text_extracter/view/extract_text_view.dart';
import 'package:ai_text_extracter/routes/app_routes_name.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      binding: HomeBinding(),
      name: AppRoutes.homeScreen,
      page: () => const HomeScreen(),
    ),
    GetPage(
      binding: TextExtractorBinding(),
      name: AppRoutes.savedCardScreen,
      page: () => const ExtractTextView(),
    ),
    GetPage(
      binding: SavedCardBinding(),
      name: AppRoutes.savedCardScreen,
      page: () => const SavedCardView(),
    ),
  ];
}
