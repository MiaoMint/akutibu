import 'package:flutter/material.dart';

import 'package:flutter_akutibu/flutter_akutibu.dart' as flutter_akutibu;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String activeResult = '';

  handleGetActiveWindow() async {
    activeResult = await flutter_akutibu.getActiveWindow();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 25);
    const spacerSmall = SizedBox(height: 10);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Native Packages'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Text(
                  'This calls a native function through FFI that is shipped as source in the package. '
                  'The native code is built as part of the Flutter Runner build.',
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
                spacerSmall,
                TextField(
                  controller: TextEditingController(text: activeResult),
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Active Window',
                  ),
                  maxLines: 10,
                ),
                spacerSmall,
                ElevatedButton(
                  onPressed: handleGetActiveWindow,
                  child: const Text('Get Active Window'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
