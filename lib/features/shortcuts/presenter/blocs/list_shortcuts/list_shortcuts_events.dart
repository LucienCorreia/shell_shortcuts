import '../../../domain/entities/shortcut_entity.dart';

abstract class ListShortcutsEvent {
  const ListShortcutsEvent();
} 

class ListAllShortcuts extends ListShortcutsEvent {
  const ListAllShortcuts();
}

class RemoveShortcut extends ListShortcutsEvent {
  final ShortcutEntity shortcut;

  const RemoveShortcut(this.shortcut);
}
