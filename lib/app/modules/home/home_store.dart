import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/entities/note_entity.dart';
import 'infra/models/note/model.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  @observable
  bool isLoading = false;
  @observable
  Exception? error;
  @observable
  ObservableList<NoteEntity> notes = ObservableList<NoteEntity>();

  @action
  Future<void> getNotes() async {
    await SharedPreferences.getInstance()
        .then((value) async {
          notes.clear();
          notes.addAll(
            value.getStringList('notes')?.map((note) {
                  return NoteModel.fromJson(note);
                }).toList() ??
                [],
          );
        })
        .catchError((onError) => error = onError)
        .whenComplete(() => isLoading = false);
  }

  @action
  Future<void> saveNote(NoteEntity note) async {
    await SharedPreferences.getInstance().then((value) async {
      final saved = await value.setStringList(
        'notes',
        notes
            .map(
              (note) => NoteModel.fromEntity(note).toJson(),
            )
            .toList(),
      );
      if (saved) {
        notes.add(note);
      } else {
        error = Exception('Erro ao adicionar nota: ${note.toString()}');
      }
    });
  }

  @action
  Future<void> removeNote(NoteEntity note) async {
    await SharedPreferences.getInstance().then((value) async {
      notes.removeWhere((n) => n.id == note.id);
      final saved = await value.setStringList(
        'notes',
        notes
            .map(
              (note) => NoteModel.fromEntity(note).toJson(),
            )
            .toList(),
      );
      if (!saved) {
        error = Exception('Erro ao remover nota: ${note.toString()}');
      }
    });
  }

  Future<void> logout() async {
    await SharedPreferences.getInstance().then((value) async {
      await value.remove('session');
    });
  }
}
