import 'package:bloc/bloc.dart';

import '../../../domain/use_cases/list_all_shurtcuts_use_case.dart';
import '../../../domain/use_cases/remove_shortcut_use_case.dart';
import 'list_shortcuts_events.dart';
import 'list_shortcuts_states.dart';

class ListShortcutsBloc extends Bloc<ListShortcutsEvent, ListShortcutsState> {
  final ListAllShurtcutsUseCase _listAllShurtcutsUseCase;
  final RemoveShortcutUseCase _removeShortcutUseCase;

  ListShortcutsBloc({
    required ListAllShurtcutsUseCase listAllShurtcutsUseCase,
    required RemoveShortcutUseCase removeShortcutUseCase,
  })  : _listAllShurtcutsUseCase = listAllShurtcutsUseCase,
        _removeShortcutUseCase = removeShortcutUseCase,
        super(
          const ListAllShortcutsLoading(),
        ) {
    on<ListAllShortcuts>(
      (event, emit) => _listAllShortcuts(event, emit),
    );
    on<RemoveShortcut>(
      (event, emit) => _removeShortcut(event, emit),
    );
  }

  Future<void> _listAllShortcuts(
    ListAllShortcuts event,
    Emitter emit,
  ) async {
    try {
      final shortcuts = await _listAllShurtcutsUseCase();

      if (shortcuts.isEmpty) {
        emit(
          const ListAllShortcutsEmpty(),
        );
      } else {
        emit(
          ListAllShortcutsLoaded(
            shortcuts,
          ),
        );
      }
    } catch (e) {
      emit(
        ListAllShortcutsFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<void> _removeShortcut(event, Emitter emit) async {
    emit(const ListAllShortcutsLoading());

    await _removeShortcutUseCase(event.shortcut);

    add(
      const ListAllShortcuts(),
    );
  }
}
