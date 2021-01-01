// Dependency imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// Availabell imports
import 'package:availabell/providers/job_seekers_provider.dart';
import 'package:availabell/views/add_details_view.dart';
import 'package:availabell/views/home_view.dart';
import 'package:availabell/views/login_view.dart';
import 'package:availabell/widgets/misc/globals.dart' as globals;
import 'package:availabell/widgets/ui/av_themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<JobSeekersProvider>(create: (context) => JobSeekersProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: globals.appName,
        theme: AVThemes.mainTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => HomeView(),
          LoginView.routeName: (context) => LoginView(),
          AddDetailsView.routeName: (context) => AddDetailsView(),
        },
      ),
    );
  }
}
