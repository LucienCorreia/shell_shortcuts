abstract class UpdateShortcutState {
  const UpdateShortcutState();
}

class UpdateShortcutInitial extends UpdateShortcutState {
  const UpdateShortcutInitial();
}

class UpdateShortcutImcomplete extends UpdateShortcutState {
  final String? name;
  final String? commands;
  final String? workingDirectory;
  final String? environment;

  const UpdateShortcutImcomplete({
    this.name,
    this.commands,
    this.workingDirectory,
    this.environment,
  });
}

class UpdateShortcutComplete extends UpdateShortcutState {
  final String name;
  final String commands;
  final String? workingDirectory;
  final String? environment;

  const UpdateShortcutComplete({
    required this.name,
    required this.commands,
    required this.workingDirectory,
    required this.environment,
  });
}

class UpdateShortcutFailure extends UpdateShortcutState {
  final String message;

  const UpdateShortcutFailure(this.message);
}

class InvalidShortcutName extends UpdateShortcutState {
  final String message = 'Shurtcut name is required';

  const InvalidShortcutName();
}

class InvalidShortcutCommands extends UpdateShortcutState {
  final String message = 'Shortcut commands is required';

  const InvalidShortcutCommands();
}

class InvalidShortcutEnviromentVariables extends UpdateShortcutState {
  final String message = 'Shortcut enviroment variables is invalid. Use the format "KEY1=VALUE, KEY2=VALUE"';

  const InvalidShortcutEnviromentVariables();
}

class InvalidShortcutWorkingDirectory extends UpdateShortcutState {
  final String message = 'Shortcut working directory is invalid';

  const InvalidShortcutWorkingDirectory();
}
