import 'package:get/get.dart';

class HomeController extends GetxController {
  int currentTab = 0;
  void switchNavTab(int currentSelectedTab) {
    currentTab = currentSelectedTab;
    update();
  }
}
