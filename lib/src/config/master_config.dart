import 'package:get/get.dart';
import 'package:second_brain/src/utils/plugins/logger.dart';

final MasterConfig masterConfig = MasterConfig.instance;

class MasterConfig extends GetxService {
  static final MasterConfig instance = MasterConfig();

  // Rx<ApiConfigModel> configData = ApiConfigModel.fromJson({}).obs;

  // ApiConfigModel get config => configData();

  Future<void> getAll() async {
    try {
      // await MasterApi.getConfigData();
      // await MasterApi.getAllSectors();
      // await MasterApi.instrumentType();
      // await MasterApi.getInvestorType();
    } on Exception catch (e) {
      logger.d("Error Found :$e");
    }
  }
}
