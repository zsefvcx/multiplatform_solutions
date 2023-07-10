import 'package:flutter/material.dart';

class DetailWidget extends StatelessWidget {
  const DetailWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(10,0,10,0),
            child: ListTile(
              leading: Icon(Icons.person),
              title: Center(child: Text('VIEW PROFILE', style: TextStyle(fontWeight: FontWeight.bold),)),
              trailing: Icon(Icons.navigate_next),
            ),
          ),
          const Divider(color: Colors.black),
          const Padding(
            padding: EdgeInsets.fromLTRB(10,0,10,0),
            child: ListTile(
              leading: Icon(Icons.people_alt),
              title: Center(child: Text('FRIENDS', style: TextStyle(fontWeight: FontWeight.bold),)),
              trailing: Icon(Icons.navigate_next),
            ),
          ),
          const Divider(color: Colors.black),
          const Padding(
            padding: EdgeInsets.fromLTRB(10,0,10,0),
            child: ListTile(
              leading: Icon(Icons.list_alt),
              title: Center(child: Text('REPORT', style: TextStyle(fontWeight: FontWeight.bold),)),
              trailing: Icon(Icons.navigate_next),
            ),
          ),
          const Divider(color: Colors.black),
          ElevatedButton(
            style: ButtonStyle(
                minimumSize: const MaterialStatePropertyAll(Size(200,40)),
                backgroundColor: MaterialStatePropertyAll(Colors.grey.withOpacity(0.2))
            ),
            child: const Text('Close'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}