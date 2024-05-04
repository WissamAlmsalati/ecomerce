import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipes/moudels/banner/banner_module.dart';

class BannerRepostry {
  final String serverUrl = 'http://your_server_url';

  Future<String> addBanner(BannerMoudule bannerMoudule) async {
    final response = await http.post(
      Uri.parse('$serverUrl/addBanner'),
      body: jsonEncode(bannerMoudule.toJson()),
      headers: {"Content-Type": "application/json"},
    );
    return jsonDecode(response.body)['id'];
  }

  Future<void> deleteBanner(String id) async {
    await http.delete(Uri.parse('$serverUrl/deleteBanner/$id'));
  }

  Future<void> updateBanner(String id, BannerMoudule bannerMoudule) async {
    await http.put(
      Uri.parse('$serverUrl/updateBanner/$id'),
      body: jsonEncode(bannerMoudule.toJson()),
      headers: {"Content-Type": "application/json"},
    );
  }

  Future<List<BannerMoudule>> fetchData() async {
    final response = await http.get(Uri.parse('$serverUrl/fetchData'));
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => BannerMoudule.fromJson(item)).toList();
  }
}