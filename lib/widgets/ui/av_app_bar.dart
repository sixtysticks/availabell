// Dependency imports
import 'package:flutter/material.dart';

// Availabell imports
import 'package:availabell/widgets/ui/av_themes.dart';

class SGAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final Widget title;
  final String fontFamily;
  final double fontSize;
  final List<Widget> actions;

  const SGAppBar({
    Key key,
    this.appBar,
    this.title,
    this.fontFamily,
    this.fontSize,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      backgroundColor: AVThemes.avLightColor,
      // centerTitle: false,
      elevation: 2,
      title: title,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
