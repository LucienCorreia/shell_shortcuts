abstract class CreateShortcutState {
  const CreateShortcutState();
}

class CreateShortcutInitial extends CreateShortcutState {
  const CreateShortcutInitial();
}

class CreateShortcutImcomplete extends CreateShortcutState {
  final String? name;
  final String? commands;

  const CreateShortcutImcomplete({
    this.name,
    this.commands,
  });
}

class CreateShortcutComplete extends CreateShortcutState {
  final String name;
  final String commands;

  const CreateShortcutComplete({
    required this.name,
    required this.commands,
  });
}

class CreateShortcutFailure extends CreateShortcutState {
  final String message;

  const CreateShortcutFailure(this.message);
}

class InvalidShortcutName extends CreateShortcutState {
  final String message = 'Shurtcut name is required';

  const InvalidShortcutName();
}

class InvalidShortcutCommands extends CreateShortcutState {
  final String message = 'Shortcut commands is required';

  const InvalidShortcutCommands();
}
