import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import 'command_entity.dart';

part 'shortcut_entity.g.dart';

@CopyWith()
@HiveType(typeId: 0)
class ShortcutEntity extends Equatable {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<CommandEntity> commands;

  @HiveField(3)
  final String workingDirectory;

  const ShortcutEntity({
    required this.id,
    required this.name,
    required this.commands,
    required this.workingDirectory,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        commands,
        workingDirectory,
      ];

  String get nameWithCommands => '$name: ${commands.map((x) => x.commandWithArguments).join('\n')}';
}
