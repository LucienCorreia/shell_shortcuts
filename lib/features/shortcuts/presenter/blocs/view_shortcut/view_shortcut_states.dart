import '../../../domain/entities/shortcut_entity.dart';

abstract class ViewShortcutState {
  const ViewShortcutState();
}

class HasShortcut extends ViewShortcutState {
  final ShortcutEntity shortcut;
  final List<String> stdout;

  const HasShortcut(
    this.shortcut, [
    this.stdout = const [],
  ]);
}

class NoShortcut extends ViewShortcutState {
  const NoShortcut();
}

class RunningShortcut extends HasShortcut {
  const RunningShortcut(
    super.shortcut, [
    super.stdout = const [],
  ]);
}

class FinishedShortcut extends HasShortcut {
  const FinishedShortcut(
    super.shortcut, [
    super.stdout = const [],
  ]);
}

class FailedShortcut extends HasShortcut {
  const FailedShortcut(
    super.shortcut, [
    super.stdout = const [],
  ]);
}

class NotExecutedShortcut extends HasShortcut {
  const NotExecutedShortcut(
    super.shortcut, [
    super.stdout = const [],
  ]);
}
