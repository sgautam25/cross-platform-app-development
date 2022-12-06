import 'package:flutter/material.dart';

class CategoryBuilder {
  final String id;
  final String title;
  final Color color;

  const CategoryBuilder({
    @required this.id,
    @required this.title,
    this.color = Colors.orange,
  });
}
