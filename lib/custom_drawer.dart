import 'package:fab_filter/change_notifier/animation_change_notifier.dart';
import 'package:fab_filter/slider/custom_slider.dart';
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
            width: 200,
            child: CustomSlider(
              width: 200,
              maxValue: 10000,
              minValue: 1000,
              initialValue: animationChangeNotifier.duration.inMilliseconds.toDouble(),
              onValueChange: (value) {
                animationChangeNotifier.setDuration(value);
              },
            ),
          ),
        ],
      ),
      // child: Slider(
      //   value: animationChangeNotifier.sliderValue ?? 1400.0,
      //   min: 100.0,
      //   max: 8000.0,
      //   onChanged: (value) {
      //     animationChangeNotifier.setSliderValue(value);
      //   },
      //   onChangeEnd: (value) {
      //     print("end: $value");
      //     animationChangeNotifier.setDuration(value.toInt());
      //   },
      // ),
    );
  }
}
