import 'package:flutter/services.dart' show rootBundle;

class Env {
  static Env? _instance;
  late Map<String, String> _environment;

  static Env get instance {
    _instance ??= Env._();
    return _instance!;
  }

  Env._();

  Future<void> load() async {
    _environment = await parseStringToMap();
  }

  Future<Map<String, String>> parseStringToMap({String assetsFileName = '.env'}) async {
    final content = await rootBundle.loadString(assetsFileName);
    Map<String, String> environment = {};
    for (String line in content.split('\n')) {
      line = line.trim();
      if (line.contains('=') && !line.startsWith(RegExp(r'=|#'))) {
        List<String> contents = line.split('=');
        environment[contents[0]] = contents.sublist(1).join('=');
      }
    }
    return environment;
  }

  String? get(String key) {
    return _environment[key];
  }
}
