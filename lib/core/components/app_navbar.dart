import 'package:advanced_exercise_finder_flutter_case/core/enums/app_pages_enums.dart';
import 'package:flutter/material.dart';

class AppNavBar extends StatefulWidget {
  const AppNavBar({required this.pageController, super.key});

  final PageController pageController;

  @override
  State<AppNavBar> createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> {
  AppPages activePage = AppPages.home;

  void updatePage(int index) {
    setState(() {
      activePage = AppPages.values[index];
    });
    widget.pageController.jumpToPage(activePage.index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: updatePage,
      currentIndex: activePage.index,
      selectedFontSize: 12,
      items: AppPages.values.map((e) => BottomNavigationBarItem(icon: e.getIcon(), label: e.getTitle())).toList(),
    );
  }
}
