import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:task1/model/posts.dart';

Future<List<Posts>> fetchPosts() async {
  const url = "https://jsonplaceholder.typicode.com/posts";
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  List<dynamic> jsonData = jsonDecode(response.body);
  return jsonData.map((item) => Posts.fromJson(item)).toList();
}
