import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../blocs/list_shortcuts/list_shortcuts_bloc.dart';
import '../../blocs/list_shortcuts/list_shortcuts_events.dart';
import '../../blocs/update_shortcut/update_shortcut_bloc.dart';
import '../../blocs/update_shortcut/update_shortcut_events.dart';
import '../../blocs/update_shortcut/update_shortcut_states.dart';

class EditShortcutPage extends StatefulWidget {
  const EditShortcutPage({super.key});

  @override
  State<EditShortcutPage> createState() => _EditShortcutPageState();
}

class _EditShortcutPageState extends State<EditShortcutPage> {
  final UpdateShortcutBloc _updateShortcutBloc = Modular.get();
  final ListShortcutsBloc _listShortcutsBloc = Modular.get();

  @override
  void initState() {
    super.initState();

    _updateShortcutBloc.add(
      const UpdateShortcutProperties(),
    );

    _updateShortcutBloc.stream.listen((event) {});
  }

  @override
  void dispose() {
    _updateShortcutBloc.add(
      const ResetShortcutProperties(),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Shortcut'),
      ),
      body: BlocBuilder<UpdateShortcutBloc, UpdateShortcutState>(
        builder: (context, state) {
          if (state is UpdateShortcutComplete) {
            _listShortcutsBloc.add(
              const ListAllShortcuts(),
            );
            Future.delayed(
              const Duration(seconds: 1),
            ).then((_) {
              Modular.to.pop();
            });
            return const Center(
              child: Column(
                children: [
                  Text('Shortcut saved, return to listing...'),
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: MediaQuery.of(context).size.width * 0.1),
            child: Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      labelText: 'Name',
                    ),
                    initialValue: (state is UpdateShortcutImcomplete)
                        ? state.name : '',
                    onChanged: (value) {
                      _updateShortcutBloc.add(
                        UpdateShortcutProperties(name: value),
                      );
                    },
                    validator: (value) {
                      if (state is InvalidShortcutName) {
                        return state.message;
                      }

                      return '';
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      labelText: 'Working Directory',
                    ),
                    initialValue: (state is UpdateShortcutImcomplete) ? state.workingDirectory : '',
                    maxLines: null,
                    onChanged: (value) {
                      _updateShortcutBloc.add(
                        UpdateShortcutProperties(workingDirectory: value),
                      );
                    },
                    validator: (value) {
                      if (state is InvalidShortcutWorkingDirectory) {
                        return state.message;
                      }

                      return '';
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      labelText: 'Environment Variables',
                    ),
                    initialValue: (state is UpdateShortcutImcomplete) ? state.environment : '',
                    maxLines: null,
                    onChanged: (value) {
                      _updateShortcutBloc.add(
                        UpdateShortcutProperties(environment: value),
                      );
                    },
                    validator: (value) {
                      if (state is InvalidShortcutEnviromentVariables) {
                        return state.message;
                      }

                      return '';
                    },
                  ),
                  TextFormField(
                    minLines: 3,
                    maxLines: 999,
                    expands: false,
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      labelText: 'Command',
                    ),
                    initialValue: (state is UpdateShortcutImcomplete)
                            ? state.commands
                            : '',
                    onChanged: (value) {
                      _updateShortcutBloc.add(
                        UpdateShortcutProperties(commands: value),
                      );
                    },
                    validator: (value) {
                      if (state is InvalidShortcutCommands) {
                        return state.message;
                      }

                      return '';
                    },
                  ),
                  TextButton(
                    child: const Text('Save'),
                    onPressed: () {
                      _updateShortcutBloc.add(
                        const SaveShortcut(),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
        bloc: _updateShortcutBloc,
      ),
    );
  }
}
