import '../utils/constants.dart';
import '../utils/library.dart';
import '../utils/my_colors.dart';
import '../utils/my_parameters.dart';

class MyTextButton extends ConsumerStatefulWidget {
  final String text;
  final Function function;
  final double? width;
  final double height;
  const MyTextButton(
      {super.key,
      required this.text,
      required this.function,
      this.width,
      required this.height});

  @override
  ConsumerState createState() => _MyButtonState();
}

class _MyButtonState extends ConsumerState<MyTextButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.function();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              // height: widget.height * 0.08,
              decoration: BoxDecoration(
                borderRadius: MyParameters(context).roundedBorders,
                  color: MyColors.mainColor),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.text,
                    style: MyParameters(context).middleTextStyleWhite,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
