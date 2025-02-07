
import 'package:blog_app_revision/core/common/widgets/loader.dart';
import 'package:blog_app_revision/core/theme/app_pallete.dart';
import 'package:blog_app_revision/core/utils/snack_bar.dart';
import 'package:blog_app_revision/features/blogs/domain/entities/blog.dart';
import 'package:blog_app_revision/features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:blog_app_revision/features/blogs/presentation/views/add_blog_view.dart';
import 'package:blog_app_revision/features/blogs/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogsView extends StatefulWidget {
  const BlogsView({super.key});

  @override
  State<BlogsView> createState() => _BlogsViewState();
}

class _BlogsViewState extends State<BlogsView> {
  late List<Blog> blogs;
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(GetBlogsEvent());
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Blog App'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(CupertinoIcons.add_circled),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddBlogView(),
                  ),(route)=>false,
                );
              })
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(listener: (context, state) {
        if (state is BlogFailure) {
          showSnackBar(context, state.errorMessage);
        }
      }, builder: (context, state) {
        if (state is BlogLoading) {
          return Loader();
        } else if (state is BlogsDisplaySuccess) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal:8.0),
            child: ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: BlogCard(
                    blog: state.blogs[index],
                    color:index % 2==0 ? AppPallete.gradient1: AppPallete.gradient2 ,
                  ),
                );
              },
            ),
          );
        }
        return Center(child: Text('No blogs found'));
      }),
    );
  }
}
