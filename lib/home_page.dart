import 'package:fab_filter/custom_appbar.dart';
import 'package:fab_filter/filter_icon.dart';
import 'package:fab_filter/line.dart';
import 'package:flutter/material.dart';

import 'list_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: Stack(
        fit: StackFit.expand,
        children: [
          CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: CustomAppBar(),
                pinned: true,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, position) {
                    return ListItem(
                      horizontalMargin: 16,
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 24,
            right: 24,
            child: Container(
              height: 64,
              width: 64,
              padding: const EdgeInsets.all(8),
              child: Center(
                child: FilterIcon(),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
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
        ],
      ),
    );
  }
}
