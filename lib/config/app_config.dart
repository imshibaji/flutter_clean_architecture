import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  // Rapid Host Endpoint
  static String host = dotenv.get("API_HOST");
  static String key = dotenv.get("API_KEY");

  // Server Secrate Token
  static String token = 'Bearer ' + dotenv.get("API_TOKEN");
}
