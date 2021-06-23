import 'package:flutter/material.dart';

class PageViewWidget extends StatelessWidget {
  PageViewWidget(
      {Key? key,
      required this.pageController,
      required this.itemCount,
      required this.itemBuilder})
      : super(key: key);

  final PageController pageController;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        physics: BouncingScrollPhysics(),
        restorationId: "restore",
        scrollDirection: Axis.vertical,
        itemCount: itemCount,
        controller: pageController,
        itemBuilder: itemBuilder);
  }
}
