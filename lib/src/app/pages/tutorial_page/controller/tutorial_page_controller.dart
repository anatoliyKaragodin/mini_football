import 'package:mini_football/src/app/pages/home_app/view/home_app_page.dart';
import 'package:mini_football/src/utils/library.dart';

class TutorialPageController {
  static onCloseTap(BuildContext context) {
    Navigator.pushNamed(context, const HomeAppPage().route);
  }
}
