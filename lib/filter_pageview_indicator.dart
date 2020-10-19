import 'package:fab_filter/change_notifier/filters_change_notifier.dart';
import 'package:fab_filter/line.dart';
import 'package:fab_filter/util/custom_scroll_physics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
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
  // ScrollController _controller;
  // CustomScrollPhysics _physics;
  SwiperController _controller;
  int currentPage;

  @override
  void initState() {
    currentPage = 0;
    _controller = SwiperController();
    // _controller = ScrollController();
    // _controller.addListener(() {
    //   if (_controller.position.haveDimensions && _physics == null) {
    //     setState(() {
    //       var dimension =
    //           _controller.position.maxScrollExtent / (4 - 1);
    //       _physics = CustomScrollPhysics(itemDimension: dimension);
    //     });
    //   }
    // });
    super.initState();
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  animateToItem(int position) {
    // _controller.animateTo(
    //   (position.toDouble() * 100) - 24,
    //   duration: Duration(milliseconds: 200),
    //   curve: Curves.easeInOut,
    // );
  }

  @override
  Widget build(BuildContext context) {
    FiltersChangeNotifier filtersChangeNotifier =
        Provider.of<FiltersChangeNotifier>(context);

    return IgnorePointer(
      ignoring: false,
      child: Swiper(
        itemCount: 5,
        loop: false,
        controller: _controller,
        viewportFraction: 0.3,
        index: currentPage,
        onTap: (index) {
          // _controller
        },
        onIndexChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
        itemBuilder: (context, position) {
          var diff = (position.toDouble()) - currentPage;
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
                    margin: const EdgeInsets.only(
                      right: 8,
                    ),
                    child: Line(
                      key: ValueKey(position),
                      color: widget.currentPage == position
                          ? Colors.white
                          : Color(0xff356E8C),
                      height: 18,
                      withBadge: false,
                    ),
                  ),
                  Positioned(
                    key: ValueKey(
                        filtersChangeNotifier.filters[position]["status"]),
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
                      child: filtersChangeNotifier.filters[position]
                                  ["status"] ==
                              FilterStatus.Changed
                          ? Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
                                border: Border.all(
                                  color: Color(0xff164A6D),
                                  width: 3,
                                ),
                              ),
                            )
                          : SizedBox(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        scale: 0.9,
      ),
    );
  }
}
