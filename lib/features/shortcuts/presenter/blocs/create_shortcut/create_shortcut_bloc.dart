import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/shortcut_entity.dart';
import '../../../domain/use_cases/create_shortcut_use_case.dart';
import '../../../domain/use_cases/parse_string_to_commands_use_case.dart';
import 'create_shortcut_events.dart';
import 'create_shortcut_states.dart';

class CreateShortcutBloc
    extends Bloc<CreateShortcutEvent, CreateShortcutState> {
  final CreateShortcutUseCase _createShortcutUseCase;
  final ParseStringToCommandsUseCase _parseStringToCommandsUseCase;

  ShortcutEntity _shortcut = const ShortcutEntity(
    id: -1,
    name: '',
    commands: [],
    workingDirectory: '',
  );

  String commands = '';

  CreateShortcutBloc({
    required CreateShortcutUseCase createShortcutUseCase,
    required ParseStringToCommandsUseCase parseStringToCommandsUseCase,
  })  : _createShortcutUseCase = createShortcutUseCase,
        _parseStringToCommandsUseCase = parseStringToCommandsUseCase,
        super(const CreateShortcutInitial()) {
    on<UpdateShortcutProperties>(
      (event, emit) => _updateProperties(
        event,
        emit,
      ),
    );
    on<SaveShortcut>(
      (event, emit) => _saveShortcut(
        event,
        emit,
      ),
    );
    on<ResetShortcutProperties>(
      (event, emit) => _resetProperties(
        event,
        emit,
      ),
    );
  }

  Future<void> _updateProperties(
    UpdateShortcutProperties event,
    Emitter emit,
  ) async {
    _shortcut = _shortcut.copyWith(
      name: event.name,
      commands: _parseStringToCommandsUseCase(event.commands ?? ''),
      workingDirectory: event.workingDirectory,
    );

    emit(
      CreateShortcutImcomplete(
        name: event.name,
        commands: event.commands,
        workingDirectory: event.workingDirectory,
      ),
    );
  }

  Future<void> _saveShortcut(
    SaveShortcut event,
    Emitter emit,
  ) async {
    try {
      if (_shortcut.name.isEmpty) {
        emit(
          const InvalidShortcutName(),
        );
        return;
      }

      if (_shortcut.commands.isEmpty) {
        emit(
          const InvalidShortcutCommands(),
        );
        return;
      }

      _shortcut = await _createShortcutUseCase(_shortcut);

      emit(
        CreateShortcutComplete(
          name: _shortcut.name,
          commands: _shortcut.commands.join(' '),
          workingDirectory: _shortcut.workingDirectory,
        ),
      );
    } catch (e) {
      emit(
        CreateShortcutFailure(
          e.toString(),
        ),
      );
    }
  }

  void _resetProperties(ResetShortcutProperties event, Emitter emit) {
    _shortcut = _shortcut.copyWith(
      name: '',
      commands: [],
      workingDirectory: '',
    );

    emit(
      CreateShortcutImcomplete(
        name: _shortcut.name,
        commands: _shortcut.commands.join(' '),
        workingDirectory: _shortcut.workingDirectory,
      ),
    );
  }
}
