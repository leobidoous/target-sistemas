class NoteEntity {
  final int id;
  final String note;

  NoteEntity({required this.id, required this.note});

  @override
  String toString() => 'Nota(id: $id, descrição: $note)';
}
