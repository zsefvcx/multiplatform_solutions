import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patform_layout/people.dart';

import 'widget/widget.dart';

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
      if (PeopleData.peopleData.isNotEmpty) return true;
      await Future.delayed(const Duration(seconds: 2));
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

    const double sizeCard = 720;

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
                  //final width = MediaQuery.of(context).size.width;
                  //print('FutureBuilder');
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
                                    maxCrossAxisExtent: sizeCard/2,
                                    childAspectRatio: 3 / 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            itemCount: length,
                            itemBuilder: (_, index) {

                              return CardWidget(sizeCard: sizeCard, peopleData: PeopleData.peopleData[index],);
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
