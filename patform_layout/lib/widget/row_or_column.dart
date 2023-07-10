
import 'package:flutter/material.dart';

class RowOrColumn extends StatelessWidget {
  const RowOrColumn({super.key,
    required this.type,
    required this.children,
  });

  final List<Widget> children;
  final int type;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: type==2?Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,):Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,),
    );
  }

}
