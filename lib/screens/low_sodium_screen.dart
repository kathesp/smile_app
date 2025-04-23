import 'package:flutter/material.dart';
import '../services/menu_service.dart';
import 'dietary_screen.dart';

class LowSodiumScreen extends DietaryScreen {
  const LowSodiumScreen({super.key}) : super(categoryName: 'Low Sodium');

  @override
  State<LowSodiumScreen> createState() => _LowSodiumScreenState();
}

class _LowSodiumScreenState extends State<LowSodiumScreen>
    with DietaryScreenMixin {
  @override
  List<String> get categories =>
      MenuService.getSubcategories(widget.categoryName);

  @override
  Color get headerColor => const Color(0xFFFEEB50); // Yellow header color
}
