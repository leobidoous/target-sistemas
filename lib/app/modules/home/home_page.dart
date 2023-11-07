import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/extensions/build_context_extensions.dart';
import '../../core/themes/app_theme.dart';
import '../../core/themes/spacing/spacing.dart';
import '../style_sheet/custom_alert.dart';
import '../style_sheet/custom_dialog.dart';
import '../style_sheet/custom_loading.dart';
import '../style_sheet/inputs/custom_input_field.dart';
import 'domain/entities/note_entity.dart';
import 'home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = 'Home'}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textController = TextEditingController();
  final store = Modular.get<HomeStore>();
  final formKey = GlobalKey<FormState>();
  bool showClearTextField = false;

  @override
  void initState() {
    super.initState();
    store.getNotes();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Future<void> onAddNote() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    final id = UniqueKey().hashCode;
    setState(() => showClearTextField = false);
    await store
        .saveNote(NoteEntity(note: textController.text, id: id))
        .then((value) async {
      if (store.error != null) {
        await CustomDialog.show(
          context,
          CustomAlert(
            title: 'Erro ao adicionar nota',
            content: 'Ocorreu um erro ao salvar sua nota:\n${store.error}',
            btnConfirmLabel: 'Fechar',
            onConfirm: Navigator.of(context).pop,
          ),
          showClose: true,
        );
        store.error = null;
        return;
      }
      textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.primary,
              AppTheme.secondary,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(Spacing.sm.value),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Minhas notas',
                        style: context.textTheme.titleLarge,
                      ),
                      Spacing.xxs.vertical,
                      Flexible(
                        child: Card(
                          child: Observer(
                            builder: (context) {
                              if (store.isLoading) {
                                return const CustomLoading();
                              } else if (store.notes.isEmpty) {
                                return _notesListEmpty;
                              }
                              return _notesList;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacing.md.vertical,
                Form(
                  key: formKey,
                  child: CustomInputField(
                    controller: textController,
                    onEditingComplete: onAddNote,
                    hintText: 'Adicione sua nota aqui',
                    validators: [
                      (input) => (input ?? '').trim().length > 20
                          ? 'Limite de 20 caracteres atingido'
                          : null,
                      (input) => (input ?? '').trim().isEmpty
                          ? 'Campo não pode ser vazio'
                          : null,
                    ],
                    onChanged: (input) {
                      if (input == null) return;
                      if (input.isEmpty) {
                        setState(() => showClearTextField = false);
                      } else if (input.isNotEmpty && !showClearTextField) {
                        setState(() => showClearTextField = true);
                      }
                    },
                    suffixIcon: showClearTextField
                        ? Semantics(
                            button: true,
                            child: InkWell(
                              onTap: () {
                                textController.clear();
                                setState(() => showClearTextField = false);
                              },
                              child: const Icon(Icons.close_rounded),
                            ),
                          )
                        : null,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                Spacing.xxl.vertical,
                Align(
                  child: Semantics(
                    button: true,
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        'Políticas de privacidade',
                        style: context.textTheme.labelMedium,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _notesListEmpty {
    return Padding(
      padding: EdgeInsets.all(Spacing.sm.value),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Nenhuma nota adicionada',
            style: context.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget get _notesList {
    return RefreshIndicator(
      onRefresh: store.getNotes,
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (_, index) => _noteListItem(
          store.notes[index],
        ),
        padding: EdgeInsets.all(Spacing.sm.value),
        separatorBuilder: (_, __) => Divider(height: Spacing.md.value),
        itemCount: store.notes.length,
      ),
    );
  }

  Widget _noteListItem(NoteEntity note) {
    return Semantics(
      button: true,
      child: InkWell(
        onTap: () {
          textController.text = note.note;
        },
        child: Row(
          children: [
            Expanded(
              child: Text(
                note.note,
                style: context.textTheme.bodyMedium,
              ),
            ),
            Spacing.sm.horizontal,
            const Icon(Icons.edit_rounded),
            Spacing.xs.horizontal,
            Semantics(
              button: true,
              child: InkWell(
                onTap: () {
                  CustomDialog.show(
                    context,
                    CustomAlert(
                      title: 'Confirmar exclusão',
                      content:
                          'Você tem certeza que deseja excluir a nota $note?',
                      btnConfirmLabel: 'Excluir',
                      btnCancelLabel: 'Fechar',
                      onConfirm: () {
                        store.removeNote(note);
                        Navigator.of(context).pop();
                      },
                      onCancel: Navigator.of(context).pop,
                    ),
                    showClose: true,
                  );
                },
                child: const Icon(Icons.remove_circle_outline_outlined),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
