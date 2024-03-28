import 'package:second_brain/src/utils/app_exports.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double borderRadius;
  final double? elevation;
  final bool isLoading;
  final EdgeInsetsGeometry padding;
  final TextStyle? style;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Widget? child;
  final bool isLoginGradient;
  final bool noGradient;
  final GradientEnum gradient;
  final Size? size;

  const CustomElevatedButton({
    super.key,
    this.text = "",
    required this.onPressed,
    this.backgroundColor,
    this.fontWeight,
    this.textColor,
    this.fontSize,
    this.width,
    this.elevation,
    this.height,
    this.style,
    this.color,
    this.isLoading = false,
    this.borderRadius = 10.0,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    this.child,
    this.isLoginGradient = true,
    this.noGradient = false,
    this.gradient = GradientEnum.auth,
     this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradients(),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          padding: padding,
          elevation: elevation,
          minimumSize: size ?? Size(width ?? double.infinity, height ?? 45),
          // primary: backgroundColor ?? Theme.of(context).primaryColor,
          // onPrimary: textColor ?? Colors.white,
          backgroundColor: backgroundColor ?? Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: isLoading
            ? CupertinoActivityIndicator(
                color: context.theme.scaffoldBackgroundColor)
            : child ??
                Text(
                  text,
                  style: style ??
                      TextStyle(
                          fontSize: fontSize ?? 16.0,
                          color: color ?? context.theme.scaffoldBackgroundColor,
                          fontWeight: fontWeight),
                ),
      ),
    );
  }

  Gradient? gradients() {
    switch (gradient) {
      case GradientEnum.auth:
        return const LinearGradient(colors: [
          Color(0xFF8C3BE6),
          Color(0xFF944AE6),
          Color(0xFF9C59E6),
          Color(0xFFA469E5),
          Color(0xFFAD7AE5)
        ]);
      case GradientEnum.app:
        return const LinearGradient(
          colors: [
            Color(0xFFAB54DB),
            Color(0xFFBE76E6),
          ],
        );
      case GradientEnum.none:
      // TODO: Handle this case.
    }
    return null;
  }
}

class MyElevatedButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final Gradient gradient;
  final VoidCallback? onPressed;
  final Widget child;

  const MyElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.width,
    this.height = 44.0,
    this.gradient = const LinearGradient(colors: [
      Color(0xFF8C3BE6),
      Color(0xFF944AE6),
      Color(0xFF9C59E6),
      Color(0xFFA469E5),
      Color(0xFFAD7AE5)
    ]),
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(0);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(Get.width, 61),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: child,
      ),
    );
  }
}
