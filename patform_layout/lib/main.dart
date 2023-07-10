import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patform_layout/people.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<bool> readJson() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      if (PeopleData.peopleData.isNotEmpty) PeopleData.peopleData.clear();
      final String response = await rootBundle.loadString('assets/index.json');
      final data = await json.decode(response)['results'];
      if (data != null) {
        PeopleData.fromJson(data);
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;


    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: FutureBuilder<bool>(
                future: readJson(),
                builder: (_, snap) {
                  print('FutureBuilder');
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snap.connectionState == ConnectionState.done) {
                    if (snap.hasData) {
                      bool status = snap.data ?? false;
                      if(status)
                      {
                        int length = PeopleData.peopleData.length;
                        return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 360,
                                    childAspectRatio: 3 / 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            itemCount: length,
                            itemBuilder: (BuildContext ctx, index) {
                              return const Card(
                                child: SizedBox(
                                  height: 360,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: SizedBox(
                                          height: 220,
                                          width: 220,
                                          child: CircleAvatar(
                                            minRadius: 220,
                                            maxRadius: 220,
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                              'https://rickandmortyapi.com/api/character/avatar/183.jpeg',
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child:
                                              Text('Краткое описание карточки'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    }
                    return Center(
                      child: Column(children: [
                        const Text('hasError'),
                        ElevatedButton(
                            onPressed: () => setState(() {}),
                            child: const Text('Refresh'))
                      ]),
                    );
                  } else if (snap.hasError) {
                    return Center(
                      child: Column(children: [
                        const Text('hasError'),
                        ElevatedButton(
                            onPressed: () => setState(() {}),
                            child: const Text('Refresh'))
                      ]),
                    );
                  } else {
                    return Center(
                      child: Column(children: [
                        const Text('no data'),
                        ElevatedButton(
                            onPressed: () => setState(() {}),
                            child: const Text('Refresh'))
                      ]),
                    );
                  }
                }),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
