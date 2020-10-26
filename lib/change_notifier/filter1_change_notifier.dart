import 'package:fab_filter/change_notifier/base_change_notifier.dart';
import 'package:fab_filter/util/enum.dart';
import 'package:flutter/material.dart';

class Filter1ChangeNotifier extends BaseChangeNotifier {

  Filter1ChangeNotifier() {
    this.selectedItems = [];
    this.status = FilterStatus.NotChanged;
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
}