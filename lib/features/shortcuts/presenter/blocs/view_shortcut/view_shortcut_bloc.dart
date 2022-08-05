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
      (event, emit) async => await _runCommand(event, emit),
    );
    on<SetShortcut>(
      (event, emit) => _setShortcut(event, emit),
    );
    on<ClearShortcut>(
      (event, emit) => _clearShortcut(event, emit),
    );
  }

  Future<void> _runCommand(
      RunCommand event, Emitter<ViewShortcutState> emit) async {
    await _runCommandUseCase(
      _shortcut!,
      (data) {
        _stdout.add(data);
        emit(FinishedShortcut(_shortcut!, _stdout));
      },
      (error) {
        _stdout.add(error);
        emit(FailedShortcut(_shortcut!, _stdout));
      },
      (() => emit(
            RunningShortcut(
              _shortcut!,
              _stdout,
            ),
          )),
    );
  }

  void _setShortcut(SetShortcut event, Emitter<ViewShortcutState> emit) {
    _shortcut = event.shortcut;
    emit(NotExecutedShortcut(event.shortcut));
  }

  void _clearShortcut(ClearShortcut event, Emitter<ViewShortcutState> emit) {
    _shortcut = null;
    _stdout.clear();
    emit(const NoShortcut());
  }
}
