import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../blocs/list_shortcuts/list_shortcuts_bloc.dart';
import '../../blocs/list_shortcuts/list_shortcuts_events.dart';
import '../../blocs/list_shortcuts/list_shortcuts_states.dart';
import '../../blocs/view_shortcut/view_shortcut_bloc.dart';
import '../../blocs/view_shortcut/view_shortcut_events.dart';

class ListShortcutsPage extends StatefulWidget {
  const ListShortcutsPage({super.key});

  @override
  State<ListShortcutsPage> createState() => _ListShortcutsPageState();
}

class _ListShortcutsPageState extends State<ListShortcutsPage> {
  final ListShortcutsBloc _listShortcutsBloc = Modular.get();
  final ViewShortcutBloc _viewShortcutBloc = Modular.get();

  @override
  void initState() {
    super.initState();

    _listShortcutsBloc.add(
      const ListAllShortcuts(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Shortcuts'),
      ),
      body: BlocBuilder<ListShortcutsBloc, ListShortcutsState>(
        builder: ((context, state) {
          if (state is ListAllShortcutsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ListAllShortcutsEmpty) {
            return const Center(
              child: Text('No shortcuts found'),
            );
          }

          if (state is ListAllShortcutsFailure) {
            return const Center(
              child: Text('Error loading shortcuts'),
            );
          }
          return ListView.builder(
            itemCount: (state as ListAllShortcutsLoaded).shortcuts.length,
            itemBuilder: (context, index) {
              final shortcut = state.shortcuts[index];
              return ListTile(
                title: Text(shortcut.name),
                leading: Text(shortcut.id.toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        _viewShortcutBloc.add(
                          SetShortcut(
                            shortcut,
                          ),
                        );

                        Modular.to.pushNamed('/shortcuts/view/');
                      },
                      icon: const Icon(
                        Icons.terminal,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.remove,
                      ),
                      onPressed: () => _listShortcutsBloc.add(
                        RemoveShortcut(
                          shortcut,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }),
        bloc: _listShortcutsBloc,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Modular.to.pushNamed('/shortcuts/create/'),
      ),
    );
  }
}
