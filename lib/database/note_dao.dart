import 'package:floor/floor.dart';
import 'note_database.dart';

@dao
abstract class NoteDao {
  @Query('select * from Note order by createdAt DESC')
  Stream<List<Note>> watchAllNotes();

  @Query('select * from Note where id = :id')
  Future<Note?> getNoteById(int id);

  @insert
  Future<void> insertNote(Note note);

  @update
  Future<void> updateNote(Note note);

  @delete
  Future<void> deleteNote(Note note);

  @Query('delete from Note')
  Future<void> deleteAllNotes();

  @Query('select COUNT(*) from Note')
  Future<int?> getNotesCount();
}