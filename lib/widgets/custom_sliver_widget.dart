import 'package:flutter/material.dart';

class CustomSliverView extends StatelessWidget {
  const CustomSliverView({Key? key, required this.columnList})
      : super(key: key);
  final List<Widget> columnList;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: columnList,
          ),
        ),
      ],
    );
  }
}
