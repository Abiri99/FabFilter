import 'package:fab_filter/bottom_widgets/fab_background.dart';
import 'package:fab_filter/widgets/aibs.dart';
import 'package:fab_filter/widgets/fpv.dart';
import 'package:fab_filter/widgets/pvi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom_appbar.dart';

const String TAG = "HomePage";

class Home extends StatefulWidget {
  final Duration duration;

  Home({Key key, this.duration}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {

  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(upperBound: 2.0);
    controller.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // fit: StackFit.expand,
        alignment: Alignment.bottomCenter,
        children: [
          CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverPersistentHeader(
                delegate: CustomAppBar(),
                pinned: true,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Placeholder(
                      color: Theme.of(context).accentColor,
                      fallbackHeight: 100,
                    );
                  },
                ),
              ),
            ],
          ),
          Container(
            color: Theme.of(context).primaryColorDark,
            height: 80,
            child: Center(
              child: Text("indicator listview"),
            ),
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {

              },
              child: Container(
                height: 78,
                width: 78,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(500),
                  ),
                ),
                child: Center(
                  child: Text("fab"),
                ),
              ),
            ),
          ),

          // Container(
          //   // height: 500,
          //   alignment: Alignment.bottomCenter,
          //   // color: Colors.green.withOpacity(0.5),
          //   child: LayoutBuilder(
          //     builder: (context, constraints) => Stack(
          //       alignment: Alignment.bottomCenter,
          //       children: [
          //         PVI(
          //           animationController: _controller.view,
          //           filterAnimationController: _filterController.view,
          //           topIndicatorListHeight: topIndicatorListViewHeight,
          //           scrollController: _scrollController,
          //           animateToPage: animateToPage,
          //           fpvHeight: fpvHeight,
          //         ),
          //         FabBackground(
          //           animationController: _controller,
          //           filterAnimationController: _filterController,
          //           constraints: constraints,
          //           topIndicatorListViewHeight: topIndicatorListViewHeight,
          //           fabWidth: fabWidth,
          //           fabMargin: fabMargin,
          //           tapCallback: () {
          //             _controller.forward();
          //           },
          //           fpvHeight: fpvHeight,
          //         ),
          //         FPV(
          //           pageController: _pageController,
          //           animationController: _controller.view,
          //           filterAnimationController: _filterController.view,
          //           topIndicatorListViewHeight: topIndicatorListViewHeight,
          //           fpvHeight: fpvHeight,
          //         ),
          //         AIBS(
          //           fabWidth: fabWidth,
          //           constraints: constraints,
          //           animationController: _controller.view,
          //           filterAnimationController: _filterController.view,
          //         ),
          //         FIC(
          //           animationController: _controller.view,
          //           filterAnimationController: _filterController.view,
          //           fabWidth: fabWidth,
          //           constraints: constraints,
          //           filterControllerCallback: () {
          //             _filterController.forward();
          //           },
          //           fpvHeight: fpvHeight,
          //           // xAxisPositionAnimation: _xAxisPositionAnimation,
          //           // yAxisPositionAnimation: _yAxisPositionAnimation,
          //           // fadeOutAnimation: _fadeOutAnimation,
          //           // fabRevealAnimation: _fabRevealAnimation,
          //           // actionIconsTranslateAnimation: _actionIconTranslateAnimation,
          //         ),
          //         CI(
          //           animationController: _controller.view,
          //           filterAnimationController: _filterController.view,
          //           tapCallback: () {
          //             _controller.reverse();
          //           },
          //           fabWidth: fabWidth,
          //           // fadeOutAnimation: _fadeOutAnimation,
          //           // fabRotationAnimation: _fabRotateAnimation,
          //           // actionIconTranslateAnimation: _actionIconTranslateAnimation,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
