import 'package:flutter/material.dart';

class ActionIconsContainer extends StatelessWidget {

  final Animation filterSheetAnimation;

  ActionIconsContainer(this.filterSheetAnimation);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: IgnorePointer(
        child: Opacity(
          opacity: 1.0 * filterSheetAnimation.value,
          child: Container(
            height: 64,
            color: Color(0xff33779C),
          ),
        ),
      ),
    );
  }
}
