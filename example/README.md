# simple_share_example

Demonstrates how to use the simple_share plugin.

## Getting Started

```
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:simple_share/simple_share.dart';
import 'package:flutter/services.dart';

void main() => runApp(SimpleShareApp());

class SimpleShareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        showPerformanceOverlay: false,
        title: 'Simple Share App',
        home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<String> getFilePath() async {
    try {
      String filePath = await FilePicker.getFilePath(type: FileType.ANY);
      if (filePath == '') {
        return "";
      }
      print("File path: " + filePath);
      return filePath;
    } on PlatformException catch (e) {
      print("Error while picking the file: " + e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('File Picker Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                SimpleShare.share(
                  title: "Share my message",
                  msg:
                      "Lorem ipsum dolor sit amet, consectetur adipisci elit, sed eiusmod " +
                          "tempor incidunt ut labore et dolore magna aliqua.",
                );
              },
              child: Text('Share text!'),
            ),
            RaisedButton(
              onPressed: () async {
                final path = await getFilePath();
                if (path != null && path.isNotEmpty) {
                  final uri = Uri.file(path);
                  SimpleShare.share(
                      uri: uri.toString(),
                      title: "Share my file",
                      msg: "My message");
                }
              },
              child: Text('Share file!'),
            ),
          ],
        ),
      ),
    );
  }
}
```