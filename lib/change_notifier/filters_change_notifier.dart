import 'package:fab_filter/change_notifier/filter1_change_notifier.dart';
import 'package:fab_filter/change_notifier/filter2_change_notifier.dart';
import 'package:flutter/cupertino.dart';

class FiltersChangeNotifier with ChangeNotifier {

  double currentPage;

  FiltersChangeNotifier() {
    this.currentPage = 0.0;
  }

  List filters = [
    Filter1ChangeNotifier(),
    Filter1ChangeNotifier(),
    Filter2ChangeNotifier(),
    Filter1ChangeNotifier(),
    Filter1ChangeNotifier(),
  ];
  // setFilterStatus(int position, FilterStatus status) {
  //   (filters[position] as Map).update("status", (value) => status);
  //   notifyListeners();
  // }
  //
  // setSelectedItems(int position, List items) {
  //   filters.elementAt(position)["data"]["items_selected"] = items;
  //   filters.elementAt(position)["data"]["status"] = FilterStatus.Changed;
  //   notifyListeners();
  // }
  //
  setCurrentPage(double value) {
    this.currentPage = value;
    notifyListeners();
  }
}