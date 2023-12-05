import '../utils/constants.dart';
import '../utils/library.dart';
import '../utils/my_colors.dart';
import '../utils/my_parameters.dart';

class MyButton extends ConsumerStatefulWidget {
  final String text;
  final Function function;
  final double? width;
  final double height;
  const MyButton(
      {super.key,
      required this.text,
      required this.function,
      this.width,
      required this.height});

  @override
  ConsumerState createState() => _MyButtonState();
}

class _MyButtonState extends ConsumerState<MyButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.function();
      },
      child: Container(
          height: widget.height * 0.08,
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage(Constants.buttonImage))),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                widget.text,
                style: MyParameters(context).middleTextStyleWhite,
              ),
            ),
          )),
    );
  }
}
