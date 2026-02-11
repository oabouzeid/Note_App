import 'package:floor/floor.dart';
import 'date_time_converter.dart';

@Entity(tableName: 'Note')
class Note {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String content;

  final String? latitude;
  final String? longitude;

  @TypeConverters([DateTimeConverter])
  final DateTime createdAt;

  Note({
    this.id,
    required this.content,
    this.latitude,
    this.longitude,
    required this.createdAt,
  });
}