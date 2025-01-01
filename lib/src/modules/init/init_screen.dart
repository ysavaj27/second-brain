import 'package:second_brain/src/utils/app_exports.dart';
import 'package:second_brain/src/utils/plugins/loader.dart';


class InitScreen extends StatelessWidget {

  const InitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: ChasingDotsLoader(),
      ),
    );
  }
}
