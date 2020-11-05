import 'package:fab_filter/list_item.dart';
import 'package:flutter/material.dart';

class CustomListView extends StatefulWidget {
  final Animation<double> scaleAnimation;
  final Animation<double> opacityAnimation;

  CustomListView({
    this.scaleAnimation,
    this.opacityAnimation,
  });

  @override
  _CustomListViewState createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {

  animationListener() {
    setState(() {

    });
  }

  @override
  void initState() {
    widget.scaleAnimation.addListener(animationListener);
    widget.opacityAnimation.addListener(animationListener);
    super.initState();
  }

  @override
  void dispose() {
    widget.scaleAnimation.removeListener(animationListener);
    widget.opacityAnimation.removeListener(animationListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return index == 0
              ? SizedBox(
                  height: 12,
                )
              :
              // : child
              FadeTransition(
                  opacity: widget.opacityAnimation,
                  child: ScaleTransition(
                    alignment: Alignment.topCenter,
                    scale: widget.scaleAnimation,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: (1 - widget.scaleAnimation.value) * -40 + 10,
                      ),
                      child: ListItem(),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
