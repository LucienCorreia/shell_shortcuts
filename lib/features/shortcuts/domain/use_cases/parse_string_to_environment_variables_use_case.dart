class ParseStringToEnvironmentVariablesUseCase {
  Map<String, String>? call(String environment) {
    final result = <String, String>{};

    final splitedKeyValue = environment.split(',');

    for (final keyValue in splitedKeyValue) {
      final splited = keyValue.split('=');
      if (splited.length == 2) {
        result[splited[0]] = splited[1];
      }
    }

    if (result.isEmpty) {
      return null;
    }

    return result;
  }
}
