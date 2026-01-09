import 'package:flutter/material.dart';

interface class Recipe {
  final IconData icon;
  final String title;
  final String description;

  const Recipe({
    required this.icon,
    required this.title,
    required this.description,
  });
}