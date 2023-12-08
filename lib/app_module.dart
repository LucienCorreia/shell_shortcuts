import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';

import 'features/shortcuts/domain/entities/shortcut_entity.dart';
import 'features/shortcuts/shortcuts_module.dart';

class AppModule extends Module {
  @override
  void binds(i) {
        i.addSingleton<Box<ShortcutEntity>>(
          () => Hive.box<ShortcutEntity>('shortcuts'),
        );
  }

  @override
  void routes(r) {
        r.module(
          '/shortcuts',
          module: ShortcutsModule(),
        );
  }
}
