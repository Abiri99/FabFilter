import 'package:fab_filter/change_notifier/filters_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const String TAG = "FilterPageViewIndicator";

class FilterPageViewIndicator extends StatefulWidget {
  final ScrollController scrollController;
  final Function(int page) pageChangeCallback;
  final double currentPage;

  FilterPageViewIndicator({
    Key key,
    @required this.scrollController,
    @required this.pageChangeCallback,
    @required this.currentPage,
  })  : assert(scrollController != null),
        assert(pageChangeCallback != null),
        assert(currentPage != null),
        super(key: key);

  @override
  _FilterPageViewIndicatorState createState() =>
      _FilterPageViewIndicatorState();
}

class _FilterPageViewIndicatorState extends State<FilterPageViewIndicator> {
  animateToItem(int position) {
    widget.scrollController.animateTo(
      (position.toDouble() * 116),
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
    widget.pageChangeCallback(position);
  }

  @override
  Widget build(BuildContext context) {
    print("page: ${widget.currentPage}");
    FiltersChangeNotifier filtersChangeNotifier =
        Provider.of<FiltersChangeNotifier>(context);
    return Container(
      child: ListView.builder(
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
              child: Transform.scale(
                scale: 1 - (0.1 * (widget.currentPage - position).clamp(-1, 1).abs()),
                // scale: (1 - (widget.currentPage - position).clamp(-0.2, 0.2).abs()),
                child: Container(
                  key: UniqueKey(),
                  height: 20,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity((1 - (widget.currentPage - position).abs()).clamp(0.2, 1.0)),
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
            ),
          );
        },
      ),
    );
  }
}
