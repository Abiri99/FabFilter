import 'package:fab_filter/line.dart';
import 'package:flutter/material.dart';

class FilterPageViewIndicator extends StatefulWidget {
  final double currentPage;

  FilterPageViewIndicator({
    @required this.currentPage,
  }) : assert(currentPage != null);

  @override
  _FilterPageViewIndicatorState createState() =>
      _FilterPageViewIndicatorState();
}

class _FilterPageViewIndicatorState extends State<FilterPageViewIndicator> {
  ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  animateToItem(int position) {
    _controller.animateTo(
      (position.toDouble() * 100) - 24,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 10,
        itemExtent: 100,
        controller: _controller,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, position) {

          var diff = (position.toDouble()) - widget.currentPage;
          diff = diff.clamp(-1.0, 1.0);

          return Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 24,
            ),
            child: Transform.scale(
              scale: 0.8 + (1 - diff) * 0.2,
              child: Line(
                key: ValueKey(position),
                color: widget.currentPage == position ? Colors.white : Color(0xff356E8C),
                height: 8,
              ),
            ),
          );
        },
      ),
    );
  }
}
