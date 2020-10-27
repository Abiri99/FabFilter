import 'dart:ffi';

import 'package:fab_filter/change_notifier/base_change_notifier.dart';
import 'package:fab_filter/util/enum.dart';
import 'package:flutter/material.dart';

class Filter2ChangeNotifier extends BaseChangeNotifier {
  
  final Function setParentFilterStatus;

  Map slider1Values;
  Map slider2Values;

  bool slider1Changed;
  bool slider2Changed;
  bool linesSelected;

  Filter2ChangeNotifier(this.setParentFilterStatus) {

    slider1Changed = false;
    slider2Changed = false;
    linesSelected = false;

    this.status = FilterStatus.NotChanged;
    this.selectedItems = [];
    this.slider1Values = {
      "start": null,
      "end": null,
    };
    this.slider2Values = {
      "start": null,
      "end": null,
    };
  }

  customNotifyListeners() {
    setParentFilterStatus(FilterStatus.Changed);
    notifyListeners();
  }

  checkForStatus() {
    if (selectedItems.isNotEmpty || slider1Changed || slider2Changed)
      this.status = FilterStatus.Changed;
    else
      this.status = FilterStatus.NotChanged;
    customNotifyListeners();
  }

  selectItem(int index) {
    selectedItems.add(index);
    checkForStatus();
    // this.status = FilterStatus.Changed;
    // customNotifyListeners();
  }

  deselectItem(int index) {
    selectedItems.remove(index);
    checkForStatus();
    // this.status = FilterStatus.Changed;
    // customNotifyListeners();
  }

  setSlider1Values(double start, double end) {
    this.slider1Values = {
      "start": start ?? this.slider1Values["start"],
      "end": end ?? this.slider1Values["end"],
    };
    if (slider1Values["start"] == 0 && slider1Values["end"] == 100)
      this.slider1Changed = false;
    else
      this.slider1Changed = true;
    checkForStatus();
    // this.status = FilterStatus.Changed;
    // customNotifyListeners();
  }

  setSlider2Values(double start, double end) {
    this.slider2Values = {
      "start": start ?? this.slider2Values["start"],
      "end": end ?? this.slider2Values["end"],
    };
    if (slider2Values["start"] == 0 && slider2Values["end"] == 100)
      this.slider2Changed = false;
    else
      this.slider2Changed = true;
    checkForStatus();
    // this.status = FilterStatus.Changed;
    // customNotifyListeners();
  }
}