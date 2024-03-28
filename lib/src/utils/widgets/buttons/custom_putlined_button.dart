import 'package:second_brain/src/utils/app_exports.dart';

class CustomOutlinedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final double? width;
  final double? borderRadius;
  final double? height;
  final Size? size;

  const CustomOutlinedButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.width,
      this.borderRadius,
      this.height,
      this.size});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: size ?? Size(width ?? double.infinity, height ?? 45),
          side: const BorderSide(width: 1, color: Color(0xFFB088DD)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16.0,
            color: context.textTheme.titleMedium?.color,
            fontWeight: FontWeight.w500,
            // fontWeight: fontWeight,
          ),
        ));
  }
}
