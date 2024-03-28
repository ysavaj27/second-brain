
import 'package:second_brain/src/utils/app_exports.dart';

class TitleText extends StatelessWidget {
  final String title;

  const TitleText(this.title,{super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, color: AppColors.darkPrimary),
    );
  }
}
