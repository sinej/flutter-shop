import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final String? title;

  const DefaultLayout({
    required this.child,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppBar(),
      body: child,
      bottomNavigationBar: bottomNavigationBar
    );
  }

  AppBar? renderAppBar() {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        title: Text(
          title!,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
      );
    }
  }
}
