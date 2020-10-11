import 'package:fab_filter/change_notifier/filters_change_notifier.dart';
import 'package:fab_filter/line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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

    FiltersChangeNotifier filtersChangeNotifier = Provider.of<FiltersChangeNotifier>(context);

    return IgnorePointer(
      ignoring: false,
      child: ListView.builder(
        physics: PageScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: filtersChangeNotifier.filters.length,
        itemExtent: 100,
        controller: _controller,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, position) {
          var diff = (position.toDouble()) - widget.currentPage;
          diff = diff.clamp(-1.0, 1.0).abs();

          return Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 2,
              vertical: 0,
            ),
            child: Transform.scale(
              alignment: Alignment.center,
              scale: 0.9 + (1 - diff) * 0.1,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 8,),
                    child: Line(
                      key: ValueKey(position),
                      color: widget.currentPage == position ? Colors.white : Color(0xff356E8C),
                      height: 18,
                      withBadge: false,
                    ),
                  ),
                  Positioned(
                    key: ValueKey(filtersChangeNotifier.filters[position]["status"]),
                    top: 16,
                    right: 0,
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 200),
                      reverseDuration: Duration(milliseconds: 200),
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(
                          scale: animation,
                          child: child,
                        );
                      },
                      child: filtersChangeNotifier.filters[position]["status"] == FilterStatus.Changed ? Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                          border: Border.all(color: Color(0xff164A6D), width: 3,),
                        ),
                      ) : SizedBox(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
