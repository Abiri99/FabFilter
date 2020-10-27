import 'package:fab_filter/change_notifier/base_change_notifier.dart';
import 'package:fab_filter/util/enum.dart';
import 'package:flutter/material.dart';

class Filter1ChangeNotifier extends BaseChangeNotifier {

  final Function setParentFilterStatus;

  Filter1ChangeNotifier(this.setParentFilterStatus) {
    this.selectedItems = [];
    this.status = FilterStatus.NotChanged;
  }

  customNotifyListeners() {
    setParentFilterStatus(FilterStatus.Changed);
    notifyListeners();
  }

  selectItem(int index) {
    selectedItems.add(index);
    this.status = FilterStatus.Changed;
    customNotifyListeners();
  }

  deselectItem(int index) {
    selectedItems.remove(index);
    if (selectedItems.length == 0) {
      this.status = FilterStatus.NotChanged;
      customNotifyListeners();
    }
  }
}