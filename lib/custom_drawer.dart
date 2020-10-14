import 'package:fab_filter/change_notifier/animation_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  AnimationChangeNotifier animationChangeNotifier;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    animationChangeNotifier = Provider.of<AnimationChangeNotifier>(context);
    return Container(
      color: Theme.of(context).primaryColorLight,
      alignment: Alignment.center,
      child: Slider(
        value: animationChangeNotifier.sliderValue ?? 1400.0,
        min: 100.0,
        max: 8000.0,
        onChanged: (value) {
          animationChangeNotifier.setSliderValue(value);
        },
        onChangeEnd: (value) {
          print("end: $value");
          animationChangeNotifier.setDuration(value.toInt());
        },
      ),
    );
  }
}
