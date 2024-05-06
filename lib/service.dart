class ApiService {
  static const String baseUrlLocal = 'http://10.0.2.2:3000';
  static const String baseUrlRemote = "http://192.168.1.6:3000";

  bool useLocal = true; // Set this to false to use the remote URL

  String get baseUrl => useLocal ? baseUrlLocal : baseUrlRemote;
}
