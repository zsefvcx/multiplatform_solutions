import 'package:flutter/material.dart';

class DetailWidget extends StatelessWidget {
  const DetailWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 250,
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Center(child: Text('VIEW PROFILE', style: TextStyle(fontWeight: FontWeight.bold),)),
            trailing: Icon(Icons.navigate_next),
          ),
          Divider(color: Colors.black),
          ListTile(
            leading: Icon(Icons.people_alt),
            title: Center(child: Text('FRIENDS', style: TextStyle(fontWeight: FontWeight.bold),)),
            trailing: Icon(Icons.navigate_next),
          ),
          Divider(color: Colors.black),
          ListTile(
            leading: Icon(Icons.list_alt),
            title: Center(child: Text('REPORT', style: TextStyle(fontWeight: FontWeight.bold),)),
            trailing: Icon(Icons.navigate_next),
          ),
        ],
      ),
    );
  }
}