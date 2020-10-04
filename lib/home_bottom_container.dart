import 'package:flutter/material.dart';

import 'filter_icon.dart';

class HomeBottomContainer extends StatefulWidget {
  final AnimationController controller;

  HomeBottomContainer({
    @required this.controller,
  }) : assert(controller != null);

  @override
  _HomeBottomContainerState createState() => _HomeBottomContainerState();
}

class _HomeBottomContainerState extends State<HomeBottomContainer>
    with SingleTickerProviderStateMixin {
  // AnimationController widget.controller;
  // AnimationController _revealController;

  Animation<double> _xAxisPositionAnimation;
  Animation<double> _yAxisPositionAnimation;

  Animation<double> _fabRevealAnimation;
  Animation<double> _fabIconFallAnimation;
  Animation<double> _actionIconTranslateAnimation;

  @override
  void initState() {
    // widget.controller = AnimationController(
    //   vsync: this,
    //   duration: Duration(milliseconds: 2000),
    //   reverseDuration: Duration(milliseconds: 2000),
    // );
    // _revealController = AnimationController(
    //   vsync: this,
    //   duration: Duration(milliseconds: 1200),
    //   reverseDuration: Duration(milliseconds: 1200),
    // );
    _xAxisPositionAnimation = CurvedAnimation(
      parent: widget.controller,
      curve: Interval(
        0,
        0.2,
        curve: Curves.easeOut,
      ),
      // reverseCurve: Interval(
      //   0,
      //   0.2,
      //   curve: Curves.easeOut,
      // ),
    );
    _yAxisPositionAnimation = CurvedAnimation(
      parent: widget.controller,
      curve: Interval(
        0,
        0.2,
        curve: Curves.easeIn,
      ),
      // reverseCurve: Interval(
      //   0,
      //   0.2,
      //   curve: Curves.easeIn,
      // ),
    );
    _fabRevealAnimation = CurvedAnimation(
      parent: widget.controller,
      curve: Interval(
        0.2,
        0.5,
        curve: Curves.easeInOut,
      ),
      // reverseCurve: Interval(
      //   0.2,
      //   0.5,
      //   curve: Curves.easeInOut,
      // ),
    );
    _fabIconFallAnimation = CurvedAnimation(
      parent: widget.controller,
      curve: Interval(
        0.2,
        0.5,
        curve: Curves.easeInOut,
      ),
      // reverseCurve: Interval(
      //   0.2,
      //   0.5,
      //   curve: Curves.easeInOut,
      // ),
    );

    _actionIconTranslateAnimation = CurvedAnimation(
      parent: widget.controller,
      curve: Interval(
        0.5,
        0.7,
        curve: Curves.easeOut,
      ),
    );

    // widget.controller.addStatusListener(controllerListener);

    // _revealController.addStatusListener(revealListener);
    super.initState();
  }

  // controllerListener(status) {
  //   if (status == AnimationStatus.completed) _revealController.forward();
  // else if (status == AnimationStatus.dismissed)
  //   _revealController.reverse();
  // }

  revealListener(status) {
    if (status == AnimationStatus.dismissed) widget.controller.reverse();
  }

  @override
  void dispose() {
    // widget.controller.dispose();
    // widget.controller.removeListener(() => controllerListener);
    // _revealController.removeListener(() => revealListener);
    // _revealController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) => LayoutBuilder(
        builder: (context, constraints) => Container(
          child: Stack(
            fit: StackFit.expand,
            children: [

              /// Fab background
              Positioned(
                // top: (1 - _fabRevealAnimation.value) * (320 - (_yAxisPositionAnimation.value * (180 - 70)
                // as double)),
                // left: (1 - _fabRevealAnimation.value) * (MediaQuery.of(context).size.width - (_xAxisPositionAnimation.value *
                //     (MediaQuery.of(context).size.width / 2 - 56)
                //     as double)),
                bottom: (1 - _fabRevealAnimation.value) *
                    (_yAxisPositionAnimation.value *
                        (constraints.maxHeight / 2 - 70)),
                right: (1 - _fabRevealAnimation.value) *
                    (_xAxisPositionAnimation.value *
                        (MediaQuery.of(context).size.width / 2 - 56)),

                // bottom: (_yAxisPositionAnimation.value *
                //     (constraints.maxHeight / 2 - 70)),
                // right:  (_xAxisPositionAnimation.value *
                //     (MediaQuery.of(context).size.width / 2 - 56)),
                child: GestureDetector(
                  onTap: () {
                    if (widget.controller.status == AnimationStatus.completed)
                      widget.controller.reverse();
                    else
                      widget.controller.forward();
                    // if (_revealController.status == AnimationStatus.completed) {
                    //   _revealController.reverse();
                    // } else if (widget.controller.status ==
                    //     AnimationStatus.dismissed) {
                    //   widget.controller.forward();
                    // }
                  },
                  child: Container(
                    height:
                        (_fabRevealAnimation.value) * constraints.maxHeight +
                            (1 - _fabRevealAnimation.value) * 64,
                    width: (_fabRevealAnimation.value) * constraints.maxWidth +
                        (1 - _fabRevealAnimation.value) * 64,
                    margin:
                        EdgeInsets.all((1 - _fabRevealAnimation.value) * 24),
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: SizedBox(),
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      borderRadius: BorderRadius.all(
                        Radius.circular((1 - _fabRevealAnimation.value) * 1000),
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

              /// PageView
              IgnorePointer(
                ignoring: true,
                child: Container(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [],
                  ),
                ),
              ),

              /// Action Icons
              Positioned(
                bottom: (1 - _fabIconFallAnimation.value) *
                    (_yAxisPositionAnimation.value *
                        (constraints.maxHeight / 2 - 70)) + 16 + (1 - _fabIconFallAnimation.value) * 24,
                right: (_xAxisPositionAnimation.value *
                        (MediaQuery.of(context).size.width / 2 - 56)) -
                    (_actionIconTranslateAnimation.value *
                        constraints.maxWidth /
                        4) + 40,
                child: GestureDetector(
                  onTap: () {
                    // if (widget.controller.status == AnimationStatus.completed) {
                    //   widget.controller.reverse();
                    // } else {
                    //   widget.controller.forward();
                    // }
                  },
                  child: IgnorePointer(
                    child: Container(
                      // color: Colors.red,
                      height: 32,
                      width: 32,
                      // margin: const EdgeInsets.all(24),
                      child: FilterIcon(),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16
                    +
                    (_actionIconTranslateAnimation.value *
                        constraints.maxWidth /
                        4) - 40,
                child: GestureDetector(
                  onTap: () {},
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
    );
  }
}
