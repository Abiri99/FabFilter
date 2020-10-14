import 'package:flutter/foundation.dart';

class AnimationChangeNotifier with ChangeNotifier {
  Duration duration;
  double sliderValue;

  AnimationChangeNotifier(): duration = Duration(milliseconds: 8000), sliderValue = 8000.0;

  setDuration(int duration) {
    this.duration = Duration(milliseconds: duration);
    notifyListeners();
  }

  setSliderValue(double value) {
    this.sliderValue = value;
    notifyListeners();
  }
}