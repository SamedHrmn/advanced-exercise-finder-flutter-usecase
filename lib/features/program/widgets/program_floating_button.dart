import 'package:flutter/material.dart';

class ProgramFloatingButton extends StatelessWidget {
  const ProgramFloatingButton({
    required this.onPressed,
    required this.iconData,
    super.key,
  });

  final VoidCallback onPressed;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Icon(iconData),
    );
  }
}
