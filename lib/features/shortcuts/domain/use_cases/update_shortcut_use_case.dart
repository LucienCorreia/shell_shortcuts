import '../entities/shortcut_entity.dart';
import '../repositories/shortcuts_repository.dart';

class UpdateShortcutUseCase {
  final ShortcutsRepository _shortcutsRepository;

  const UpdateShortcutUseCase({
    required ShortcutsRepository shortcutsRepository,
  }) : _shortcutsRepository = shortcutsRepository;

  Future<ShortcutEntity> call(ShortcutEntity shortcut) async {
    return await _shortcutsRepository.updateShortcut(shortcut);
  }
}
