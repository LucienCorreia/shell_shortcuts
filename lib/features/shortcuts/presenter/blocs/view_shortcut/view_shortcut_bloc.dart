import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/shortcut_entity.dart';
import '../../../domain/use_cases/run_command_use_case.dart';
import 'view_shortcut_events.dart';
import 'view_shortcut_states.dart';

class ViewShortcutBloc extends Bloc<ViewShortcutEvent, ViewShortcutState> {
  final RunCommandUseCase _runCommandUseCase;

  ShortcutEntity? _shortcut;
  final List<String> _stdout = [];

  ViewShortcutBloc({
    required RunCommandUseCase runCommandUseCase,
  })  : _runCommandUseCase = runCommandUseCase,
        super(
          const NoShortcut(),
        ) {
    on<RunCommand>(
      (event, emit) => _runCommand(event, emit),
    );
    on<UpdateStdout>(
      (event, emit) => _updateStdout(event, emit),
    );
    on<SetShortcut>(
      (event, emit) => _setShortcut(event, emit),
    );
    on<ClearShortcut>(
      (event, emit) => _clearShortcut(event, emit),
    );
  }

  Future _runCommand(RunCommand event, Emitter<ViewShortcutState> emit) async {
    emit(RunningShortcut(_shortcut!));
    for (final command in _shortcut!.commands) {
      final result = await _runCommandUseCase(
        _shortcut!,
        command,
      );

      result.fold(
        (failure) {
          _stdout.add(failure);
          emit(
            FailedShortcut(_shortcut!, _stdout),
          );
        },
        (success) {
          _stdout.add(success);
          emit(
            FinishedShortcut(_shortcut!, _stdout),
          );
        },
      );
    }
  }

  void _setShortcut(SetShortcut event, Emitter<ViewShortcutState> emit) {
    _shortcut = event.shortcut;
    emit(
      NotExecutedShortcut(event.shortcut),
    );
  }

  void _clearShortcut(ClearShortcut event, Emitter<ViewShortcutState> emit) {
    _shortcut = null;
    _stdout.clear();
    emit(
      const NoShortcut(),
    );
  }

  void _updateStdout(UpdateStdout event, Emitter<ViewShortcutState> emit) {
    _stdout.add(event.text);
    emit(
      RunningShortcut(_shortcut!, _stdout),
    );
  }
}
