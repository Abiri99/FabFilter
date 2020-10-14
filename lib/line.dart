import 'package:flutter/material.dart';

class Line extends StatefulWidget {
  final Color color;
  final Color secondaryColor;
  final double width;
  final double height;
  final bool withBadge;
  final bool tapable;

  Line({
    Key key,
    this.color,
    this.secondaryColor,
    this.width = double.infinity,
    this.height = 16,
    this.withBadge = false,
    this.tapable = false,
  }) : super(key: key);

  @override
  _LineState createState() => _LineState();
}

class _LineState extends State<Line> {

  bool _tapped;

  @override
  void initState() {
    _tapped = false;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(Line oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.tapable) {
          setState(() {
            _tapped = !_tapped;
          });
        }
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              margin: EdgeInsets.only(
                top: widget.withBadge ? 4 : 0,
              ),
              decoration: BoxDecoration(
                color: _tapped ? widget.secondaryColor : widget.color,
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
            ),
            widget.withBadge ? Positioned(
              top: widget.height / 2 - 8,
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
      ),
    );
  }
}
