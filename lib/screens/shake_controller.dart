import 'package:get/get.dart';
import 'package:shake/shake.dart';
import 'note_controller.dart';

class ShakeController extends GetxController {
  ShakeDetector? shakeDetector;
  final NoteController noteController = Get.find<NoteController>();

  @override
  void onInit() {
    super.onInit();
    initShakeDetector();
  }

  void initShakeDetector() {
    shakeDetector = ShakeDetector.autoStart(
      onPhoneShake: (event) {
        Get.defaultDialog(
          title: 'Delete All Notes',
          middleText: 'Are you sure you want to delete all notes?',
          textConfirm: 'Yes',
          textCancel: 'No',
          confirmTextColor: Get.theme.colorScheme.onPrimary,
          onConfirm: () {
            noteController.deleteAllNotes();
            Get.back();
          },
        );
      },
      minimumShakeCount: 3,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );
  }

  @override
  void onClose() {
    shakeDetector?.stopListening();
    super.onClose();
  }
}