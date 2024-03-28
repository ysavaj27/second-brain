import 'package:captable/src/utils/app_exports.dart';
import 'package:dotted_border/dotted_border.dart';

class CustomDottedBorder extends StatelessWidget {
  final double radius;
  final double padding;
  final Widget child;

  const CustomDottedBorder({
    super.key,
    this.radius = 12,
    this.padding = 6,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(

      borderType: BorderType.RRect,
      dashPattern: [6, 5],
      strokeWidth: 0.5,
      // color: context.theme.disabledColor,
      radius: Radius.circular(radius),
      padding: EdgeInsets.all(padding),
      child: child,
    );
  }
}
