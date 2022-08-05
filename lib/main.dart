import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app_module.dart';
import 'app_widget.dart';
import 'features/shortcuts/domain/entities/command_entity.dart';
import 'features/shortcuts/domain/entities/shortcut_entity.dart';

void main() async {
  Hive.registerAdapter(ShortcutEntityAdapter());
  Hive.registerAdapter(CommandEntityAdapter());
  await Hive.initFlutter();
  await Hive.openBox<ShortcutEntity>('shortcuts');
  // await Hive.deleteBoxFromDisk('shortcuts');
  Modular.setInitialRoute('/shortcuts/');

  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
