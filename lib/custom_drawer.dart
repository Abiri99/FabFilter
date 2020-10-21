import 'package:fab_filter/change_notifier/animation_change_notifier.dart';
import 'package:fab_filter/slider/custom_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
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
    AnimationChangeNotifier animationChangeNotifier = Provider.of<AnimationChangeNotifier>(context);
    return Container(
      color: Theme.of(context).primaryColorDark,
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(
            height: 36,
          ),
          Container(
            height: 200,
            alignment: Alignment.center,
            child: Text("Flutter Animation Sample"),
          ),
          Container(
            // color: Colors.red,
            width: 250,
            child: CustomSlider(
              width: 250,
              maxValue: 10000,
              minValue: 1000,
              initialValue: 1000 + 10000 - animationChangeNotifier.duration.inMilliseconds.toDouble(),
              onValueChange: (value) {
                var duration = 10000 - (value - 1000);
                animationChangeNotifier.setDuration(duration);
              },
            ),
          ),
        ],
      ),
    );
  }
}
