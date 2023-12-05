import '../utils/library.dart';

class HomePageClear extends StatefulWidget {
  final String route = 'clear page';

  const HomePageClear({Key? key}) : super(key: key);

  @override
  State<HomePageClear> createState() => _HomePageClearState();
}

class _HomePageClearState extends State<HomePageClear> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
