import 'package:advanced_exercise_finder_flutter_case/core/components/app_text.dart';
import 'package:flutter/material.dart';

class PageSkeleton extends StatelessWidget {
  const PageSkeleton({
    required this.title,
    required this.headerMinHeight,
    required this.headerMaxHeight,
    required this.headerChild,
    super.key,
    this.slivers = const [],
    this.actions,
  });

  final String title;
  final double headerMinHeight;
  final double headerMaxHeight;
  final Widget headerChild;
  final List<Widget> slivers;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          centerTitle: true,
          shadowColor: Colors.white,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          pinned: true,
          actions: actions,
          title: AppText(text: title, fontWeight: AppTextFontWeight.semibold),
        ),
        SliverPersistentHeader(
          delegate: _SliverHeaderDelegate(minHeight: headerMinHeight, maxHeight: headerMaxHeight, child: headerChild),
        ),
        ...slivers,
      ],
    );
  }
}

class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  _SliverHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child != oldDelegate.child;
  }
}
