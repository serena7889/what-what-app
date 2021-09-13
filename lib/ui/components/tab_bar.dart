import 'package:what_what_app/ui/styles/colors.dart';
import 'package:what_what_app/ui/styles/fonts.dart';
import 'package:what_what_app/ui/styles/shadows.dart';
import 'package:flutter/material.dart';

class WWTabPage {
  String tabText;
  Widget page;

  WWTabPage({required this.tabText, required this.page});
}

class WWTextTabBar extends StatelessWidget {
  final TabController controller;
  final List<WWTabPage> pages;

  const WWTextTabBar({required this.controller, required this.pages});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: WWColor.primaryBackground(context),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          WWShadow.card.boxShadow(context),
        ],
      ),
      child: TabBar(
          isScrollable: pages.length > 3,
          controller: controller,
          labelColor: WWColor.textOverAccentColor,
          unselectedLabelStyle: WWFonts.fromOptions(
            context,
            weight: WWFontWeight.bold,
            color: WWColor.secondaryText(context),
          ),
          labelStyle: WWFonts.fromOptions(
            context,
            weight: WWFontWeight.bold,
            color: WWColor.textOverAccentColor,
          ),
          unselectedLabelColor: WWColor.secondaryText(context),
          indicator: BoxDecoration(
            color: WWColor.accentColor,
            borderRadius: BorderRadius.circular(20),
          ),
          tabs: pages.map((tab) => Tab(text: tab.tabText)).toList()),
    );
  }
}
