import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app2/screens/note_controller.dart';
import '../database/note_database.dart';

class EditNoteController extends GetxController {
  final contentController = TextEditingController();
  var isSaving = false.obs;

  void initializeNote(Note note) {
    contentController.text = note.content;
  }

  @override
  void onClose() {
    contentController.dispose();
    super.onClose();
  }
}

class EditNotes extends StatelessWidget {
  final Note note;

  EditNotes({super.key, required this.note});

  final EditNoteController controller = Get.put(EditNoteController());
  final NoteController noteController = Get.find<NoteController>();

  @override
  Widget build(BuildContext context) {
    controller.initializeNote(note);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
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
            if (note.latitude != null && note.longitude != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.blue),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Saved Location:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            'Lat: ${double.parse(note.latitude!).toStringAsFixed(6)}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          Text(
                            'Lng: ${double.parse(note.longitude!).toStringAsFixed(6)}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
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

                    Note updatedNote = Note(
                      id: note.id,
                      content: controller.contentController.text.trim(),
                      latitude: note.latitude,
                      longitude: note.longitude,
                      createdAt: note.createdAt,
                    );

                    await noteController.updateNote(updatedNote);

                    controller.isSaving.value = false;

                    Get.back();
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
                    controller.isSaving.value ? 'Saving...' : 'Update Note',
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