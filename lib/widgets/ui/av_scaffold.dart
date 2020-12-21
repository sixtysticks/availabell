// Dependency imports
import 'package:flutter/material.dart';

// Availabell imports
import 'package:availabell/widgets/ui/av_app_bar.dart';

class AVScaffold extends StatelessWidget {
  final List<Widget> appBarActions;
  final Widget title;
  final Color backgroundColor;
  final Widget screenContent;

  const AVScaffold({
    Key key,
    this.appBarActions,
    this.title,
    this.backgroundColor,
    this.screenContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = SGAppBar(
      appBar: AppBar(),
      title: title,
      actions: appBarActions,
    );

    final appBarHeight = appBar.preferredSize.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final contentHeight = MediaQuery.of(context).size.height - appBarHeight - statusBarHeight;

    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor,
      body: Container(
        height: contentHeight,
        width: double.infinity,
        child: screenContent,
      ),
    );
  }
}
