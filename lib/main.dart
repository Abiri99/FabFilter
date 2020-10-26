import 'package:fab_filter/change_notifier/animation_change_notifier.dart';
import 'package:fab_filter/change_notifier/filters_change_notifier.dart';
import 'package:fab_filter/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff35BACD),
        primaryColorLight: Color(0xff51D1E1),
        primaryColorDark: Color(0xff166088),
        accentColor: Color(0xffF86384),
        cardColor: Color(0xffE2FAFF),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: AnimationChangeNotifier(),
          ),
          ChangeNotifierProvider.value(
            value: FiltersChangeNotifier(),
          ),
        ],
        child: HomePage(),
        // child: Consumer<AnimationChangeNotifier>(
        //   builder: (context, animationCN, __) {
        //     return HomePage(
        //       duration: animationCN.duration,
        //     );
        //   },
        // ),
      ),
    );
  }
}
