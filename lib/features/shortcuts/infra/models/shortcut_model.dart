import '../../domain/entities/shortcut_entity.dart';
import 'command_model.dart';

class ShortcutModel extends ShortcutEntity {
  const ShortcutModel({
    required super.id,
    required super.name,
    required super.commands,
    super.environment,
    super.workingDirectory,
  });

  factory ShortcutModel.fromJson(Map<String, dynamic> json) {
    return ShortcutModel(
      id: json['id'],
      name: json['name'],
      commands: List<CommandModel>.from(
        json['commands']?.map((x) => CommandModel.fromJson(x)) ?? [],
      ),
      environment: json['enviroment'],
      workingDirectory: json['workingDirectory'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'commands': List<CommandModel>.from(commands.map((x) => CommandModel.fromEntity(x).toJson())),
      'enviroment': environment,
      'workingDirectory': workingDirectory,
    };
  }
}
