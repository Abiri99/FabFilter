import 'package:fab_filter/change_notifier/filter1_change_notifier.dart';
import 'package:fab_filter/change_notifier/filter2_change_notifier.dart';
import 'package:fab_filter/util/enum.dart';
import 'package:flutter/cupertino.dart';

class FiltersChangeNotifier with ChangeNotifier {

  FilterStatus mainStatus;
  double currentPage;
  List filters;

  FiltersChangeNotifier() {
    this.currentPage = 0.0;
    this.mainStatus = FilterStatus.NotChanged;
    this.filters = [
      Filter1ChangeNotifier(setFilterStatus),
      Filter1ChangeNotifier(setFilterStatus),
      Filter2ChangeNotifier(setFilterStatus),
      Filter1ChangeNotifier(setFilterStatus),
      Filter1ChangeNotifier(setFilterStatus),
    ];
  }

  setFilterStatus(FilterStatus status) {
    this.mainStatus = status;
    notifyListeners();
  }

  // setSelectedItems(int position, List items) {
  //   filters.elementAt(position)["data"]["items_selected"] = items;
  //   filters.elementAt(position)["data"]["status"] = FilterStatus.Changed;
  //   notifyListeners();
  // }

  setCurrentPage(double value) {
    this.currentPage = value;
    notifyListeners();
  }
}