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
  List<String>? folders;

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

  void setConfig() {
    folder.setPath("\\\\labn\\shared");
    folder.setUser("maxnemoy", "нфтфсруьещ");
    folder.showConfig();
  }

  void readFolders() {
    setState(() {
      folders = folder.getFolders("\\");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Column(
        children: [
          TextButton(onPressed: callIntFunc, child: const Text("Int check")),
          TextButton(
              onPressed: callStringFunc, child: const Text("String check")),
          TextButton(onPressed: setConfig, child: const Text("setup")),
          TextButton(onPressed: readFolders, child: const Text("getFolders")),
          ...folders?.map((e) => ListTile(
                    title: Text(e),
                  )) ??
              []
        ],
      )),
    );
  }
}
