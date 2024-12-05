import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../post.dart';


class PostController extends GetxController {
  // Observables
  var posts = <Post>[].obs;
  var isLoading = false.obs;

  // Fetch Posts
  Future<void> fetchPosts() async {
    isLoading(true); // Loading state true
    try {
      var url = Uri.parse("https://jsonplaceholder.typicode.com/albums/1/photos");
      final response = await http.get(url, headers: {"Content-Type": "application/json"});
      final List body = json.decode(response.body);
      posts.value = body.map((e) => Post.fromJson(e)).toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch posts");
    } finally {
      isLoading(false); // Loading state false
    }
  }
}
