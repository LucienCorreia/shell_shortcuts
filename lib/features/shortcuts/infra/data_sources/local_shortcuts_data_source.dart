import '../../domain/entities/shortcut_entity.dart';

abstract class LocalShortcutsDataSource {
  Future<List<ShortcutEntity>> getAllShortcuts();
  Future<ShortcutEntity> createShortcut(ShortcutEntity shortcut);
  Future<void> removeShortcut(ShortcutEntity shortcut);
}