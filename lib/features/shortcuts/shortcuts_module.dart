import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repositories/shortcuts_repository.dart';
import 'domain/use_cases/create_shortcut_use_case.dart';
import 'domain/use_cases/list_all_shurtcuts_use_case.dart';
import 'domain/use_cases/parse_string_to_commands_use_case.dart';
import 'domain/use_cases/remove_shortcut_use_case.dart';
import 'domain/use_cases/run_command_use_case.dart';
import 'external/data_sources/local_shortcuts_data_source.dart';
import 'infra/data_sources/local_shortcuts_data_source.dart';
import 'infra/repositories/shortcuts_repository.dart';
import 'presenter/blocs/create_shortcut/create_shortcut_bloc.dart';
import 'presenter/blocs/list_shortcuts/list_shortcuts_bloc.dart';
import 'presenter/blocs/view_shortcut/view_shortcut_bloc.dart';
import 'presenter/pages/create_shortcut/create_shortcut_page.dart';
import 'presenter/pages/list_shortcuts/list_shortcuts_page.dart';
import 'presenter/pages/view_shortcut/view_shortcut_page.dart';

class ShortcutsModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory<LocalShortcutsDataSource>(
          (i) => LocalShortcutsDataSourceImpl(
            boxShortcut: i.get(),
          ),
        ),
        Bind.factory<ShortcutsRepository>(
          (i) => ShortcutsRepositoryImpl(
            localShortcutsDataSource: i.get(),
          ),
        ),
        Bind.factory(
          (i) => ListAllShurtcutsUseCase(
            shortcutsRepository: i.get(),
          ),
        ),
        Bind.factory(
          (i) => CreateShortcutUseCase(
            shortcutsRepository: i.get(),
          ),
        ),
        Bind.factory(
          (i) => RemoveShortcutUseCase(
            shortcutsRepository: i.get(),
          ),
        ),
        Bind.factory(
          (i) => RunCommandUseCase(),
        ),
        Bind.factory(
          (i) => ParseStringToCommandsUseCase(),
        ),
        Bind.singleton(
          (i) => ListShortcutsBloc(
            listAllShurtcutsUseCase: i.get(),
            removeShortcutUseCase: i.get(),
          ),
        ),
        Bind.singleton(
          (i) => CreateShortcutBloc(
            createShortcutUseCase: i.get(),
            parseStringToCommandsUseCase: i.get(),
          ),
        ),
        Bind.singleton(
          (i) => ViewShortcutBloc(
            runCommandUseCase: i.get(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, __) => const ListShortcutsPage(),
        ),
        ChildRoute(
          '/create/',
          child: (_, __) => const CreateShortcutPage(),
        ),
        ChildRoute(
          '/view/',
          child: (_, __) => const ViewShortcutPage(),
        ),
      ];
}
