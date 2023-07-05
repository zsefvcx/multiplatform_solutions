import 'package:flutter/material.dart';

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
          appBar: AppBar(title: const Text('Title'), centerTitle: true),
          body: Column(
            children: [
              const SizedBox(
                //height: 40,
                //width: double.infinity,
                child: Center(child: Text('cross')),
              ),
              const Divider(),
              const Expanded(child: Center(child: Text('1'))),
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
                    onPressed: () {},
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
