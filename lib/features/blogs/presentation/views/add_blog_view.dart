import 'dart:io';

import 'package:blog_app_revision/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app_revision/core/common/widgets/loader.dart';
import 'package:blog_app_revision/core/theme/app_pallete.dart';
import 'package:blog_app_revision/core/utils/pick_image.dart';
import 'package:blog_app_revision/core/utils/snack_bar.dart';
import 'package:blog_app_revision/features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:blog_app_revision/features/blogs/presentation/widgets/blog_editor.dart';
import 'package:blog_app_revision/features/blogs/presentation/widgets/categories_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBlogView extends StatefulWidget {
  const AddBlogView({super.key});

  @override
  State<AddBlogView> createState() => _AddBlogViewState();
}

class _AddBlogViewState extends State<AddBlogView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedTopics = [];
  File? imageFile;
  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        imageFile = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Add Blog',
          ),
          actions: [
            IconButton(
                icon: Icon(
                  CupertinoIcons.checkmark_circle,
                ),
                onPressed: () {
                  uploadBlog();
                }),
          ]),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogUploadSuccess) {
            Navigator.pop(context);
          } else if (state is BlogFailure) {
            showSnackBar(context, state.errorMessage);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return Loader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: 20,
                  children: [
                    imageFile != null
                        ? GestureDetector(
                            onTap: selectImage,
                            child: SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  imageFile!,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              selectImage();
                            },
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: Radius.circular(10),
                              color: AppPallete.bordercolor,
                              dashPattern: [10, 4],
                              strokeCap: StrokeCap.round,
                              child: Container(
                                padding: EdgeInsets.all(32),
                                alignment: Alignment.center,
                                width: double.infinity,
                                child: Column(
                                  spacing: 16,
                                  children: [
                                    Icon(Icons.folder_open),
                                    Text(
                                      "Select your image ",
                                      style: TextStyle(fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                    CategoriesList(
                      selectedTopics: selectedTopics,
                    ),
                    BlogEditor(
                      controller: titleController,
                      hintText: 'Title',
                    ),
                    BlogEditor(
                        controller: contentController, hintText: 'Content'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void uploadBlog() {
    if (formKey.currentState!.validate() &&
        imageFile != null &&
        selectedTopics.isNotEmpty) {
      final posterId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
      context.read<BlogBloc>().add(UploadBlogEvent(
          title: titleController.text.trim(),
          content: contentController.text.trim(),
          posterId: posterId,
          topics: selectedTopics,
          image: imageFile!));
    }
  }
}
