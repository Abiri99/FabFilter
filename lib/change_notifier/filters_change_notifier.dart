import 'package:flutter/cupertino.dart';

enum FilterStatus {
  Changed,
  NotChanged,
}

class FiltersChangeNotifier with ChangeNotifier {

  double currentPage;

  FiltersChangeNotifier() {
    this.currentPage = 0.0;
  }

  List filters = [
    {
      "type": 1,
      "status": FilterStatus.Changed,
      "data": {
        "count": 5,
        "items_selected": [],
      },
    },
    {
      "type": 1,
      "status": FilterStatus.Changed,
      "data": {
        "count": 5,
        "items_selected": [],
      },
    },
    {
      "type": 2,
      "status": FilterStatus.Changed,
    },
    {
      "type": 1,
      "status": FilterStatus.Changed,
      "data": {
        "count": 5,
        "items_selected": [],
      },
    },
    {
      "type": 1,
      "status": FilterStatus.Changed,
      "data": {
        "count": 5,
        "items_selected": [],
      },
    },
  ];

  setFilterStatus(int position, FilterStatus status) {
    (filters[position] as Map).update("status", (value) => status);
    notifyListeners();
  }

  setCurrentPage(double value) {
    this.currentPage = value;
    notifyListeners();
  }
}