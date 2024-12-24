import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class BookReader extends StatelessWidget {
  static const platform =
      MethodChannel('com.example.epubTextReader/folioreader');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("FolioReader Example")),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              try {
                // Load the EPUB file from assets
                String assetPath = 'assets/book.epub';
                String dir = (await getApplicationDocumentsDirectory()).path;
                String bookPath = '$dir/book.epub';

                // Copy the asset to the documents directory
                await _copyAssetToLocal(assetPath, bookPath);

                // Open the book using FolioReader
                await platform.invokeMethod('openBook', {'path': bookPath});
              } on PlatformException catch (e) {
                print("Error opening book: '${e.message}'.");
              }
            },
            child: Text("Open EPUB Book"),
          ),
        ),
      ),
    );
  }

  Future<void> _copyAssetToLocal(String assetPath, String localPath) async {
    // Read the asset from the bundle
    ByteData data = await rootBundle.load(assetPath);
    // Convert it to a list of bytes
    List<int> bytes = data.buffer.asUint8List();
    // Write the bytes to the local file
    File file = File(localPath);
    await file.writeAsBytes(bytes);
  }
}
