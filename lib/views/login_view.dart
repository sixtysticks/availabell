// Dependency imports
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Availabell imports
import 'package:availabell/widgets/misc/globals.dart' as globals;
import 'package:availabell/widgets/ui/av_scaffold.dart';
import 'package:availabell/widgets/ui/av_themes.dart';

class LoginView extends StatelessWidget {
  static const routeName = globals.loginRoute;

  LoginView({
    Key key,
  }) : super(key: key);

  void _launchURL() async {
    const url = globals.linkedInLoginUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AVScaffold(
      appBarActions: null,
      backgroundColor: AVThemes.avLightColor,
      screenContent: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(globals.spacer),
            child: Column(
              children: [
                Text(
                  'Hello!',
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: globals.halfSpacer),
                Text(
                  'Thank you for installing Availabell. ',
                  style: Theme.of(context).textTheme.headline1,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: globals.halfSpacer),
                Text(
                  'Please sign in using your LinkedIn account below',
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: globals.spacer),
                ElevatedButton(
                  onPressed: _launchURL,
                  // padding: EdgeInsets.all(0.0),
                  child: Image.asset(
                    globals.linkedInLogo,
                    fit: BoxFit.contain,
                    height: 36.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
