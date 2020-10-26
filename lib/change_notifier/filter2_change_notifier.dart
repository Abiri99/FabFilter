import 'package:fab_filter/change_notifier/base_change_notifier.dart';
import 'package:fab_filter/util/enum.dart';
import 'package:flutter/material.dart';

class Filter2ChangeNotifier extends BaseChangeNotifier {

  Map slider1Values;
  Map slider2Values;

  Filter2ChangeNotifier() {
    this.status = FilterStatus.NotChanged;
    this.selectedItems = [];
    this.slider1Values = {
      "start": 0,
      "end": 100,
    };
    this.slider2Values = {
      "start": 0,
      "end": 100,
    };
  }

  selectItem(int index) {
    selectedItems.add(index);
    this.status = FilterStatus.Changed;
    notifyListeners();
  }

  deselectItem(int index) {
    selectedItems.remove(index);
    this.status = FilterStatus.Changed;
    notifyListeners();
  }

  setSlider1Values(double start, double end) {
    this.slider1Values = {
      "start": start ?? this.slider1Values["start"],
      "end": end ?? this.slider1Values["end"],
    };
    this.status = FilterStatus.Changed;
    notifyListeners();
  }

  setSlider2Values(double start, double end) {
    this.slider2Values = {
      "start": start ?? this.slider2Values["start"],
      "end": end ?? this.slider2Values["end"],
    };
    this.status = FilterStatus.Changed;
    notifyListeners();
  }
}