import 'package:hive/hive.dart';

import '../../domain/entities/shortcut_entity.dart';
import '../../infra/data_sources/local_shortcuts_data_source.dart';

class LocalShortcutsDataSourceImpl implements LocalShortcutsDataSource {
  final Box<ShortcutEntity> _boxShortcut;

  const LocalShortcutsDataSourceImpl({
    required Box<ShortcutEntity> boxShortcut,
  }) : _boxShortcut = boxShortcut;

  @override
  Future<ShortcutEntity> createShortcut(ShortcutEntity shortcut) async {
    if (_boxShortcut.isEmpty) {
      shortcut = shortcut.copyWith(id: 1);
    } else {
      shortcut = shortcut.copyWith(id: _boxShortcut.values.last.id + 1);
    }

    await _boxShortcut.add(shortcut);

    return shortcut;
  }

  @override
  Future<ShortcutEntity> updateShortcut(ShortcutEntity shortcut) async {
    final index = _boxShortcut.values
        .toList()
        .indexWhere((element) => element.id == shortcut.id);

    await _boxShortcut.putAt(index, shortcut);

    return shortcut;
  }

  @override
  Future<List<ShortcutEntity>> getAllShortcuts() async {
    return _boxShortcut.values.toList();
  }

  @override
  Future<void> removeShortcut(ShortcutEntity shortcut) async {
    final index = _boxShortcut.values.toList().indexOf(shortcut);

    await _boxShortcut.deleteAt(index);

    await _reorganize();
  }

  Future<void> _reorganize() async {
    final list = _boxShortcut.values.toList();

    for (var i = 0; i < list.length; i++) {
      list[i] = list[i].copyWith(id: i + 1);
    }

    await _boxShortcut.clear();
    await _boxShortcut.addAll(list);
  }
}
