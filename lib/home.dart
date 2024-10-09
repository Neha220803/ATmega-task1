import 'package:flutter/material.dart';
import 'package:task1/model/posts.dart';
import 'Services/fetchAPI.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Task-1: API Calling"),
      ),
      body: FutureBuilder<List<Posts>>(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final datas = snapshot.data!;
            return ListView.builder(
              itemCount: datas.length,
              itemBuilder: (context, index) {
                final post = datas[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue[200],
                    child: Text(post.id.toString()),
                  ),
                  title: Text(post.title),
                  subtitle: Text(post.body),
                  trailing: Container(
                    color: Colors.blue,
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'UserId: ${post.userId}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
