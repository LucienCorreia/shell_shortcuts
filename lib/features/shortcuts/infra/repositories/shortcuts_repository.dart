import '../../domain/entities/shortcut_entity.dart';
import '../../domain/repositories/shortcuts_repository.dart';
import '../data_sources/local_shortcuts_data_source.dart';

class ShortcutsRepositoryImpl implements ShortcutsRepository {
  final LocalShortcutsDataSource _localShortcutsDataSource;

  const ShortcutsRepositoryImpl({
    required LocalShortcutsDataSource localShortcutsDataSource,
  }) : _localShortcutsDataSource = localShortcutsDataSource;

  @override
  Future<ShortcutEntity> createShortcut(ShortcutEntity shortcut) async {
    return await _localShortcutsDataSource.createShortcut(shortcut);
  }

  @override
  Future<ShortcutEntity> updateShortcut(ShortcutEntity shortcut) async {
    return await _localShortcutsDataSource.updateShortcut(shortcut);
  }

  @override
  Future<List<ShortcutEntity>> getAllShortcuts() async {
    return await _localShortcutsDataSource.getAllShortcuts();
  }

  @override
  Future<void> removeShortcut(ShortcutEntity shortcut) async {
    await _localShortcutsDataSource.removeShortcut(shortcut);
  }
}