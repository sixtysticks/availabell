import 'package:flutter/material.dart';

// import 'package:availabell/widgets/misc/globals.dart' as globals;

class SGButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;

  SGButton({
    Key key,
    @required this.buttonText,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButtonTheme(
      data: TextButtonThemeData(style: null),
      child: ElevatedButton(
        onPressed: onPressed,
        // color: Theme.of(context).accentColor,
        // padding: EdgeInsets.fromLTRB(
        //   globals.spacer + globals.halfSpacer,
        //   globals.spacer * 0.68,
        //   globals.spacer + globals.halfSpacer,
        //   globals.spacer * 0.68,
        // ),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
        child: Text(
          buttonText,
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    );
  }
}
