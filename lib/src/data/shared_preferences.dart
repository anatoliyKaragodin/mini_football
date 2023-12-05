import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  /// Save url to local storage
  Future<void> setUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('url', url);
  }

  /// Load url from local storage
  getUrl() async {
    final prefs = await SharedPreferences.getInstance();
    final url = prefs.getString('url') ?? '';
    return url;
  }
}
