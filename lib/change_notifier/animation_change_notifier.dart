import 'package:flutter/foundation.dart';

class AnimationChangeNotifier with ChangeNotifier {
  Duration duration;
  double sliderValue;

  AnimationChangeNotifier() {
    this.duration = Duration(milliseconds: 2000);
    this.sliderValue = 2000.0;
  }

  setDuration(int duration) {
    this.duration = Duration(milliseconds: duration);
    notifyListeners();
  }

  setSliderValue(double value) {
    this.sliderValue = value;
    notifyListeners();
  }
}
