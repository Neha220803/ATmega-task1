import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> datas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Task-1: API Calling"),
      ),
      body: datas.isEmpty
          ? const Center(
              child: Text(
                  "Click the floating button to view API data")) // Loading indicator
          : ListView.builder(
              itemCount: datas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                      backgroundColor: Colors.blue[200],
                      child: Text(datas[index]['id'].toString())),
                  title: Text(datas[index]['title']),
                  subtitle: Text(datas[index]['body']),
                  trailing: Container(
                      color: Colors.blue,
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'UserId:${datas[index]['userId'].toString()}',
                        style: const TextStyle(color: Colors.white),
                      )),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchData,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  void fetchData() async {
    const url = "https://jsonplaceholder.typicode.com/posts";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body);
      setState(() {
        datas = json;
      });
    }
  }
}
