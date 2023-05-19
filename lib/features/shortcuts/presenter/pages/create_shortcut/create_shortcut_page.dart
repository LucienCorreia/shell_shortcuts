import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../blocs/create_shortcut/create_shortcut_bloc.dart';
import '../../blocs/create_shortcut/create_shortcut_events.dart';
import '../../blocs/create_shortcut/create_shortcut_states.dart';
import '../../blocs/list_shortcuts/list_shortcuts_bloc.dart';
import '../../blocs/list_shortcuts/list_shortcuts_events.dart';

class CreateShortcutPage extends StatefulWidget {
  const CreateShortcutPage({Key? key})
      : super(
          key: key,
        );

  @override
  State<CreateShortcutPage> createState() => _CreateShortcutPageState();
}

class _CreateShortcutPageState extends State<CreateShortcutPage> {
  final CreateShortcutBloc _createShortcutBloc = Modular.get();
  final ListShortcutsBloc _listShortcutsBloc = Modular.get();

  @override
  void initState() {
    super.initState();

    _createShortcutBloc.add(
      const UpdateShortcutProperties(),
    );

    _createShortcutBloc.stream.listen((event) {});
  }

  @override
  void dispose() {
    _createShortcutBloc.add(
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
      body: BlocBuilder<CreateShortcutBloc, CreateShortcutState>(
        builder: (context, state) {
          if (state is CreateShortcutComplete) {
            _listShortcutsBloc.add(
              const ListAllShortcuts(),
            );
            Future.delayed(
              const Duration(seconds: 1),
            ).then((_) {
              Modular.to.pop();
            });
            return Center(
              child: Column(
                children: const [
                  Text('Shortcut created, return to listing...'),
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
                    initialValue: (state is CreateShortcutInitial)
                        ? ''
                        : (state is CreateShortcutImcomplete)
                            ? state.name
                            : '',
                    onChanged: (value) {
                      _createShortcutBloc.add(
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
                    initialValue: (state is CreateShortcutInitial)
                        ? ''
                        : (state is CreateShortcutImcomplete)
                            ? state.workingDirectory
                            : '',
                    onChanged: (value) {
                      _createShortcutBloc.add(
                        UpdateShortcutProperties(workingDirectory: value),
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
                    minLines: 3,
                    maxLines: 999,
                    expands: false,
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      labelText: 'Command',
                    ),
                    initialValue: (state is CreateShortcutInitial)
                        ? ''
                        : (state is CreateShortcutImcomplete)
                            ? state.commands
                            : '',
                    onChanged: (value) {
                      _createShortcutBloc.add(
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
                    child: const Text('Create'),
                    onPressed: () {
                      _createShortcutBloc.add(
                        const SaveShortcut(),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
        bloc: _createShortcutBloc,
      ),
    );
  }
}
