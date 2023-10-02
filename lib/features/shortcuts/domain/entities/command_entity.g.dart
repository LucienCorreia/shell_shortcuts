// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'command_entity.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CommandEntityCWProxy {
  CommandEntity arguments(List<String> arguments);

  CommandEntity command(String command);

  CommandEntity id(int id);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CommandEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CommandEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  CommandEntity call({
    List<String>? arguments,
    String? command,
    int? id,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCommandEntity.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCommandEntity.copyWith.fieldName(...)`
class _$CommandEntityCWProxyImpl implements _$CommandEntityCWProxy {
  final CommandEntity _value;

  const _$CommandEntityCWProxyImpl(this._value);

  @override
  CommandEntity arguments(List<String> arguments) => this(arguments: arguments);

  @override
  CommandEntity command(String command) => this(command: command);

  @override
  CommandEntity id(int id) => this(id: id);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CommandEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CommandEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  CommandEntity call({
    Object? arguments = const $CopyWithPlaceholder(),
    Object? command = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
  }) {
    return CommandEntity(
      arguments: arguments == const $CopyWithPlaceholder() || arguments == null
          ? _value.arguments
          // ignore: cast_nullable_to_non_nullable
          : arguments as List<String>,
      command: command == const $CopyWithPlaceholder() || command == null
          ? _value.command
          // ignore: cast_nullable_to_non_nullable
          : command as String,
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
    );
  }
}

extension $CommandEntityCopyWith on CommandEntity {
  /// Returns a callable class that can be used as follows: `instanceOfCommandEntity.copyWith(...)` or like so:`instanceOfCommandEntity.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CommandEntityCWProxy get copyWith => _$CommandEntityCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommandEntityAdapter extends TypeAdapter<CommandEntity> {
  @override
  final int typeId = 1;

  @override
  CommandEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CommandEntity(
      id: fields[0] as int,
      command: fields[1] as String,
      arguments: (fields[2] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, CommandEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.command)
      ..writeByte(2)
      ..write(obj.arguments);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommandEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
