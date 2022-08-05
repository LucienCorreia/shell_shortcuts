import '../entities/shortcut_entity.dart';

abstract class ShortcutsRepository {
  Future<List<ShortcutEntity>> getAllShortcuts();
  Future<ShortcutEntity> createShortcut(ShortcutEntity shortcut);
  Future<void> removeShortcut(ShortcutEntity shortcut);
}
