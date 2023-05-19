abstract class CreateShortcutEvent {
  const CreateShortcutEvent();
}

class UpdateShortcutProperties extends CreateShortcutEvent {
  final String? name;
  final String? commands;
  final String? workingDirectory;

  const UpdateShortcutProperties({
    this.name,
    this.commands,
    this.workingDirectory,
  });
}

class SaveShortcut extends CreateShortcutEvent {
  const SaveShortcut();
}

class ResetShortcutProperties extends CreateShortcutEvent {
  const ResetShortcutProperties();
}
