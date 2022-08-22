import 'package:flutter/material.dart';
import 'package:win_shared_folder/win_shared_folder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SharedFolder folder;

  @override
  void initState() {
    folder = SharedFolder();
    super.initState();
  }

  void callStringFunc() {
    debugPrint(folder.callExternalString("Hello", "Dart"));
  }

  void callIntFunc() {
    debugPrint(folder.callExternalInt(512, 512).toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Column(
        children: [
          TextButton(onPressed: callIntFunc, child: const Text("Int check")),
          TextButton(
              onPressed: callStringFunc, child: const Text("String check"))
        ],
      )),
    );
  }
}
