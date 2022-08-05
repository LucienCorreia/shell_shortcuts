import '../../../domain/entities/shortcut_entity.dart';

abstract class ListShortcutsState {
  const ListShortcutsState();
}

class ListAllShortcutsLoading extends ListShortcutsState {
  const ListAllShortcutsLoading();
}

class ListAllShortcutsLoaded extends ListShortcutsState {
  final List<ShortcutEntity> shortcuts;

  const ListAllShortcutsLoaded(this.shortcuts);
}

class ListAllShortcutsEmpty extends ListShortcutsState {
  const ListAllShortcutsEmpty();
}

class ListAllShortcutsFailure extends ListShortcutsState {
  final String message;

  const ListAllShortcutsFailure(this.message);
}
