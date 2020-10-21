import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'change_notifier/filters_change_notifier.dart';
import 'custom_appbar.dart';
import 'filter_icon.dart';
import 'filter_pageview_indicator.dart';
import 'filter_view.dart';
import 'filter_view2.dart';
import 'list_item.dart';

const String TAG = "HomePage";

class HomeBody extends StatefulWidget {
  final Duration duration;

  HomeBody({Key key, this.duration}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation<double> _listViewAnimation;
  Animation<double> _opacityAnimation;
  Animation<double> _scaleAnimation;

  Animation<double> _xAxisPositionAnimation;
  Animation<double> _yAxisPositionAnimation;

  Animation<double> _fabRevealAnimation;
  Animation<double> _fabIconFallAnimation;
  Animation<double> _actionIconTranslateAnimation;
  Animation<double> _filterSheetAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: widget.duration,
      reverseDuration: widget.duration,
      vsync: this,
    );
    _listViewAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0,
        0.2,
        curve: Curves.easeOut,
      ),
    );
    _opacityAnimation = Tween(begin: 1.0, end: 0.5).animate(_listViewAnimation);
    _scaleAnimation = Tween(begin: 1.0, end: 0.9).animate(_listViewAnimation);

    _xAxisPositionAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0,
        0.2,
        curve: Curves.easeOut,
      ),
    );
    _yAxisPositionAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0,
        0.2,
        curve: Curves.easeIn,
      ),
    );
    _fabRevealAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0.2,
        0.5,
        curve: Curves.easeInOut,
      ),
    );
    _fabIconFallAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0.2,
        0.5,
        curve: Curves.easeInOut,
      ),
    );
    _actionIconTranslateAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0.5,
        0.7,
        curve: Curves.easeOut,
      ),
    );
    _filterSheetAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0.7,
        1.0,
        curve: Curves.easeOut,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  animationCallback(bool value) {
    if (value) {
      if (_controller.status != AnimationStatus.forward) _controller.forward();
    } else {
      if (_controller.status != AnimationStatus.reverse) _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: CustomAppBar(),
              pinned: true,
            ),
            AnimatedBuilder(
              animation: _listViewAnimation,
              child: ListItem(),
              builder: (context, child) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return index == 0
                        ? SizedBox(
                            height: 12,
                          )
                        :
                        // : child
                        FadeTransition(
                            opacity: _opacityAnimation,
                            child: ScaleTransition(
                              alignment: Alignment.topCenter,
                              scale: _scaleAnimation,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical:
                                      (1 - _scaleAnimation.value) * -40 + 8,
                                ),
                                child: child,
                              ),
                            ),
                          );
                  },
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: mq.size.height - 380,
          right: 0,
          left: 0,
          bottom: 0,
          child: LayoutBuilder(
            builder: (context, constraints) => Container(
              child: Stack(
                children: [
                  // PageView Indicators
                  AnimatedBuilder(
                    animation: _filterSheetAnimation,
                    child: ChangeNotifierProvider(
                      create: (context) => FiltersChangeNotifier(),
                      child: Container(
                        alignment: Alignment.center,
                        color: Color(0xff164A6D),
                        child: FilterPageViewIndicator(
                          currentPage: 2,
                        ),
                      ),
                    ),
                    builder: (context, child) => Positioned(
                      top: (1 - _filterSheetAnimation.value) * 64 + 0,
                      left: 0,
                      right: 0,
                      bottom: constraints.maxHeight -
                          64 -
                          ((1 - _filterSheetAnimation.value) * 86),
                      child: IgnorePointer(
                        ignoring: _filterSheetAnimation.value == 0 ? true : false,
                        child: Opacity(
                          opacity: _filterSheetAnimation.value == 0 ? 0.0 : 1.0,
                          child: child,
                        ),
                      ),
                    ),
                  ),
                  // Fab Background
                  Positioned(
                    top: 64,
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: Container(
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Fab background
                          AnimatedBuilder(
                            animation: _fabRevealAnimation,
                            builder: (context, child) => Positioned(
                              bottom: (1 - _fabRevealAnimation.value) *
                                  (_yAxisPositionAnimation.value *
                                      (constraints.maxHeight / 2 - 70)),
                              right: (1 - _fabRevealAnimation.value) *
                                  (_xAxisPositionAnimation.value *
                                      (MediaQuery.of(context).size.width / 2 -
                                          56)),
                              child: GestureDetector(
                                onTap: () {
                                  if (_controller.status ==
                                      AnimationStatus.completed)
                                    _controller.reverse();
                                  else
                                    _controller.forward();
                                },
                                child: Container(
                                  height: (_fabRevealAnimation.value) *
                                          (constraints.maxHeight - 64) +
                                      (1 - _fabRevealAnimation.value) * 64,
                                  width: (_fabRevealAnimation.value) *
                                          constraints.maxWidth +
                                      (1 - _fabRevealAnimation.value) * 64,
                                  margin: EdgeInsets.all(
                                      (1 - _fabRevealAnimation.value) * 24),
                                  padding: const EdgeInsets.all(32),
                                  child: Center(
                                    child: SizedBox(),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColorDark,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          (1 - _fabRevealAnimation.value) *
                                              500),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 15),
                                        blurRadius: 15,
                                        spreadRadius: -8,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Filter PageView
                          AnimatedBuilder(
                            animation: _filterSheetAnimation,
                            child: ChangeNotifierProvider(
                              create: (context) => FiltersChangeNotifier(),
                              child: Consumer<FiltersChangeNotifier>(
                                builder: (_, filtersChangeNotifier, __) =>
                                    Container(
                                  child: PageView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount:
                                        filtersChangeNotifier.filters.length,
                                    itemBuilder: (context, position) {
                                      return filtersChangeNotifier
                                                  .filters[position]["type"] ==
                                              2
                                          ? FilterView2(
                                              key: ValueKey(
                                                  filtersChangeNotifier
                                                          .filters[position]
                                                      ["status"]),
                                            )
                                          : FilterView(
                                              filtersChangeNotifier:
                                                  filtersChangeNotifier,
                                              position: position,
                                              key: ValueKey(
                                                  filtersChangeNotifier
                                                          .filters[position]
                                                      ["status"]),
                                            );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            builder: (context, child) => IgnorePointer(
                              ignoring: _filterSheetAnimation.value == 1.0
                                  ? false
                                  : true,
                              child: Transform.translate(
                                offset: Offset(
                                    0, 36 * (1 - _filterSheetAnimation.value)),
                                child: FadeTransition(
                                  opacity: _filterSheetAnimation,
                                  child: child,
                                ),
                              ),
                            ),
                          ),

                          // Action Icons Background Container
                          AnimatedBuilder(
                            animation: _filterSheetAnimation,
                            child: Container(
                              height: 64,
                              color: Color(0xff33779C),
                            ),
                            builder: (context, child) => Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: IgnorePointer(
                                child: Opacity(
                                  opacity: 1.0 * _filterSheetAnimation.value,
                                  child: child,
                                ),
                              ),
                            ),
                          ),

                          // Filter Icon
                          AnimatedBuilder(
                            animation: _controller,
                            child: IgnorePointer(
                              child: Container(
                                height: 32,
                                width: 32,
                                child: FilterIcon(),
                              ),
                            ),
                            builder: (context, child) => Positioned(
                              bottom: (1 - _fabIconFallAnimation.value) *
                                      (_yAxisPositionAnimation.value *
                                          (constraints.maxHeight / 2 - 70)) +
                                  16 +
                                  (1 - _fabIconFallAnimation.value) * 24,
                              right: (_xAxisPositionAnimation.value *
                                      (MediaQuery.of(context).size.width / 2 -
                                          56)) -
                                  (_actionIconTranslateAnimation.value *
                                      constraints.maxWidth /
                                      4) +
                                  40,
                              child: child,
                            ),
                          ),

                          // Close Icon
                          AnimatedBuilder(
                            animation: _actionIconTranslateAnimation,
                            child: Icon(
                              Icons.close,
                              size: 28,
                              color: Color(0xff8EB8C6),
                            ),
                            builder: (context, child) => Positioned(
                              bottom: 16,
                              left: 16 +
                                  (_actionIconTranslateAnimation.value *
                                      constraints.maxWidth /
                                      4) -
                                  40,
                              child: GestureDetector(
                                onTap: () {
                                  _controller.reverse();
                                },
                                child: Container(
                                  height: 32,
                                  width: 32,
                                  // margin: const EdgeInsets.all(24),
                                  child: Opacity(
                                    opacity:
                                        _actionIconTranslateAnimation.value,
                                    child: child,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}