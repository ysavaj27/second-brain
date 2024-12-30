import 'dart:io';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:second_brain/src/utils/app_exports.dart';import 'package:crop_image/crop_image.dart';

class CropImageWidget extends StatelessWidget {
  CropImageWidget({super.key, required this.imagePath});

  final String imagePath;
  // final double aspectRatio;
  final CropController controller = CropController(aspectRatio: 1);

  @override
  Widget build(BuildContext context) {
    // controller = CropController(aspectRatio: aspectRatio);
    return Container(
      width: 400,
      height: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: context.theme.scaffoldBackgroundColor,
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Crop Image",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  controller.rotateRight();
                },
                icon: const Icon(Icons.rotate_right_outlined),
              ),
              IconButton(
                onPressed: () {
                  controller.rotateLeft();
                },
                icon: const Icon(Icons.rotate_left_outlined),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black,
              ),
              child: CropImage(
                controller: controller,
                image: Image(
                  image: FileImage(File(imagePath)),
                ),
                // maximumImageSize: 600,
              ),
            ),
          ),
          const SizedBox(height: 10),
          CustomElevatedButton(
            width: 200,
            text: "Submit",
            // isLoading: c.isCreating.value,
            onPressed: () async {
              ui.Image bitmap = await controller.croppedBitmap();
              var data = await bitmap.toByteData(format: ImageByteFormat.png);
              var bytes = data!.buffer.asUint8List();
              Get.back(result: bytes);
            },
          ),
        ],
      ),
    );
  }
}
