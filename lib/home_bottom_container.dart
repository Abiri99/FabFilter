import 'package:fab_filter/action_icons.dart';
import 'package:fab_filter/action_icons_container.dart';
import 'package:fab_filter/fab_container.dart';
import 'package:fab_filter/filter_pageview_container.dart';
import 'package:fab_filter/filter_pageview_indicator_container.dart';
import 'package:flutter/material.dart';

class HomeBottomContainer extends StatefulWidget {
  final Function(bool value) animationCallback;
  final Duration duration;

  HomeBottomContainer({
    Key key,
    @required this.animationCallback,
    @required this.duration,
  })  : assert(animationCallback != null),
        assert(duration != null),
        super(key: key);

  @override
  _HomeBottomContainerState createState() => _HomeBottomContainerState();
}

class _HomeBottomContainerState extends State<HomeBottomContainer>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

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

    _controller.addStatusListener((status) {
      switch(status) {
        case AnimationStatus.forward:
          // widget.animationCallback(true);
          break;
        case AnimationStatus.reverse:
          // widget.animationCallback(false);
          break;
      }
    });

    // _controller.addStatusListener((status) {
    //   if (_launchedParentAnimation) return;
    //   if (status == AnimationStatus.forward) {
    //     widget.animationCallback(true);
    //   } else if (status == AnimationStatus.reverse) {
    //     widget.animationCallback(false);
    //   }
    // });
    // _controller.addStatusListener(_controllerListener);

    // _reveal_controller.addStatusListener(revealListener);
    super.initState();
  }

  // _controllerListener(status) {
  //   if (status == AnimationStatus.completed) _reveal_controller.forward();
  // else if (status == AnimationStatus.dismissed)
  //   _reveal_controller.reverse();
  // }

  revealListener(status) {
    if (status == AnimationStatus.dismissed) _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    // _controller.removeListener(() => _controllerListener);
    // _reveal_controller.removeListener(() => revealListener);
    // _reveal_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => LayoutBuilder(
        builder: (context, constraints) => Container(
          // color: Colors.red,
          child: Stack(
            children: [
              FilterPageViewIndicatorContainer(
                filterSheetAnimation: _filterSheetAnimation,
                constraints: constraints,
              ),
              Positioned(
                top: 64,
                right: 0,
                left: 0,
                bottom: 0,
                child: Container(
                  // color: Colors.blue,
                  // margin: const EdgeInsets.only(top: 64),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      /// Fab background
                      FabContainer(
                        controller: _controller,
                        fabRevealAnimation: _fabRevealAnimation,
                        xAxisPositionAnimation: _xAxisPositionAnimation,
                        yAxisPositionAnimation: _yAxisPositionAnimation,
                        constraints: constraints,
                      ),

                      /// PageView
                      IgnorePointer(
                        ignoring:
                            _filterSheetAnimation.value == 1.0 ? false : true,
                        child: FilterPageViewContainer(_filterSheetAnimation),
                      ),

                      /// Action Icons Background Container
                      ActionIconsContainer(_filterSheetAnimation),

                      /// Action Icons
                      ActionIcons(
                        fabIconFallAnimation: _fabIconFallAnimation,
                        xAxisPositionAnimation: _xAxisPositionAnimation,
                        yAxisPositionAnimation: _yAxisPositionAnimation,
                        actionIconTranslateAnimation:
                            _actionIconTranslateAnimation,
                        constraints: constraints,
                      ),
                      Positioned(
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
                              opacity: _actionIconTranslateAnimation.value,
                              child: Icon(
                                Icons.close,
                                size: 28,
                                color: Color(0xff8EB8C6),
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
    );
  }
}
