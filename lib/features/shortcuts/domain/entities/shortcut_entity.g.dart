// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shortcut_entity.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ShortcutEntityCWProxy {
  ShortcutEntity commands(List<CommandEntity> commands);

  ShortcutEntity id(int id);

  ShortcutEntity name(String name);

  ShortcutEntity workingDirectory(String workingDirectory);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ShortcutEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ShortcutEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  ShortcutEntity call({
    List<CommandEntity>? commands,
    int? id,
    String? name,
    String? workingDirectory,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfShortcutEntity.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfShortcutEntity.copyWith.fieldName(...)`
class _$ShortcutEntityCWProxyImpl implements _$ShortcutEntityCWProxy {
  final ShortcutEntity _value;

  const _$ShortcutEntityCWProxyImpl(this._value);

  @override
  ShortcutEntity commands(List<CommandEntity> commands) =>
      this(commands: commands);

  @override
  ShortcutEntity id(int id) => this(id: id);

  @override
  ShortcutEntity name(String name) => this(name: name);

  @override
  ShortcutEntity workingDirectory(String workingDirectory) =>
      this(workingDirectory: workingDirectory);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ShortcutEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ShortcutEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  ShortcutEntity call({
    Object? commands = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? workingDirectory = const $CopyWithPlaceholder(),
  }) {
    return ShortcutEntity(
      commands: commands == const $CopyWithPlaceholder() || commands == null
          ? _value.commands
          // ignore: cast_nullable_to_non_nullable
          : commands as List<CommandEntity>,
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      workingDirectory: workingDirectory == const $CopyWithPlaceholder() ||
              workingDirectory == null
          ? _value.workingDirectory
          // ignore: cast_nullable_to_non_nullable
          : workingDirectory as String,
    );
  }
}

extension $ShortcutEntityCopyWith on ShortcutEntity {
  /// Returns a callable class that can be used as follows: `instanceOfShortcutEntity.copyWith(...)` or like so:`instanceOfShortcutEntity.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ShortcutEntityCWProxy get copyWith => _$ShortcutEntityCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShortcutEntityAdapter extends TypeAdapter<ShortcutEntity> {
  @override
  final int typeId = 0;

  @override
  ShortcutEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShortcutEntity(
      id: fields[0] as int,
      name: fields[1] as String,
      commands: (fields[2] as List).cast<CommandEntity>(),
      workingDirectory: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ShortcutEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.commands)
      ..writeByte(3)
      ..write(obj.workingDirectory);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShortcutEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
