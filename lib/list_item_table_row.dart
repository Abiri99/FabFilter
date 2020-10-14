import 'package:flutter/material.dart';

import 'line.dart';

class ListItemTableRow extends StatelessWidget {
  final bool withBackgroundColor;

  ListItemTableRow({
    this.withBackgroundColor = false,
  }) : assert(withBackgroundColor != null);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 2,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
        color: withBackgroundColor
            ? Theme.of(context).primaryColorLight.withOpacity(0.3)
            : Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 16,),
            Expanded(
              flex: 3,
              child: Line(
                color: Theme.of(context).primaryColorLight,
                height: 10,
                width: 48,
              ),
            ),
            Expanded(
              flex: 4,
              child: SizedBox(
                width: 64,
              ),
            ),
            Expanded(
              flex: 2,
              child: Line(
                color: Theme.of(context).primaryColor.withOpacity(0.5),
                height: 10,
                width: 36,
              ),
            ),
            SizedBox(width: 16,),
          ],
        ),
      ),
    );
  }
}
