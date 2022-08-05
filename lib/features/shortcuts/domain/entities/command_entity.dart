import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'command_entity.g.dart';

@CopyWith()
@HiveType(typeId: 1)
class CommandEntity extends Equatable {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String command;

  @HiveField(2)
  final List<String> arguments;

  const CommandEntity({
    required this.id,
    required this.command,
    required this.arguments,
  });

  @override
  List<Object?> get props => [
    id,
    command,
    arguments,
  ];

  String get commandWithArguments => '$command ${arguments.join(' ')}';
}
