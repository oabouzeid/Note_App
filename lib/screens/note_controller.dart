import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import '../database/note_database.dart';
import '../main.dart';

class NoteController extends GetxController {
  var notes = <Note>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotes();
  }

  // Load notes from database
  void loadNotes() async {
    isLoading.value = true;
    database.noteDao.watchAllNotes().listen((notesList) {
      notes.value = notesList;
      isLoading.value = false;
    });
  }

  // Add new note
  Future<void> addNote({
    required String content,
    bool saveLocation = false,
  }) async {
    String? lat;
    String? lng;

    if (saveLocation) {
      Position? position = await _getCurrentLocation();
      if (position != null) {
        lat = position.latitude.toString();
        lng = position.longitude.toString();
      }
    }

    Note newNote = Note(
      content: content,
      latitude: lat,
      longitude: lng,
      createdAt: DateTime.now(),
    );

    await database.noteDao.insertNote(newNote);
  }

  // Get current location
  Future<Position?> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar(
          'Error',
          'Location services are disabled',
          snackPosition: SnackPosition.BOTTOM,
        );
        return null;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar(
            'Error',
            'Location permission denied',
            snackPosition: SnackPosition.BOTTOM,
          );
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar(
          'Error',
          'Location permissions are permanently denied',
          snackPosition: SnackPosition.BOTTOM,
        );
        return null;
      }

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not get location: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  // Delete note
  Future<void> deleteNote(Note note) async {
    await database.noteDao.deleteNote(note);
    Get.snackbar(
      'Success',
      'Note deleted successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Update note
  Future<void> updateNote(Note note) async {
    await database.noteDao.updateNote(note);
    Get.snackbar(
      'Success',
      'Note updated successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
    Get.back();
  }

  // Delete all notes
  Future<void> deleteAllNotes() async {
    await database.noteDao.deleteAllNotes();
    Get.snackbar(
      'Success',
      'All notes deleted',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}