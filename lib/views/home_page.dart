import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/post_controller.dart';

class MyHomePage extends StatelessWidget {
  final PostController postController = Get.put(PostController()); // Controller Initialization

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch posts on load
    postController.fetchPosts();

    return Scaffold(
      appBar: AppBar(title: const Text("GetX Example")),
      body: Obx(() {
        if (postController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (postController.posts.isEmpty) {
          return const Center(child: Text("No data available"));
        } else {
          return ListView.builder(
            itemCount: postController.posts.length,
            itemBuilder: (context, index) {
              final post = postController.posts[index];
              return Container(
                color: Colors.grey.shade300,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                height: 100,
                width: double.maxFinite,
                child: Row(
                  children: [
                    Expanded(flex: 1, child: Image.network(post.url!)),
                    const SizedBox(width: 10),
                    Expanded(flex: 3, child: Text(post.title!)),
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }
}
