import 'package:second_brain/src/utils/app_exports.dart';
import 'package:second_brain/src/utils/plugins/loader.dart';

import 'init_screen_ctrl.dart';

class InitScreen extends StatelessWidget {
  final InitScreenCtrl c = Get.put(InitScreenCtrl());

  InitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: ChasingDotsLoader(),
      ),
    );
  }
}
