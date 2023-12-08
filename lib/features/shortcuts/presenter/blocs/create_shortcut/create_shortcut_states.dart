abstract class CreateShortcutState {
  const CreateShortcutState();
}

class CreateShortcutInitial extends CreateShortcutState {
  const CreateShortcutInitial();
}

class CreateShortcutImcomplete extends CreateShortcutState {
  final String? name;
  final String? commands;
  final String? workingDirectory;
  final String? environment;

  const CreateShortcutImcomplete({
    this.name,
    this.commands,
    this.workingDirectory,
    this.environment,
  });
}

class CreateShortcutComplete extends CreateShortcutState {
  final String name;
  final String commands;
  final String? workingDirectory;
  final String? environment;

  const CreateShortcutComplete({
    required this.name,
    required this.commands,
    required this.workingDirectory,
    required this.environment,
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

class InvalidShortcutEnviromentVariables extends CreateShortcutState {
  final String message = 'Shortcut enviroment variables is invalid. Use the format "KEY1=VALUE, KEY2=VALUE"';

  const InvalidShortcutEnviromentVariables();
}

class InvalidShortcutWorkingDirectory extends CreateShortcutState {
  final String message = 'Shortcut working directory is invalid';

  const InvalidShortcutWorkingDirectory();
}
