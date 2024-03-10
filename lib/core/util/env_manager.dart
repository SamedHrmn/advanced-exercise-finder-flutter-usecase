import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvManager {
  const EnvManager._();

  static DotEnv? _env;

  static DotEnv get env {
    if (_env != null) {
      return _env!;
    } else {
      throw Exception('env not initialized');
    }
  }

  static Future<void> init() async {
    _env = DotEnv();
    await env.load();
  }
}
