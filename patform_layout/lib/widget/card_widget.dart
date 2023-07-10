
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:patform_layout/people.dart';

import 'detail_widget.dart';
import 'row_or_column.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({
    super.key,
    required this.sizeCard,
    required this.peopleData,
    required this.type,
  });
  final PeopleData peopleData;
  final double sizeCard;
  final int type;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  double x = 0.0;
  double y = 0.0;

  double abs(x) => x<0?-x:x;

  void updateLocation(PointerEvent details) {
    double yy = MediaQuery.of(context).size.height;
    double xx = MediaQuery.of(context).size.width;
    x = details.position.dx;
    if(abs(xx-x)<=300){
      x = abs(x - 300);
    }
    y = details.position.dy;
    if(abs(yy-y)<=250){
      y = abs(y - 250);
    }
  }

  @override
  Widget build(BuildContext context) {
    double x2 = MediaQuery.of(context).size.width;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: updateLocation,
      child: GestureDetector(
        onTap: () {
          if (x2 < widget.sizeCard){
            showModalBottomSheet(
              isScrollControlled: true,
              useSafeArea: true,
              context: context,
              builder: (BuildContext context) {
                return const DetailWidget();
              },
            );
          } else {
            showDialog(context: context,
              builder: (context) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: y, left: x),
                    child: const Material(
                      child: DetailWidget(),
                    ),
                  ),
                );

              },);
          }
        },
        child: Card(
          elevation: 5.0,
          child: RowOrColumn(
            type: widget.type,
            children: [
              Expanded(
                flex: widget.type==2?1:2,
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        imageUrl: widget.peopleData.image,
                        fit: BoxFit.fill,

                      ),
                    ),
                  )
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      FittedBox(
                        child: Text('N.:${widget.peopleData.name}', style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold
                        ), ),
                      ),
                      if(widget.type==2)Text('G.:${widget.peopleData.gender}.'),
                      if(widget.type==2)Text('S.:${widget.peopleData.status}.'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
