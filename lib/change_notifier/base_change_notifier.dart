import 'package:fab_filter/util/enum.dart';
import 'package:flutter/cupertino.dart';

class BaseChangeNotifier with ChangeNotifier {
  List<int> selectedItems;
  FilterStatus status;
}