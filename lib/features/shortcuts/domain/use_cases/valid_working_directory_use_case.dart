import 'dart:io';

class ValidWorkingDirectoryUseCase {
  Future<bool> call(String workingDirectory) async {
    return await Directory(workingDirectory).exists();
  }
}
