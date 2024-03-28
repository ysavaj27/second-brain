
import 'package:second_brain/src/utils/app_exports.dart';

import 'buttons/custom_putlined_button.dart';

class DeleteWidget extends StatelessWidget {
  final void Function()? onPressed;

  const DeleteWidget({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 57,
            width: 57,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 1.4, color: Colors.red),
            ),
            alignment: Alignment.center,
            child: const Icon(
              FontAwesomeIcons.trashCan,
              size: 27,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Are you sure?",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 5),
          Text(
            "Are you sure you want to delete this?",
            style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomOutlinedButton(
                onPressed: Get.back,
                width: 95,
                size: const Size(95, 40),
                text: "Cancel",
                borderRadius: 4,
              ),
              CustomElevatedButton(
                borderRadius: 4,
                onPressed:onPressed,
                size: const Size(95, 40),
                padding: EdgeInsets.zero,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                text: "Delete",
                backgroundColor: Colors.red,
              )
            ],
          ),
        ],
      ),
    );
  }
}
