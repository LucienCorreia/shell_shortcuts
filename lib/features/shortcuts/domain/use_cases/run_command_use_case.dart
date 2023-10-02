import 'dart:convert';
import 'dart:io';

import '../entities/shortcut_entity.dart';

class RunCommandUseCase {
  Future<void> call(ShortcutEntity shortcut, void Function(String data) onData,
      void Function(String error) onError, void Function() onLoading) async {
    for (final command in shortcut.commands) {
      onLoading();
      try {
        final process = await Process.start(
          command.command,
          command.arguments,
          workingDirectory: shortcut.workingDirectory,
          runInShell: true,
        );
        final stdout = process.stdout;
        final stderr = process.stderr;
        final stdoutLines =
            stdout.transform(utf8.decoder).transform(const LineSplitter());
        final stderrLines =
            stderr.transform(utf8.decoder).transform(const LineSplitter());
        final stdoutLinesList = await stdoutLines.toList();
        final stderrLinesList = await stderrLines.toList();
        final stdoutString = stdoutLinesList.join('\n');
        final stderrString = stderrLinesList.join('\n');

        if (stdoutString.isNotEmpty) {
          onData('\n$stdoutString\n');
        }

        if (stderrString.isNotEmpty) {
          onError('\n$stderrString\n');
        }
      } catch (e) {
        onError('\n$e\n');
      }
    }
  }
}
