import '../entities/shortcut_entity.dart';
import '../repositories/shortcuts_repository.dart';

class RemoveShortcutUseCase {
  final ShortcutsRepository _shortcutsRepository;

  const RemoveShortcutUseCase({
    required ShortcutsRepository shortcutsRepository,
  }) : _shortcutsRepository = shortcutsRepository;

  Future<void> call(ShortcutEntity shortcut) async {
    await _shortcutsRepository.removeShortcut(shortcut);
  }
}