import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app2/screens/note_controller.dart';

class AddNoteController extends GetxController {
  var saveLocation = false.obs;
  final contentController = TextEditingController();
  var isSaving = false.obs;

  @override
  void onClose() {
    contentController.dispose();
    super.onClose();
  }
}

class AddNotes extends StatelessWidget {
  AddNotes({super.key});

  final AddNoteController controller = Get.put(AddNoteController());
  final NoteController noteController = Get.find<NoteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: controller.contentController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText: 'Write your note here...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Obx(
                  () => Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CheckboxListTile(
                  title: const Text('Save Location'),
                  subtitle: Text(
                    'Save current GPS coordinates with this note',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  value: controller.saveLocation.value,
                  onChanged: (value) {
                    controller.saveLocation.value = value!;
                  },
                  secondary: const Icon(Icons.location_on, color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Obx(
                  () => SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: controller.isSaving.value
                      ? null
                      : () async {
                    if (controller.contentController.text.trim().isEmpty) {
                      Get.snackbar(
                        'Error',
                        'Please enter note content',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red[100],
                        colorText: Colors.red[900],
                      );
                      return;
                    }

                    controller.isSaving.value = true;

                    await noteController.addNote(
                      content: controller.contentController.text.trim(),
                      saveLocation: controller.saveLocation.value,
                    );

                    controller.isSaving.value = false;

                    Get.back();
                    Get.snackbar(
                      'Success',
                      'Note saved successfully',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green[100],
                      colorText: Colors.green[900],
                    );
                  },
                  icon: controller.isSaving.value
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : const Icon(Icons.save, color: Colors.white),
                  label: Text(
                    controller.isSaving.value ? 'Saving...' : 'Save Note',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}