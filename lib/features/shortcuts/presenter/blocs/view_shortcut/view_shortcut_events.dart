import '../../../domain/entities/shortcut_entity.dart';

abstract class ViewShortcutEvent {
  const ViewShortcutEvent();
}

class SetShortcut extends ViewShortcutEvent {
  final ShortcutEntity shortcut;

  const SetShortcut(this.shortcut);
}

class ClearShortcut extends ViewShortcutEvent {
  const ClearShortcut();
}

class RunCommand extends ViewShortcutEvent {
  const RunCommand();
}

class UpdateStdout extends ViewShortcutEvent {
  final String text;

  const UpdateStdout(this.text);
}
