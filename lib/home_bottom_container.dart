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
    with TickerProviderStateMixin {
  // AnimationController widget.controller;
  AnimationController _revealController;

  Animation _xAxisPositionAnimation;
  Animation _yAxisPositionAnimation;

  Animation _fabRevealAnimation;

  @override
  void initState() {
    // widget.controller = AnimationController(
    //   vsync: this,
    //   duration: Duration(milliseconds: 2000),
    //   reverseDuration: Duration(milliseconds: 2000),
    // );
    _revealController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
      reverseDuration: Duration(milliseconds: 2000),
    );
    _xAxisPositionAnimation = CurvedAnimation(
      parent: widget.controller,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeOut,
    );
    _yAxisPositionAnimation = CurvedAnimation(
      parent: widget.controller,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeIn,
    );
    _fabRevealAnimation = CurvedAnimation(
      parent: _revealController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );

    widget.controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) _revealController.forward();
      // else if (status == AnimationStatus.dismissed)
      //   _revealController.reverse();
    });

    _revealController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) widget.controller.reverse();
    });
    super.initState();
  }

  @override
  void dispose() {
    // widget.controller.dispose();
    _revealController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) => AnimatedBuilder(
        animation: _revealController,
        builder: (context, child) => LayoutBuilder(
          builder: (context, constraints) => Container(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  // bottom: 0,
                  // right: 0,
                  // top: (1 - _fabRevealAnimation.value) * (320 - (_yAxisPositionAnimation.value * (180 - 70)
                  // as double)),
                  // left: (1 - _fabRevealAnimation.value) * (MediaQuery.of(context).size.width - (_xAxisPositionAnimation.value *
                  //     (MediaQuery.of(context).size.width / 2 - 56)
                  //     as double)),
                  bottom: (1 - _fabRevealAnimation.value) *
                      (_yAxisPositionAnimation.value * (180 - 70) as double),
                  right: (1 - _fabRevealAnimation.value) *
                      (_xAxisPositionAnimation.value *
                              (MediaQuery.of(context).size.width / 2 - 56)
                          as double),
                  child: GestureDetector(
                    onTap: () {
                      if (_revealController.status ==
                          AnimationStatus.completed) {
                        _revealController.reverse();
                      } else if (widget.controller.status ==
                          AnimationStatus.dismissed) {
                        widget.controller.forward();
                      }
                    },
                    child: Container(
                      height:
                          (_fabRevealAnimation.value) * constraints.maxHeight +
                              (1 - _fabRevealAnimation.value) * 64,
                      width:
                          (_fabRevealAnimation.value) * constraints.maxWidth +
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
                          Radius.circular(
                              (1 - _fabRevealAnimation.value) * 100),
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
                IgnorePointer(
                  ignoring: true,
                  child: Container(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [],
                    ),
                  ),
                ),
                Positioned(
                  bottom:
                      (_yAxisPositionAnimation.value * (180 - 70) as double),
                  right: (_xAxisPositionAnimation.value *
                      (MediaQuery.of(context).size.width / 2 - 56) as double),
                  child: GestureDetector(
                    onTap: () {
                      if (widget.controller.status == AnimationStatus.completed) {
                        widget.controller.reverse();
                      } else {
                        widget.controller.forward();
                      }
                    },
                    child: Container(
                      height: 64,
                      width: 63,
                      margin: const EdgeInsets.all(24),
                      child: FilterIcon(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}