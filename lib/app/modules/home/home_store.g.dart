// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'HomeStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorAtom = Atom(name: 'HomeStoreBase.error', context: context);

  @override
  Exception? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(Exception? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$notesAtom = Atom(name: 'HomeStoreBase.notes', context: context);

  @override
  ObservableList<NoteEntity> get notes {
    _$notesAtom.reportRead();
    return super.notes;
  }

  @override
  set notes(ObservableList<NoteEntity> value) {
    _$notesAtom.reportWrite(value, super.notes, () {
      super.notes = value;
    });
  }

  late final _$getNotesAsyncAction =
      AsyncAction('HomeStoreBase.getNotes', context: context);

  @override
  Future<void> getNotes() {
    return _$getNotesAsyncAction.run(() => super.getNotes());
  }

  late final _$saveNoteAsyncAction =
      AsyncAction('HomeStoreBase.saveNote', context: context);

  @override
  Future<void> saveNote(NoteEntity note) {
    return _$saveNoteAsyncAction.run(() => super.saveNote(note));
  }

  late final _$removeNoteAsyncAction =
      AsyncAction('HomeStoreBase.removeNote', context: context);

  @override
  Future<void> removeNote(NoteEntity note) {
    return _$removeNoteAsyncAction.run(() => super.removeNote(note));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
error: ${error},
notes: ${notes}
    ''';
  }
}
