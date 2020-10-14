import 'package:flutter/material.dart';

import 'list_item_table_row.dart';

class ListItemTable extends StatelessWidget {

  const ListItemTable();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(1),
      child: IgnorePointer(
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(
            right: 12,
            left: 12,
            top: 24,
          ),
          // itemExtent: 24,
          children: [
            ListItemTableRow(withBackgroundColor: false,),
            ListItemTableRow(withBackgroundColor: true,),
            ListItemTableRow(withBackgroundColor: false,),
            ListItemTableRow(withBackgroundColor: true,),
          ],
        ),
      ),
    );
  }
}
