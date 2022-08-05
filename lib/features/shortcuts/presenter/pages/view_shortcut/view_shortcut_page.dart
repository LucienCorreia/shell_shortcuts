import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../blocs/view_shortcut/view_shortcut_bloc.dart';
import '../../blocs/view_shortcut/view_shortcut_events.dart';
import '../../blocs/view_shortcut/view_shortcut_states.dart';

class ViewShortcutPage extends StatefulWidget {
  const ViewShortcutPage({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  State<ViewShortcutPage> createState() => _ViewShortcutPageState();
}

class _ViewShortcutPageState extends State<ViewShortcutPage> {
  final ViewShortcutBloc _viewShortcutBloc = Modular.get();

  @override
  void dispose() {
    _viewShortcutBloc.add(
      const ClearShortcut(),
    );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewShortcutBloc, ViewShortcutState>(
      bloc: _viewShortcutBloc,
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text((state is HasShortcut) ? state.shortcut.name : ''),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: MediaQuery.of(context).size.width * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Script: \n${(state is HasShortcut) ? state.shortcut.nameWithCommands : ''}'),
                    Chip(
                      label: Text(
                        (state is NotExecutedShortcut) ? 'Not Executed' : (state is RunningShortcut) ? 'Running...' : (state is FailedShortcut) ? 'Fail' : 'Done',
                      ),
                      backgroundColor: (state is NotExecutedShortcut) ? Colors.grey : (state is RunningShortcut)
                          ? Colors.yellow : (state is FailedShortcut)
                          ? Colors.red : Colors.green,
                    ),
                  ],
                ),
                const Divider(),
                if (state is HasShortcut)
                  Text.rich(
                    TextSpan(
                      text: 'Output: \n',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      children:
                          state.stdout.map((e) => TextSpan(text: e)).toList(),
                    ),
                    textAlign: TextAlign.justify,
                  ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: (state is RunningShortcut)
              ? const Icon(Icons.block)
              : const Icon(Icons.terminal),
          onPressed: () {
            if (state is RunningShortcut) {
              return;
            } else {
              _viewShortcutBloc.add(
                const RunCommand(),
              );
            }
          },
        ),
      ),
    );
  }
}
