import 'dart:io';
import 'package:second_brain/src/utils/app_exports.dart';import 'package:image_picker/image_picker.dart';

import '../functions/dialog.dart';
import 'crop_image.dart';

class FilePickers {
  final ImagePicker _picker = ImagePicker();
  static final FilePickers _instance = FilePickers._internal();

  factory FilePickers() {
    return _instance;
  }

  FilePickers._internal();

  Future<List<MediaModel>> pickFile({
    bool multiple = false,
    FileType type = FileType.any,
    List<String>? allowedExtensions,
  }) async {
    List<MediaModel> list = [];
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: multiple,
        type: type,
        allowedExtensions: allowedExtensions,
        // allowCompression: true,
      );
      if (result != null) {
        return result.files
            .where((e) => e.path != null && e.path!.isNotEmpty)
            .map((file) {
                return MediaModel(
                    type: type,
                    name: file.name,
                    path: file.path ?? '',
                    dataType: FileDataType.filePath,
                    file: File(file.path ?? ""));
            })
            .whereType<MediaModel>()
            .toList();
      }
    } catch (e) {
      logger.d('Error picking file: $e');
    }
    return list;
  }

  Future<MediaModel?> pickSingleImage({bool isCropper = true}) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Uint8List? bytes;
      final image = File(pickedFile.path);
      // final byte = await pickedFile.length();
        if (isCropper) {
          bytes = (await showCustomDialog(
              CropImageWidget(imagePath: pickedFile.path))) as Uint8List?;
        }
        return MediaModel(
          type: FileType.image,
          name: pickedFile.name,
          path: pickedFile.path,
          file: image,
          uint8list: bytes,
          dataType: isCropper ? FileDataType.bytes : FileDataType.filePath,
        );

    }
    return null;
  }
}
