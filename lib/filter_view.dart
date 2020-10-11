import 'package:fab_filter/change_notifier/filters_change_notifier.dart';
import 'package:fab_filter/line.dart';
import 'package:flutter/material.dart';

class FilterView extends StatefulWidget {
  final FiltersChangeNotifier filtersChangeNotifier;
  final int position;

  FilterView({
    Key key,
    this.filtersChangeNotifier,
    this.position,
  }) : super(key: key);

  @override
  _FilterViewState createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  bool _statusHasChanged;

  @override
  void initState() {
    _statusHasChanged = false;
    super.initState();
  }

  setStatusAsChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          children: List.generate(
            widget.filtersChangeNotifier.filters[widget.position]["data"]
                ["count"],
            (position) {
              return Container(
                margin: const EdgeInsets.all(8),
                child: Line(
                  color: Color(0xff297295),
                  secondaryColor: Theme.of(context).primaryColor,
                  tapable: false,
                  height: 48,
                  width: position == 1 || position == 2 ? constraints.maxWidth / 4 : 2 * constraints.maxWidth / 4,
                ),
              );
            },
          ),
          // children: [
          //   Container(
          //     margin: const EdgeInsets.all(8),
          //     child: Line(
          //       color: Color(0xff297295),
          //       height: 48,
          //       width: 180,
          //     ),
          //   ),
          //   Container(
          //     margin: const EdgeInsets.all(8),
          //     child: Line(
          //       color: Color(0xff297295),
          //       height: 48,
          //       width: 100,
          //     ),
          //   ),
          //   Container(
          //     margin: const EdgeInsets.all(8),
          //     child: Line(
          //       color: Color(0xff297295),
          //       height: 48,
          //       width: 100,
          //     ),
          //   ),
          //   Container(
          //     margin: const EdgeInsets.all(8),
          //     child: Line(
          //       color: Color(0xff297295),
          //       height: 48,
          //       width: 180,
          //     ),
          //   ),
          //   Container(
          //     margin: const EdgeInsets.all(8),
          //     child: Line(
          //       color: Color(0xff297295),
          //       height: 48,
          //       width: 180,
          //     ),
          //   ),
          // ],
        ),
        // child: Column(
        //   // shrinkWrap: true,
        //   children: [
        //     Row(
        //       children: [
        //         Expanded(
        //           flex: 3,
        //           child: Line(
        //             color: Color(0xff297295),
        //             height: 48,
        //           ),
        //         ),
        //         SizedBox(width: 16,),
        //         Expanded(
        //           flex: 2,
        //           child: Line(
        //             color: Color(0xff297295),
        //             height: 48,
        //           ),
        //         ),
        //       ],
        //     ),
        //     SizedBox(
        //       height: 16,
        //     ),
        //     Row(
        //       children: [
        //         Expanded(
        //           flex: 2,
        //           child: Line(
        //             color: Color(0xff297295),
        //             height: 48,
        //           ),
        //         ),
        //         SizedBox(width: 16,),
        //         Expanded(
        //           flex: 3,
        //           child: Line(
        //             color: Color(0xff297295),
        //             height: 48,
        //           ),
        //         ),
        //       ],
        //     ),
        //     SizedBox(
        //       height: 16,
        //     ),
        //     Row(
        //       children: [
        //         Expanded(
        //           flex: 3,
        //           child: Line(
        //             color: Color(0xff297295),
        //             height: 48,
        //           ),
        //         ),
        //         SizedBox(width: 16,),
        //         Expanded(
        //           flex: 2,
        //           child: SizedBox(),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
