import 'package:fab_filter/change_notifier/filters_change_notifier.dart';
import 'package:fab_filter/line.dart';
import 'package:fab_filter/util/custom_scroll_physics.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

const String TAG = "FilterPageViewIndicator";

class FilterPageViewIndicator extends StatefulWidget {
  final ScrollController scrollController;
  // final double currentPage;
  final Function(int page) pageChangeCallback;

  FilterPageViewIndicator({
    Key key,
    @required this.scrollController,
    // @required this.currentPage,
    @required this.pageChangeCallback,
  })  : assert(scrollController != null),
        // assert(currentPage != null),
        assert(pageChangeCallback != null),
        super(key: key);

  @override
  _FilterPageViewIndicatorState createState() =>
      _FilterPageViewIndicatorState();
}

class _FilterPageViewIndicatorState extends State<FilterPageViewIndicator> {
  // ScrollController _controller;

  @override
  void initState() {
    // print("initState");
    // _controller = SwiperController();
    // _controller = ScrollController(initialScrollOffset: widget.currentPage);
    // _controller.addListener(() {
    //   print("$TAG offset: ${_controller.offset}");
      // widget.pageChangeCallback(_controller.offset / 116);
    // });
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
    widget.scrollController.animateTo(
      (position.toDouble() * 116),
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
    widget.pageChangeCallback(position);
  }

  scrollToPosition(double position) {
    // _controller.jumpTo(position);
  }

  @override
  Widget build(BuildContext context) {
    // print("pageeeee: ${widget.currentPage}");
    FiltersChangeNotifier filtersChangeNotifier =
        Provider.of<FiltersChangeNotifier>(context);
    return Container(
      // key: ValueKey(widget.currentPage),
      child: ListView.builder(
        // key: ValueKey(widget.currentPage),
        physics: NeverScrollableScrollPhysics(),
        controller: widget.scrollController,
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
                  color: Color(0xff356E8C),
                  // color: position == (_controller.offset / 116)
                  //     ? Colors.white
                  //     : Color(0xff356E8C),
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
  }
}
