import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';

import 'domain/entities/shortcut_entity.dart';
import 'domain/repositories/shortcuts_repository.dart';
import 'domain/use_cases/create_shortcut_use_case.dart';
import 'domain/use_cases/list_all_shurtcuts_use_case.dart';
import 'domain/use_cases/parse_string_to_commands_use_case.dart';
import 'domain/use_cases/parse_string_to_environment_variables_use_case.dart';
import 'domain/use_cases/remove_shortcut_use_case.dart';
import 'domain/use_cases/run_command_use_case.dart';
import 'domain/use_cases/update_shortcut_use_case.dart';
import 'domain/use_cases/valid_working_directory_use_case.dart';
import 'external/data_sources/local_shortcuts_data_source.dart';
import 'infra/data_sources/local_shortcuts_data_source.dart';
import 'infra/repositories/shortcuts_repository.dart';
import 'presenter/blocs/create_shortcut/create_shortcut_bloc.dart';
import 'presenter/blocs/list_shortcuts/list_shortcuts_bloc.dart';
import 'presenter/blocs/update_shortcut/update_shortcut_bloc.dart';
import 'presenter/blocs/view_shortcut/view_shortcut_bloc.dart';
import 'presenter/pages/create_shortcut/create_shortcut_page.dart';
import 'presenter/pages/edit_shortcut/edit_shortcut_page.dart';
import 'presenter/pages/list_shortcuts/list_shortcuts_page.dart';
import 'presenter/pages/view_shortcut/view_shortcut_page.dart';

class ShortcutsModule extends Module {
  @override
  void binds(i) {
    i.add<LocalShortcutsDataSource>(
      () => LocalShortcutsDataSourceImpl(
        boxShortcut: i.get<Box<ShortcutEntity>>(),
      ),
    );
    i.add<ShortcutsRepository>(
      () => ShortcutsRepositoryImpl(
        localShortcutsDataSource: i.get(),
      ),
    );
    i.add(
      () => ValidWorkingDirectoryUseCase(),
    );
    i.add(
      () => ParseStringToEnvironmentVariablesUseCase(),
    );
    i.add(
      () => ListAllShurtcutsUseCase(
        shortcutsRepository: i.get(),
      ),
    );
    i.add(
      () => CreateShortcutUseCase(
        shortcutsRepository: i.get(),
      ),
    );
    i.add(
      () => UpdateShortcutUseCase(
        shortcutsRepository: i.get(),
      ),
    );
    i.add(
      () => RemoveShortcutUseCase(
        shortcutsRepository: i.get(),
      ),
    );
    i.add(
      () => RunCommandUseCase(),
    );
    i.add(
      () => ParseStringToCommandsUseCase(),
    );
    i.addSingleton(
      () => ListShortcutsBloc(
        listAllShurtcutsUseCase: i.get(),
        removeShortcutUseCase: i.get(),
      ),
    );
    i.addSingleton(
      () => CreateShortcutBloc(
        createShortcutUseCase: i.get(),
        parseStringToCommandsUseCase: i.get(),
        parseStringToEnvironmentVariablesUseCase: i.get(),
        validWorkingDirectoryUseCase: i.get(),
      ),
    );
    i.addSingleton(
      () => UpdateShortcutBloc(
        updateShortcutUseCase: i.get(),
        parseStringToCommandsUseCase: i.get(),
        parseStringToEnvironmentVariablesUseCase: i.get(),
        validWorkingDirectoryUseCase: i.get(),
      ),
    );
    i.addSingleton(
      () => ViewShortcutBloc(
        runCommandUseCase: i.get(),
      ),
    );
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (_) => const ListShortcutsPage(),
    );
    r.child(
      '/edit/',
      child: (_) => const EditShortcutPage(),
    );
    r.child(
      '/create/',
      child: (_) => const CreateShortcutPage(),
    );
    r.child(
      '/view/',
      child: (_) => const ViewShortcutPage(),
    );
  }
}
