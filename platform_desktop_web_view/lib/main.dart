import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

///
///How chrome extensions be enabled when flutter web debugging?
///1- Go to flutter\bin\cache and remove a file named: flutter_tools.stamp
///2- Go to flutter\packages\flutter_tools\lib\src\web and open the file chrome.dart.
///3- Find '--disable-extensions' and comment the line
///4- Run 'flutter clean' (no 100% sur its needed)
///5- Add in Chrome https://chrome.google.com/webstore/detail/allow-cors-access-control/lhobafahddgcelffkeicbaginigeejlf/related?hl=ru

enum CustomPlatform{
  windows,
  linux,
  macos,
  ios,
  android,
  web,
  another;

  @override
  String toString(){
    switch (index){
      case 0:
        return 'windows';
      case 1:
        return 'linux';
      case 2:
        return 'macos';
      case 3:
        return 'ios';
      case 4:
        return 'android';
      case 5:
        return 'web';
      default:
        return name;
    }
  }

}

CustomPlatform _checkPlatform(){
  if(kIsWeb){
    return CustomPlatform.web;
  } else if(Platform.isWindows){
    return CustomPlatform.windows;
  } else {
    return CustomPlatform.another;
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NewWidget(),
    );
  }
}

class NewWidget extends StatefulWidget {
  const NewWidget({
    super.key,
  });

  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  final TextEditingController _editController = TextEditingController();

  Future<(String, String, String)> _loadHtmlPage() async {
    String? elem;
    String? body;
    String? cors;
    try {
      final result = await http.get(Uri.parse(_editController.text));
      if (result.statusCode != 200) {
        throw('Error request! statusCode:${result
          .statusCode}');
      }
      await Future.delayed(const Duration(seconds: 1));
      cors = 'CORS Header: ${result.headers['access-control-allow-origin']??'None'}';//?????????? то что не респонзится того и нет
      body = result.body.substring(0, 4000);//обрежем для скорости
      var doc = parse(result.body);
      elem = doc.querySelectorAll("head > title:")[0].innerHtml;
      print(result.headers);
    } catch (e){
      print(e);
    }
    String title = elem??'no title';
    return (
      cors??'-',
      title.replaceAll('\n', '').replaceAll('  ', ''),
      body??'no body',
    );
  }

  @override
  void initState() {
    print('initState');
    super.initState();
    _editController.text = 'https://flutter.dev';
  }

  @override
  void dispose() {
    print('dispose');
    _editController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    print('bild');
    return FutureBuilder<(String, String, String)>(
      future:  _loadHtmlPage(),
      builder: (_, snap) {
        print('FutureBuilder');
        if(snap.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snap.connectionState == ConnectionState.done) {
          if(snap.hasData){
           var (cors, htmlTitle, htmlText) = snap.data??('-','no title','no body');
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(title: Text(htmlTitle, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600)), centerTitle: false),
                body: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cors, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.redAccent),),
                      const Divider(),
                      Expanded(child: Center(child: WebViewWidget(
                        controller: WebViewController()
                          ..loadRequest(
                            Uri.parse(_editController.text),
                          ),
                      ),
                      )),
                      const Divider(),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                //labelText: 'URl address',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2),
                                ),
                              ),
                              minLines: 1,
                              autofocus: true,
                              controller: _editController,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => setState(() {
                              cors = '-';
                              htmlTitle = 'no title';
                              htmlText = 'no body';
                            }),
                            style: ButtonStyle(
                              minimumSize: const MaterialStatePropertyAll(Size(100,60)),
                              backgroundColor:
                              MaterialStatePropertyAll(Colors.grey.shade200),
                              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2))),
                            ),
                            child: const Text('Load'),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Center(child: Text('APPLICATION RUNNING ON ${_checkPlatform().toString().toUpperCase()}')),
                      )
                    ],
                  ),
              ),
            );
          } else if(snap.hasError) {
            return Center(
              child: Column(
                children: [
                  const Text('hasError'),
                  ElevatedButton(onPressed: ()=> setState(() {

                  }), child: const Text('Refresh'))
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                children: [
                  const Text('no data'),
                  ElevatedButton(onPressed: ()=> setState(() {

                  }), child: const Text('Refresh'))
                ],
              ),
            );
          }
        } else {
          return Center(
            child: Column(
              children: [
                const Text('no data'),
                ElevatedButton(onPressed: ()=> setState(() {

                }), child: const Text('Refresh'))
              ],
            ),
          );
        }
      });
  }
}
