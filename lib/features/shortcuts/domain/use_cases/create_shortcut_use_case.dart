import '../entities/shortcut_entity.dart';
import '../repositories/shortcuts_repository.dart';

class CreateShortcutUseCase {
  final ShortcutsRepository _shortcutsRepository;

  const CreateShortcutUseCase({
    required ShortcutsRepository shortcutsRepository,
  }) : _shortcutsRepository = shortcutsRepository;

  Future<ShortcutEntity> call(ShortcutEntity shortcut) async {
    return await _shortcutsRepository.createShortcut(shortcut);
  }
}
