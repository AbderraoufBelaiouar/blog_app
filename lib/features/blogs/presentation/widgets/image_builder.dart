import 'package:blog_app_revision/core/network/connection_checker.dart';
import 'package:blog_app_revision/features/blogs/domain/entities/blog.dart';
import 'package:blog_app_revision/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
// Import your service locator and blog model as needed.

class ImageBuilder extends StatelessWidget {
  const ImageBuilder({
    super.key,
    required this.blog,
  });

  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: serviceLocator<ConnectionChecker>().isConnected, // Your connectivity check
      builder: (context, snapshot) {
        // While waiting for the connectivity result, show a progress indicator
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // If there was an error checking connectivity, show an error icon
        if (snapshot.hasError) {
          return const Center(child: Icon(Icons.error));
        }

        // When complete, check the connectivity status
        final isConnected = snapshot.data ?? false;

        if (!isConnected) {
          // If there is no internet connection, display an error icon
          return const Center(child: Icon(Icons.error));
        }

        // If connected, show the image using CachedNetworkImage
        return Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: blog.imageUrl,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error),
            ),
          ),
        );
      },
    );
  }
}
