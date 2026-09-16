import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instagram/screens/login_screen.dart';
import 'package:instagram/screens/profile_screen.dart';
import 'package:instagram/viewModels/auth_viewModel.dart';
import 'package:instagram/viewModels/home_viewModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final homeViewModel = HomeViewModel();
  final authViewModel = AuthViewModel();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    homeViewModel.addListener(homeListener);
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent * 0.9) {
        homeViewModel.loadNextPage();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkUserAuthentication();
    });
  }

  void homeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    homeViewModel.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Future<void> checkUserAuthentication() async {
    await authViewModel.checkAuthentication();
    if (!mounted) {
      return;
    }
    if (!authViewModel.isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        ),
      );
      return;
    }
    await homeViewModel.getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Instagram',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            fontFamily: 'cursive',
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: homeViewModel.getAllPosts,
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const ProfileScreen();
                  },
                ),
              ).then((value) {
                homeViewModel.getAllPosts();
              });
            },
            icon: const Icon(
              Icons.account_circle_outlined,
              size: 30,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: homeViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: scrollController,
              itemCount: homeViewModel.posts.length,
              itemBuilder: (context, index) {
                final post = homeViewModel.posts[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.grey.shade300,
                            child: Text(
                              post.name[0].toUpperCase(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            post.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 380,
                      color: Colors.grey.shade200,
                      child: Image.network(
                        post.postUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(Icons.broken_image, size: 40),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6, top: 5),
                      child: IconButton(
                        onPressed: homeViewModel.isLiking
                            ? null
                            : () async {
                                if (post.isLiked) {
                                  await homeViewModel.unlikePost(post.id);
                                  if (homeViewModel.errorMessage == null) {
                                    post.likes--;
                                    post.isLiked = false;
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: homeViewModel.errorMessage!,
                                    );
                                  }
                                } else {
                                  await homeViewModel.likePost(post.id);
                                  if (homeViewModel.errorMessage == null) {
                                    post.likes++;
                                    post.isLiked = true;
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: homeViewModel.errorMessage!,
                                    );
                                  }
                                }
                              },

                        icon: homeViewModel.isLiking
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Icon(
                                post.isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 28,
                                color: post.isLiked ? Colors.red : Colors.black,
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        post.likes.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                  ],
                );
              },
            ),
    );
  }
}
