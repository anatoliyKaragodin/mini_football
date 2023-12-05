
import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import 'package:mini_football/src/app/pages/tutorial_page/view/tutorial_page_view.dart';
import 'package:mini_football/src/riverpod/riverpod.dart';
import '/src/app/pages/home_app/view/home_app_page.dart';
import '/src/data/get_adv_id_and_tz.dart';
import '/src/data/get_url.dart';
import '/src/data/shared_preferences.dart';
import '/src/pages/home_page.dart';
import '/src/pages/home_page_web.dart';
import '/src/utils/library.dart';
import 'src/app/pages/game_field_page/view/game_page.dart';

final container = ProviderContainer();
int appHomePageIndex = 0;

const Color kCanvasColor = Color(0xfff2f3f7);

/// Webview
String url = '';
String? advertisingId = '';
String timezone = 'Unknown';
int homePageIndex = 2;
String userAgent = 'unknown';

void main() async {
  /// Check initialization
  WidgetsFlutterBinding.ensureInitialized();

  /// Webview
  await FlutterUserAgent.init();
  var webViewUserAgent = FlutterUserAgent.webViewUserAgent;
  userAgent = webViewUserAgent!;

  /// Permission
  await Permission.storage.request();
  await Permission.camera.request();
  await Permission.photos.request();
  await Permission.photosAddOnly.request();
  await Permission.mediaLibrary.request();
  await Permission.manageExternalStorage.request();

  /// Load url
  url = await LocalData().getUrl();
  if (url != '') {
    /// HOME PAGE
    homePageIndex = 1;
  }
  container.read(homePageProvider.notifier).update((state) => 1);
  if (kDebugMode) {
    print('${container.read(homePageProvider)}');
  }
  if (kDebugMode) {
    print('LOAD URL: $url');
  }

  /// Get url from server
  if (url == '') {
    await GetAdvIdAndTZ().initPlatformState();
    await GetAdvIdAndTZ().initTimeZone();
    url = (await GetUrl()
        .getHttp(advertisingId: advertisingId!, timezone: timezone))!;
    await LocalData().setUrl(url);
    if (url != '') {
      homePageIndex = 1;
    } else {
      /// CHANGE TO 0
      homePageIndex = 0;
    }
  }

  /// Game
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: const HomePage().route,
      routes: {
        const HomePage().route: (context) => const HomePage(),
        const HomePageWeb().route: (context) => const HomePageWeb(),
        const HomeAppPage().route: (context) => const HomeAppPage(),
        const GamePage().route: (context) => const GamePage(),
        const TutorialPageView().route: (context) => const TutorialPageView(),
      },
    );
  }
}
