import 'package:fab_filter/change_notifier/filters_change_notifier.dart';
import 'package:fab_filter/line.dart';
import 'package:fab_filter/util/custom_scroll_physics.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

class FilterPageViewIndicator extends StatefulWidget {
  final double currentPage;
  final Function(double value) pageChangeCallback;

  FilterPageViewIndicator({
    @required this.currentPage,
    @required this.pageChangeCallback,
  })  : assert(currentPage != null),
        assert(pageChangeCallback != null);

  @override
  _FilterPageViewIndicatorState createState() =>
      _FilterPageViewIndicatorState();
}

class _FilterPageViewIndicatorState extends State<FilterPageViewIndicator> {
  ScrollController _controller;

  // CustomScrollPhysics _physics;
  // SwiperController _controller;
  int currentPage;

  @override
  void initState() {
    currentPage = 0;
    // _controller = SwiperController();
    _controller = ScrollController();
    _controller.addListener(() {
      widget.pageChangeCallback(_controller.offset / 116);
    });
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
    _controller.dispose();
    super.dispose();
  }

  animateToItem(int position) {
    _controller.animateTo(
      (position.toDouble() * 116),
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    FiltersChangeNotifier filtersChangeNotifier =
        Provider.of<FiltersChangeNotifier>(context);
    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        padding: EdgeInsets.only(
            left: 24, right: MediaQuery.of(context).size.width - 144),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: filtersChangeNotifier.filters.length,
        itemBuilder: (context, position) {
          return Align(
            alignment: Alignment.center,
            child: GestureDetector(
              behavior: HitTestBehavior.deferToChild,
              onTap: () {
                animateToItem(position);
              },
              child: Container(
                key: UniqueKey(),
                height: 20,
                width: 100,
                decoration: BoxDecoration(
                  color: position == (_controller.offset / 116)
                      ? Colors.white
                      : Color(0xff356E8C),
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                // child: Transform.scale(
                //   scale: 1.0,
                //   child: Line(
                //     tapable: false,
                //     color: Color(0xff356E8C),
                //     height: 20,
                //     width: 100,
                //   ),
                // ),
              ),
            ),
          );
        },
      ),
    );

    return IgnorePointer(
      ignoring: false,
      child: Swiper(
        itemCount: 5,
        loop: false,
        // controller: _controller,
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
