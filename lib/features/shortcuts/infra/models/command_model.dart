import '../../domain/entities/command_entity.dart';

class CommandModel extends CommandEntity {
  const CommandModel({
    required super.id,
    required super.command,
    required super.arguments,
  });

  factory CommandModel.fromJson(Map<String, dynamic> json) {
    return CommandModel(
      id: json['id'],
      command: json['command'],
      arguments: json['arguments'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'command': command,
      'arguments': arguments,
    };
  }

  factory CommandModel.fromEntity(CommandEntity entity) {
    return CommandModel(
      id: entity.id,
      command: entity.command,
      arguments: entity.arguments,
    );
  }
}
