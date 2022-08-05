import '../entities/shortcut_entity.dart';
import '../repositories/shortcuts_repository.dart';

class ListAllShurtcutsUseCase {
  final ShortcutsRepository _shortcutsRepository;

  const ListAllShurtcutsUseCase({
    required ShortcutsRepository shortcutsRepository,
  }) : _shortcutsRepository = shortcutsRepository;

  Future<List<ShortcutEntity>> call() async {
    return await _shortcutsRepository.getAllShortcuts();
  }
}
