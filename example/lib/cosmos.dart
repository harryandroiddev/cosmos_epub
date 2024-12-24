import 'package:cosmos_epub/cosmos_epub.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cosmos extends StatefulWidget {
  @override
  _CosmosState createState() => _CosmosState();
}

class _CosmosState extends State<Cosmos> {
  Future<void> readerFuture = Future.value(true);

  Future<void> _openEpubReader(BuildContext context) async {
    await CosmosEpub.openAssetBook(
        assetPath: 'assets/gurbani.epub',
        accentColor: Colors.orange,
        context: context,
        bookId: '3',
        onPageFlip: (int currentPage, int totalPages) {
          print(currentPage);
        },
        onLastPage: (int lastPageIndex) {
          print('We arrived to the last widget');
        });
  }

  lateFuture() {
    setState(() {
      readerFuture = _openEpubReader(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CosmosEpub 💫 Reader Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            lateFuture();
          },
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.yellow),
              padding: WidgetStateProperty.all(const EdgeInsets.all(20))),
          child: FutureBuilder<void>(
            future: readerFuture, // Set the future to the async operation
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  {
                    // While waiting for the future to complete, display a loading indicator.
                    return const CupertinoActivityIndicator(
                      radius: 15,
                      color: Colors.black, // Adjust the radius as needed
                    );
                  }
                default:
                  // By default, show the button text
                  return const Text(
                    'Open book  🚀',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
