import 'package:second_brain/src/utils/app_exports.dart';import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChasingDotsLoader extends StatelessWidget {
  const ChasingDotsLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SpinKitCircle(color: AppColors.primary, size: 30);
  }
}
