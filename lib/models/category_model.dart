import 'package:flutter/material.dart';

/// Modelo que representa uma categoria no cardápio
class CategoryModel {
  final String id;
  final String name;
  final IconData icon;

  CategoryModel({required this.id, required this.name, required this.icon});
}
