import 'dart:convert';
import 'dart:io';

import 'package:either_dart/either.dart';

import '../entities/command_entity.dart';
import '../entities/shortcut_entity.dart';

class RunCommandUseCase {
  Future<Either<String, String>> call(
    ShortcutEntity shortcut,
    CommandEntity command,
  ) async {
      try {
        final process = await Process.start(
          command.command,
          command.arguments,
          workingDirectory: shortcut.workingDirectory,
          environment: shortcut.environment,
          runInShell: true,
        );

        final stdout = process.stdout.asBroadcastStream();
        final stderr = process.stderr.asBroadcastStream();
        final stdoutLines =
            stdout.transform(utf8.decoder).transform(const LineSplitter());
        final stderrLines =
            stderr.transform(utf8.decoder).transform(const LineSplitter());
        final stdoutLinesList = await stdoutLines.toList();
        final stderrLinesList = await stderrLines.toList();
        final stdoutString = stdoutLinesList.join('\n');
        final stderrString = stderrLinesList.join('\n');

        if (stdoutString.isNotEmpty) {
          return Right('\n$stdoutString\n');
        }

        if(stderrString.isNotEmpty && await process.exitCode != 0) {
          return Left('\n$stderrString\n');
        } else {
          return Right('\n$stderrString\n');
        }


      } catch (e, stack) {
        return Left('\n$e\n$stack\n');
      }
  }
}
