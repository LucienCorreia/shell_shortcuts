import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/shortcut_entity.dart';
import '../../../domain/use_cases/create_shortcut_use_case.dart';
import '../../../domain/use_cases/parse_string_to_commands_use_case.dart';
import '../../../domain/use_cases/parse_string_to_environment_variables_use_case.dart';
import '../../../domain/use_cases/valid_working_directory_use_case.dart';
import 'create_shortcut_events.dart';
import 'create_shortcut_states.dart';

class CreateShortcutBloc
    extends Bloc<CreateShortcutEvent, CreateShortcutState> {
  final CreateShortcutUseCase _createShortcutUseCase;
  final ParseStringToCommandsUseCase _parseStringToCommandsUseCase;
  final ParseStringToEnvironmentVariablesUseCase
      _parseStringToEnvironmentVariablesUseCase;
  final ValidWorkingDirectoryUseCase _validWorkingDirectoryUseCase;

  ShortcutEntity _shortcut = const ShortcutEntity(
    id: -1,
    name: '',
    commands: [],
    environment: null,
    workingDirectory: null,
  );

  String commands = '';

  CreateShortcutBloc({
    required CreateShortcutUseCase createShortcutUseCase,
    required ParseStringToCommandsUseCase parseStringToCommandsUseCase,
    required ParseStringToEnvironmentVariablesUseCase
        parseStringToEnvironmentVariablesUseCase,
    required ValidWorkingDirectoryUseCase validWorkingDirectoryUseCase,
  })  : _createShortcutUseCase = createShortcutUseCase,
        _parseStringToCommandsUseCase = parseStringToCommandsUseCase,
        _parseStringToEnvironmentVariablesUseCase =
            parseStringToEnvironmentVariablesUseCase,
        _validWorkingDirectoryUseCase = validWorkingDirectoryUseCase,
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
    try {
      _shortcut = _shortcut.copyWith(
        name: event.name,
        commands: _parseStringToCommandsUseCase(event.commands ?? ''),
        workingDirectory: event.workingDirectory ?? _shortcut.workingDirectory,
        environment: event.environment != '' || event.environment != null ?
            _parseStringToEnvironmentVariablesUseCase(event.environment ?? '') : _shortcut.environment,
      );
    } catch (_) {
      emit(const InvalidShortcutEnviromentVariables());
    } finally {
      emit(
        CreateShortcutImcomplete(
          name: event.name,
          commands: event.commands,
          workingDirectory: event.workingDirectory,
          environment: event.environment,
        ),
      );
    }
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

      if (await _validWorkingDirectoryUseCase(
          _shortcut.workingDirectory ?? '')) {
        emit(
          const InvalidShortcutWorkingDirectory(),
        );
        return;
      }

      _shortcut = await _createShortcutUseCase(_shortcut);

      emit(
        CreateShortcutComplete(
          name: _shortcut.name,
          commands: _shortcut.commands.join(' '),
          workingDirectory: _shortcut.workingDirectory,
          environment: _shortcut.environment
              ?.map((key, value) => MapEntry(key, value))
              .values
              .join(', '),
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
      environment: null,
      workingDirectory: null,
    );

    emit(
      CreateShortcutImcomplete(
        name: _shortcut.name,
        commands: _shortcut.commands.join(' '),
        workingDirectory: _shortcut.workingDirectory,
        environment: _shortcut.environment
            ?.map((key, value) => MapEntry(key, value))
            .values
            .join(', '),
      ),
    );
  }
}
