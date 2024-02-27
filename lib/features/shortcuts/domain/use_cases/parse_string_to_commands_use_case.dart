import '../entities/command_entity.dart';

class ParseStringToCommandsUseCase {
  List<CommandEntity> call(String value) {
    final commandsAndArguments = <String, List<String>>{};

    final commands = value.split('\n');

    for (final command in commands) {
      final commandAndArguments = command.split(' ');
      commandsAndArguments.addAll({
        commandAndArguments[0]: commandAndArguments.sublist(1),
      });
    }

    return commandsAndArguments.entries
        .map((x) => CommandEntity(
              id: -1,
              command: x.key,
              arguments: x.value,
            ))
        .toList();
  }
}
