import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

///
///How chrome extensions be enabled when flutter web debugging?
///1- Go to flutter\bin\cache and remove a file named: flutter_tools.stamp
///2- Go to flutter\packages\flutter_tools\lib\src\web and open the file chrome.dart.
///3- Find '--disable-extensions' and comment the line
///4- Run 'flutter clean' (no 100% sur its needed)
///





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
  String _htmlText = '';
  String _cors = 'CORS';
  String _htmlTitle = '';
  Future<void> loadHtmlPage() async {
    String? elem;
    String? body;
    try {
      final result = await http.get(Uri.parse(_editController.text),
      // headers: {
      //   'Content-Type': 'application/x-www-form-urlencoded',
      //   'Origin':_editController.text,
      //   'Access-Control-Allow-Origin': _editController.text
      // }
      );
      if (result.statusCode != 200) {
        throw('Error request! statusCode:${result
          .statusCode}');
      }
      body = result.body;
      var doc = parse(result.body);
      elem = doc.querySelectorAll("head > title:")[0].innerHtml;
      //var elem2 = doc.querySelectorAll("head > title:")[0];
      print(result.headers);
    } catch (e){
      print(e);
    }
    final title = elem??'no title';
    setState(() {
      _htmlTitle= title.replaceAll('\n', '').replaceAll('  ', '');
      _cors = 'CORS';
      _htmlText = body??'no body';
    });


  }

  @override
  void initState() {
    super.initState();
    _editController.text = 'https://flutter.dev';
  }

  @override
  void dispose() {
    _editController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(title: Text(_htmlTitle, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600)), centerTitle: false),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_cors, style: const TextStyle(fontSize: 16, color: Colors.redAccent),),
              const Divider(),
              Expanded(child: Center(child: Text(_htmlText))),
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
                    onPressed: () => loadHtmlPage(),
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
            ],
          )),
    );
  }
}
