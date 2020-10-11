import 'package:fab_filter/line.dart';
import 'package:flutter/material.dart';

class FilterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: const EdgeInsets.all(36),
        // shrinkWrap: true,
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Line(
                  color: Color(0xff297295),
                  height: 48,
                ),
              ),
              SizedBox(width: 16,),
              Expanded(
                flex: 2,
                child: Line(
                  color: Color(0xff297295),
                  height: 48,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Line(
                  color: Color(0xff297295),
                  height: 48,
                ),
              ),
              SizedBox(width: 16,),
              Expanded(
                flex: 3,
                child: Line(
                  color: Color(0xff297295),
                  height: 48,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Line(
                  color: Color(0xff297295),
                  height: 48,
                ),
              ),
              SizedBox(width: 16,),
              Expanded(
                flex: 2,
                child: SizedBox(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
