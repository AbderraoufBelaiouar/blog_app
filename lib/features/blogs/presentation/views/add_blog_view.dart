import 'dart:developer';
import 'dart:io';

import 'package:blog_app_revision/core/theme/app_pallete.dart';
import 'package:blog_app_revision/core/utils/pick_image.dart';
import 'package:blog_app_revision/features/blogs/presentation/widgets/blog_editor.dart';
import 'package:blog_app_revision/features/blogs/presentation/widgets/categories_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dotted_border/dotted_border.dart';

class AddBlogView extends StatefulWidget {
  const AddBlogView({super.key});

  @override
  State<AddBlogView> createState() => _AddBlogViewState();
}

class _AddBlogViewState extends State<AddBlogView> {
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
          automaticallyImplyLeading: false,
          title: Text(
            'Add Blog',
          ),
          actions: [
            IconButton(
                icon: Icon(
                  CupertinoIcons.checkmark_circle,
                ),
                onPressed: () {}),
          ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                  )
                  : GestureDetector(
                      onTap: () {
                        log('pick image');
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
              BlogEditor(controller: contentController, hintText: 'Content'),
            ],
          ),
        ),
      ),
    );
  }
}
