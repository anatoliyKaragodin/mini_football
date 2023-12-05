import 'package:flutter/foundation.dart';
import 'package:mini_football/src/app/pages/game_field_page/view/game_page.dart';
import '../app/pages/home_app/view/home_app_page.dart';

import '../../main.dart';
import '../app/pages/tutorial_page/view/tutorial_page_view.dart';
import '../utils/library.dart';
import 'home_page_clear.dart';
import 'home_page_web.dart';

class HomePage extends ConsumerStatefulWidget {
  final String route = 'home page';

  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final List<Widget> homePages = <Widget>[
    const HomeAppPage(),
    const HomePageWeb(),
    const HomePageClear(),
  ];

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('__________________________HOME PAGE INDEX: $homePageIndex');
    }

    return SafeArea(child: homePages.elementAt(homePageIndex));
  }
}
