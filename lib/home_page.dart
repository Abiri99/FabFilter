import 'package:fab_filter/custom_appbar.dart';
import 'package:fab_filter/line.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: CustomAppBar(),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, position) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryColorLight,
                        size: 16,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Line(
                                    color: Theme.of(context).primaryColorLight,
                                    height: 10,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(),
                                ),
                              ],
                            ),
                            SizedBox(height: 8,),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Line(
                                    color: Theme.of(context).primaryColorLight.withOpacity(0.5),
                                    height: 10,
                                  ),
                                ),
                                SizedBox(width: 16,),
                                Expanded(
                                  flex: 2,
                                  child: Line(
                                    color: Theme.of(context).primaryColorLight.withOpacity(0.5),
                                    height: 10,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
