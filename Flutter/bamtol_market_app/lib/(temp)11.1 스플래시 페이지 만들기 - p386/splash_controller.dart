import 'package:get/get.dart';
import 'step_type.dart';

class SplashController extends GetxController {
  Rx<StepType> loadstep = StepType.dataLoad.obs;

  changeStep(StepType type) {
    loadstep(type);
  }
}
