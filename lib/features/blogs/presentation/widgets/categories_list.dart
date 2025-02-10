// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app_revision/core/constants/constants.dart';
import 'package:flutter/material.dart';

import 'package:blog_app_revision/core/theme/app_pallete.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({
    super.key,
    required this.selectedTopics,
  });
  final List<String> selectedTopics;

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: Constants.topics.map(
              (e) => Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () {
                    if (widget.selectedTopics.contains(e)) {
                      widget.selectedTopics.remove(e);
                    } else {
                      widget.selectedTopics.add(e);
                    }
                    setState((){});
                  },
                  child: Chip(
                    color: widget.selectedTopics.contains(e)
                        ? WidgetStatePropertyAll(AppPallete.gradient1)
                        : null,
                    label: Text(
                      e,
                    ),
                    side: BorderSide(color: AppPallete.bordercolor),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
