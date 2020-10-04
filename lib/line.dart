import 'package:flutter/material.dart';

class Line extends StatelessWidget {
  final Color color;
  final double width;
  final double height;
  final bool withBadge;

  Line({
    Key key,
    this.color,
    this.width = double.infinity,
    this.height = 16,
    this.withBadge = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: withBadge ? 4 : 0,
            ),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
            ),
          ),
          withBadge ? Positioned(
            top: height / 2 - 8,
            right: -4,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
                border: Border.all(color: Color(0xff164A6D), width: 3,),
              ),
            ),
          ) : SizedBox(),
        ],
      ),
    );
  }
}
