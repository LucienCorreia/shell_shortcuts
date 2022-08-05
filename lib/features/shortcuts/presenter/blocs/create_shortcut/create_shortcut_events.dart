abstract class CreateShortcutEvent {
  const CreateShortcutEvent();
}

class UpdateShortcutProperties extends CreateShortcutEvent {
  final String? name;
  final String? commands;

  const UpdateShortcutProperties({
    this.name,
    this.commands,
  });
}

class SaveShortcut extends CreateShortcutEvent {
  const SaveShortcut();
}

class ResetShortcutProperties extends CreateShortcutEvent {
  const ResetShortcutProperties();
}
