import 'package:hive/hive.dart';

part 'letter.g.dart';

@HiveType(typeId: 0)
class Letter extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String originalName;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String dateWithLocation;
  @HiveField(4)
  final String sentAt;
  @HiveField(5)
  final String sentFrom;
  @HiveField(6)
  final String sentTo;
  @HiveField(7)
  final String location;
  @HiveField(8)
  final String fullLetter;
  @HiveField(9)
  final String letterNotes;
  @HiveField(10)
  final String brief;
  @HiveField(11)
  final DateTime createdAt;

  Letter({
    required this.id,
    this.originalName = '',
    this.name = '',
    this.dateWithLocation = '',
    this.sentAt = '',
    this.sentFrom = '',
    this.sentTo = '',
    this.location = '',
    this.fullLetter = '',
    this.letterNotes = '',
    this.brief = '',
    required this.createdAt,
  });

  factory Letter.fromMap(Map<String, dynamic> map) {
    return Letter(
      id: map['id'] ?? 0,
      originalName: map['original_name'] ?? '',
      name: map['name'] ?? '',
      dateWithLocation: map['date_with_location'] ?? '',
      sentAt: map['sent_at'] ?? '',
      sentFrom: map['sent_from'] ?? '',
      sentTo: map['sent_to'] ?? '',
      location: map['location'] ?? '',
      fullLetter: map['full_letter'] ?? '',
      letterNotes: map['letter_notes'] ?? '',
      brief: map['brief'] ?? '',
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'original_name': originalName,
      'name': name,
      'date_with_location': dateWithLocation,
      'sent_at': sentAt,
      'sent_from': sentFrom,
      'sent_to': sentTo,
      'location': location,
      'full_letter': fullLetter,
      'letter_notes': letterNotes,
      'brief': brief,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
