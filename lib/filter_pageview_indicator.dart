import 'package:fab_filter/change_notifier/base_change_notifier.dart';
import 'package:fab_filter/change_notifier/filters_change_notifier.dart';
import 'package:fab_filter/util/enum.dart';
import 'package:flutter/material.dart';

class FilterPageViewIndicator extends StatefulWidget {
  final BaseChangeNotifier fcn;
  final double opacity;
  final FilterStatus filterStatus;

  FilterPageViewIndicator({this.fcn, this.opacity, this.filterStatus})
      : assert(opacity != null),
        assert(fcn != null),
        assert(filterStatus != null);

  @override
  _FilterPageViewIndicatorState createState() =>
      _FilterPageViewIndicatorState();
}

class _FilterPageViewIndicatorState extends State<FilterPageViewIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _scaleAnimation;

  @override
  void didUpdateWidget(covariant FilterPageViewIndicator oldWidget) {
    print("didUpdateWidget: ${widget.filterStatus} ${widget.fcn.selectedItems}");
    if (widget.filterStatus != oldWidget.filterStatus) {
      if (widget.filterStatus == FilterStatus.Changed)
        markIndicatorWithBadge();
      else
        removeBadgeFromIndicator();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    print("indicator initState: ${widget.filterStatus}");
    _controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticInOut,
      reverseCurve: Curves.elasticInOut,
    );
    if (widget.fcn.status == FilterStatus.Changed)
      _controller.forward();
    else
      _controller.reverse();
    super.initState();
  }

  markIndicatorWithBadge() {
    _controller.forward();
  }

  removeBadgeFromIndicator() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8,
      ),
      child: Stack(
        children: [
          Container(
            key: UniqueKey(),
            height: 20,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(widget.opacity),
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            margin: const EdgeInsets.only(
              left: 8,
              right: 8,
              top: 8,
            ),
          ),
          Positioned(
            top: 0,
            right: 4,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  border: Border.all(
                    color: Color(0xff164A6D),
                    width: 3,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
