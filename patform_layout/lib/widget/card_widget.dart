
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:patform_layout/people.dart';

import 'detail_widget.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({
    super.key,
    required this.sizeCard,
    required this.peopleData,
  });
  final PeopleData peopleData;
  final double sizeCard;

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
      x = x - 300;
    }
    y = details.position.dy;
    if(abs(yy-y)<=250){
      y = y - 250;
    }
  }

  @override
  Widget build(BuildContext context) {
    double x2 = MediaQuery.of(context).size.width;
    return Card(
      child: MouseRegion(
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
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: CircleAvatar(

                  radius: widget.sizeCard/2,
                  backgroundImage:
                  CachedNetworkImageProvider(
                    widget.peopleData.image,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(child: Text('N.:${widget.peopleData.name}')),
                      //Text('G.:${PeopleData.peopleData[index].gender}. S.:${PeopleData.peopleData[index].status}.')
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
