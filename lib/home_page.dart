import 'package:fab_filter/change_notifier/animation_change_notifier.dart';
import 'package:fab_filter/home_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'custom_drawer.dart';

class HomePage extends StatefulWidget {
  final Duration duration;

  HomePage({
    Key key,
    this.duration,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      drawer: Drawer(
        elevation: 24.0,
        child: CustomDrawer(),
      ),
      body: Consumer<AnimationChangeNotifier>(
        builder: (context, acn, child) => HomeBody(
          key: ValueKey(acn.duration.inMilliseconds),
          duration: acn.duration,
        ),
      ),
    );
  }
}
