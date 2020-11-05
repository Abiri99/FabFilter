import 'package:flutter/material.dart';

import '../filter_pageview_indicator_list.dart';

class PVI extends StatefulWidget {
  final ScrollController scrollController;
  final Function animateToPage;

  final AnimationController controller;
  final AnimationController filterController;

  PVI({
    Key key,
    this.controller,
    this.filterController,
    @required this.scrollController,
    @required this.animateToPage,
  });

  // : filterSheetAnimation = CurvedAnimation(
  //     parent: controller,
  //     curve: Interval(
  //       0.7,
  //       1.0,
  //       curve: Curves.easeOut,
  //     ),
  //   ),
  //   fadeOutAnimation = null;

  @override
  _PVIState createState() => _PVIState();
}

class _PVIState extends State<PVI> {
  buildLayout() {
    print("built layout...");
    return Container(
      height: widget.controller.value * 200 + 100,
      color: Colors.red,
    );
  }

  @override
  void initState() {
    widget.controller.addListener(() {
      print("pvi setState: ${widget.controller.value}");
    });
    widget.filterController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("built...");
    return Container(
      height: widget.controller.value * 200 + 100,
      color: Colors.red,
    );
    // return widget.controller.isAnimating
    //     ? AnimatedBuilder(
    //         animation: widget.controller,
    //         builder: buildLayout(),
    //       )
    //     : AnimatedBuilder(
    //         animation: widget.secondController,
    //         builder: (context, child) => Container(
    //           color: Colors.grey,
    //           height: 50,
    //         ),
    //       );

    // return AnimatedBuilder(
    //   key: ValueKey(widget.controller),
    //   animation: widget.controller,
    //   builder: (context, child) => buildLayout(),
    // );

    // return Consumer<FiltersChangeNotifier>(
    //   builder: (context, fcn, __) => Positioned(
    //     top: (1 - filterSheetAnimationValue) * 64 + 0,
    //     left: 0,
    //     right: 0,
    //     bottom: widget.constraints.maxHeight -
    //         64 -
    //         ((1 - filterSheetAnimationValue) * 86),
    //     child: IgnorePointer(
    //       ignoring: filterSheetAnimationValue == 0 ? true : false,
    //       child: Opacity(
    //         opacity: filterSheetAnimationValue == 0 ? 0.0 : 1.0,
    //         child: ChangeNotifierProvider.value(
    //           value: fcn,
    //           child: Opacity(
    //             opacity: 1 - fadeOutAnimationValue,
    //             child: Container(
    //               alignment: Alignment.center,
    //               color: Color(0xff164A6D),
    //               child: FilterPageViewIndicatorList(
    //                 scrollController: widget.scrollController,
    //                 currentPage: fcn.currentPage,
    //                 pageChangeCallback: widget.animateToPage,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
