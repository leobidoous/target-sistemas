import 'dart:convert';

import '../../../domain/entities/note_entity.dart';

class NoteModel extends NoteEntity {
  NoteModel({required super.id, required super.note});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'note': note,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] as int,
      note: map['note'] as String,
    );
  }
  factory NoteModel.fromEntity(NoteEntity entity) {
    return NoteModel(
      id: entity.id,
      note: entity.note,
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) =>
      NoteModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
