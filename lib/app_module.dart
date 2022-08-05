import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';

import 'features/shortcuts/domain/entities/shortcut_entity.dart';
import 'features/shortcuts/shortcuts_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton<Box<ShortcutEntity>>(
          (i) => Hive.box<ShortcutEntity>('shortcuts'),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          '/shortcuts',
          module: ShortcutsModule(),
        ),
      ];
}
