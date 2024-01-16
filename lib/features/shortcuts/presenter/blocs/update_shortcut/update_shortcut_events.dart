import '../../../domain/entities/shortcut_entity.dart';

abstract class UpdateShortcutEvent {
  const UpdateShortcutEvent();
}

class SetShortcutToEdit extends UpdateShortcutEvent {
  final ShortcutEntity shortcut;

  const SetShortcutToEdit(this.shortcut);
}

class UpdateShortcutProperties extends UpdateShortcutEvent {
  final String? name;
  final String? commands;
  final String? workingDirectory;
  final String? environment;

  const UpdateShortcutProperties({
    this.name,
    this.commands,
    this.workingDirectory,
    this.environment,
  });
}

class SaveShortcut extends UpdateShortcutEvent {
  const SaveShortcut();
}

class ResetShortcutProperties extends UpdateShortcutEvent {
  const ResetShortcutProperties();
}
