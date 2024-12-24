import 'package:cosmos_epub/Model/book_progress_model.dart';
import 'package:cosmos_epub/cosmos_epub.dart';
import 'package:epub_text_reader/cosmos.dart';
import 'package:epub_text_reader/home.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initializer and methods return a bool
  var _initialized = await CosmosEpub.initialize();

  if (_initialized) {
    // Use BookProgressModel model instance anywhere in your app to access current book progress of specific book
    BookProgressModel bookProgress = CosmosEpub.getBookProgress('bookId');
    await CosmosEpub.setCurrentPageIndex('bookId', 1);
    await CosmosEpub.setCurrentChapterIndex('bookId', 2);
    await CosmosEpub.deleteBookProgress('bookId');
    await CosmosEpub.deleteAllBooksProgress();
  }

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
      home: Cosmos(),
    );
  }
}
