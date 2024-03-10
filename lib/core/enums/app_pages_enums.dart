import 'package:flutter/material.dart';

enum AppPages {
  home,
  myProgram;

  const AppPages();

  String getTitle() {
    switch (this) {
      case AppPages.home:
        return 'Home';
      case AppPages.myProgram:
        return 'My Program';
    }
  }

  Widget getIcon() {
    switch (this) {
      case AppPages.home:
        return const Icon(Icons.home_filled);
      case AppPages.myProgram:
        return const Icon(Icons.list);
    }
  }
}
